using UnityEngine;

[AddComponentMenu("NGUI/UI/Input (Basic)")]
public class UIInput : MonoBehaviour
{
	public enum KeyboardType
	{
		Default = 0,
		ASCIICapable = 1,
		NumbersAndPunctuation = 2,
		URL = 3,
		NumberPad = 4,
		PhonePad = 5,
		NamePhonePad = 6,
		EmailAddress = 7
	}

	public delegate char Validator(string currentText, char nextChar);

	public delegate void OnSubmit(string inputString);

	public static UIInput current;

	public UILabel label;

	public int maxChars;

	public string caratChar = "|";

	public Validator validator;

	public KeyboardType type;

	public bool isPassword;

	public Color activeColor = Color.white;

	public GameObject eventReceiver;

	public string functionName = "OnSubmit";

	public OnSubmit onSubmit;

	private string mText = string.Empty;

	private string mDefaultText = string.Empty;

	private Color mDefaultColor = Color.white;

	private UIWidget.Pivot mPivot = UIWidget.Pivot.Left;

	private float mPosition;

	private TouchScreenKeyboard mKeyboard;

	private bool mDoInit = true;

	public string text
	{
		get
		{
			return mText;
		}
		set
		{
			if (mDoInit)
			{
				Init();
			}
			mText = value;
			if (label != null)
			{
				if (string.IsNullOrEmpty(value))
				{
					value = mDefaultText;
				}
				label.supportEncoding = false;
				label.text = ((!selected) ? value : (value + caratChar));
				label.showLastPasswordChar = selected;
				label.color = ((!selected && !(value != mDefaultText)) ? mDefaultColor : activeColor);
			}
		}
	}

	public bool selected
	{
		get
		{
			return UICamera.selectedObject == base.gameObject;
		}
		set
		{
			if (!value && UICamera.selectedObject == base.gameObject)
			{
				UICamera.selectedObject = null;
			}
			else if (value)
			{
				UICamera.selectedObject = base.gameObject;
			}
		}
	}

	protected void Init()
	{
		if (mDoInit)
		{
			mDoInit = false;
			if (label == null)
			{
				label = GetComponentInChildren<UILabel>();
			}
			if (label != null)
			{
				mDefaultText = label.text;
				mDefaultColor = label.color;
				label.supportEncoding = false;
				mPivot = label.pivot;
				mPosition = label.cachedTransform.localPosition.x;
			}
			else
			{
				base.enabled = false;
			}
		}
	}

	private void OnEnable()
	{
		if (UICamera.IsHighlighted(base.gameObject))
		{
			OnSelect(true);
		}
	}

	private void OnDisable()
	{
		if (UICamera.IsHighlighted(base.gameObject))
		{
			OnSelect(false);
		}
	}

	private void OnSelect(bool isSelected)
	{
		if (mDoInit)
		{
			Init();
		}
		if (!(label != null) || !base.enabled || !NGUITools.GetActive(base.gameObject))
		{
			return;
		}
		if (isSelected)
		{
			mText = ((!(label.text == mDefaultText)) ? label.text : string.Empty);
			label.color = activeColor;
			if (isPassword)
			{
				label.password = true;
			}
			if (Application.platform == RuntimePlatform.IPhonePlayer || Application.platform == RuntimePlatform.Android)
			{
				if (isPassword)
				{
					mKeyboard = TouchScreenKeyboard.Open(mText, TouchScreenKeyboardType.Default, false, false, true);
				}
				else
				{
					mKeyboard = TouchScreenKeyboard.Open(mText, (TouchScreenKeyboardType)type);
				}
			}
			else
			{
				Input.imeCompositionMode = IMECompositionMode.On;
				Transform cachedTransform = label.cachedTransform;
				Vector3 position = label.pivotOffset;
				position.y += label.relativeSize.y;
				position = cachedTransform.TransformPoint(position);
				Input.compositionCursorPos = UICamera.currentCamera.WorldToScreenPoint(position);
			}
			UpdateLabel();
			return;
		}
		if (mKeyboard != null)
		{
			mKeyboard.active = false;
		}
		if (string.IsNullOrEmpty(mText))
		{
			label.text = mDefaultText;
			label.color = mDefaultColor;
			if (isPassword)
			{
				label.password = false;
			}
		}
		else
		{
			label.text = mText;
		}
		label.showLastPasswordChar = false;
		Input.imeCompositionMode = IMECompositionMode.Off;
		RestoreLabel();
	}

	private void Update()
	{
		if (mKeyboard == null)
		{
			return;
		}
		string text = mKeyboard.text;
		if (mText != text)
		{
			mText = string.Empty;
			for (int i = 0; i < text.Length; i++)
			{
				char c = text[i];
				if (validator != null)
				{
					c = validator(mText, c);
				}
				if (c != 0)
				{
					mText += c;
				}
			}
			if (mText != text)
			{
				mKeyboard.text = mText;
			}
			UpdateLabel();
		}
		if (mKeyboard.done)
		{
			mKeyboard = null;
			current = this;
			if (onSubmit != null)
			{
				onSubmit(mText);
			}
			if (eventReceiver == null)
			{
				eventReceiver = base.gameObject;
			}
			eventReceiver.SendMessage(functionName, mText, SendMessageOptions.DontRequireReceiver);
			current = null;
			selected = false;
		}
	}

	private void OnInput(string input)
	{
		if (mDoInit)
		{
			Init();
		}
		if (!selected || !base.enabled || !NGUITools.GetActive(base.gameObject) || Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.IPhonePlayer)
		{
			return;
		}
		int i = 0;
		for (int length = input.Length; i < length; i++)
		{
			char c = input[i];
			if (c == '\b')
			{
				if (mText.Length > 0)
				{
					mText = mText.Substring(0, mText.Length - 1);
					SendMessage("OnInputChanged", this, SendMessageOptions.DontRequireReceiver);
				}
			}
			else if (c == '\r' || c == '\n')
			{
				if ((UICamera.current.submitKey0 == KeyCode.Return || UICamera.current.submitKey1 == KeyCode.Return) && (!label.multiLine || (!Input.GetKey(KeyCode.LeftControl) && !Input.GetKey(KeyCode.RightControl))))
				{
					current = this;
					if (onSubmit != null)
					{
						onSubmit(mText);
					}
					if (eventReceiver == null)
					{
						eventReceiver = base.gameObject;
					}
					eventReceiver.SendMessage(functionName, mText, SendMessageOptions.DontRequireReceiver);
					current = null;
					selected = false;
					return;
				}
				if (validator != null)
				{
					c = validator(mText, c);
				}
				if (c == '\0')
				{
					continue;
				}
				if (c == '\n' || c == '\r')
				{
					if (label.multiLine)
					{
						mText += "\n";
					}
				}
				else
				{
					mText += c;
				}
				SendMessage("OnInputChanged", this, SendMessageOptions.DontRequireReceiver);
			}
			else if (c >= ' ')
			{
				if (validator != null)
				{
					c = validator(mText, c);
				}
				if (c != 0)
				{
					mText += c;
					SendMessage("OnInputChanged", this, SendMessageOptions.DontRequireReceiver);
				}
			}
		}
		UpdateLabel();
	}

	private void UpdateLabel()
	{
		if (mDoInit)
		{
			Init();
		}
		if (maxChars > 0 && mText.Length > maxChars)
		{
			mText = mText.Substring(0, maxChars);
		}
		if (!(label.font != null))
		{
			return;
		}
		string text = ((!selected) ? mText : (mText + Input.compositionString + caratChar));
		label.supportEncoding = false;
		if (label.multiLine)
		{
			text = label.font.WrapText(text, (float)label.lineWidth / label.cachedTransform.localScale.x, 0, false, UIFont.SymbolStyle.None);
		}
		else
		{
			string endOfLineThatFits = label.font.GetEndOfLineThatFits(text, (float)label.lineWidth / label.cachedTransform.localScale.x, false, UIFont.SymbolStyle.None);
			if (endOfLineThatFits != text)
			{
				text = endOfLineThatFits;
				Vector3 localPosition = label.cachedTransform.localPosition;
				localPosition.x = mPosition + (float)label.lineWidth;
				label.cachedTransform.localPosition = localPosition;
				if (mPivot == UIWidget.Pivot.Left)
				{
					label.pivot = UIWidget.Pivot.Right;
				}
				else if (mPivot == UIWidget.Pivot.TopLeft)
				{
					label.pivot = UIWidget.Pivot.TopRight;
				}
				else if (mPivot == UIWidget.Pivot.BottomLeft)
				{
					label.pivot = UIWidget.Pivot.BottomLeft;
				}
			}
			else
			{
				RestoreLabel();
			}
		}
		label.text = text;
		label.showLastPasswordChar = selected;
	}

	private void RestoreLabel()
	{
		if (label != null)
		{
			label.pivot = mPivot;
			Vector3 localPosition = label.cachedTransform.localPosition;
			localPosition.x = mPosition;
			label.cachedTransform.localPosition = localPosition;
		}
	}
}
