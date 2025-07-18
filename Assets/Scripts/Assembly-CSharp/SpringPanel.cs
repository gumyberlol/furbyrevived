using UnityEngine;

[RequireComponent(typeof(UIPanel))]
[AddComponentMenu("NGUI/Internal/Spring Panel")]
public class SpringPanel : IgnoreTimeScale
{
	public delegate void OnFinished();

	public Vector3 target = Vector3.zero;

	public float strength = 10f;

	public OnFinished onFinished;

	private UIPanel mPanel;

	private Transform mTrans;

	private float mThreshold;

	private UIDraggablePanel mDrag;

	private void Start()
	{
		mPanel = GetComponent<UIPanel>();
		mDrag = GetComponent<UIDraggablePanel>();
		mTrans = base.transform;
	}

	private void Update()
	{
		float deltaTime = UpdateRealTimeDelta();
		if (mThreshold == 0f)
		{
			mThreshold = (target - mTrans.localPosition).magnitude * 0.005f;
		}
		bool flag = false;
		Vector3 localPosition = mTrans.localPosition;
		Vector3 vector = ((!(strength > 0f)) ? target : NGUIMath.SpringLerp(mTrans.localPosition, target, strength, deltaTime));
		if (mThreshold >= Vector3.Magnitude(vector - target))
		{
			vector = target;
			base.enabled = false;
			flag = true;
			mThreshold = 0f;
		}
		mTrans.localPosition = vector;
		Vector3 vector2 = vector - localPosition;
		Vector4 clipRange = mPanel.clipRange;
		clipRange.x -= vector2.x;
		clipRange.y -= vector2.y;
		mPanel.clipRange = clipRange;
		if (mDrag != null)
		{
			mDrag.UpdateScrollbars(false);
		}
		if (flag && onFinished != null)
		{
			onFinished();
		}
	}

	public void SnapTo(Vector3 pos)
	{
		target = pos;
		strength = 0f;
		if (!base.enabled)
		{
			mThreshold = 0f;
		}
		onFinished = null;
		if (mPanel == null)
		{
			mPanel = GetComponent<UIPanel>();
		}
		if (mDrag == null)
		{
			mDrag = GetComponent<UIDraggablePanel>();
		}
		if (mTrans == null)
		{
			mTrans = base.transform;
		}
		Vector3 localPosition = mTrans.localPosition;
		Vector3 vector = target;
		mTrans.localPosition = vector;
		Vector3 vector2 = vector - localPosition;
		Vector4 clipRange = mPanel.clipRange;
		clipRange.x -= vector2.x;
		clipRange.y -= vector2.y;
		mPanel.clipRange = clipRange;
		if (mDrag != null)
		{
			mDrag.UpdateScrollbars(false);
		}
	}

	public static SpringPanel Begin(GameObject go, Vector3 pos, float strength)
	{
		SpringPanel springPanel = go.GetComponent<SpringPanel>();
		if (springPanel == null)
		{
			springPanel = go.AddComponent<SpringPanel>();
		}
		springPanel.target = pos;
		springPanel.strength = strength;
		springPanel.onFinished = null;
		if (!springPanel.enabled)
		{
			springPanel.mThreshold = 0f;
			springPanel.enabled = true;
		}
		return springPanel;
	}
}
