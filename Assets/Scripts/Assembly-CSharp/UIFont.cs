using System.Collections.Generic;
using System.Text;
using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("NGUI/UI/Font")]
public class UIFont : MonoBehaviour
{
	public enum Alignment
	{
		Left = 0,
		Center = 1,
		Right = 2
	}

	public enum SymbolStyle
	{
		None = 0,
		Uncolored = 1,
		Colored = 2
	}

	[HideInInspector]
	[SerializeField]
	private Material mMat;

	[HideInInspector]
	[SerializeField]
	private Rect mUVRect = new Rect(0f, 0f, 1f, 1f);

	[HideInInspector]
	[SerializeField]
	private BMFont mFont = new BMFont();

	[SerializeField]
	[HideInInspector]
	private int mSpacingX;

	[HideInInspector]
	[SerializeField]
	private int mSpacingY;

	[SerializeField]
	[HideInInspector]
	private UIAtlas mAtlas;

	[HideInInspector]
	[SerializeField]
	private UIFont mReplacement;

	private UIAtlas.Sprite mSprite;

	private bool mSpriteSet;

	private List<Color> mColors = new List<Color>();

	public BMFont bmFont
	{
		get
		{
			return (!(mReplacement != null)) ? mFont : mReplacement.bmFont;
		}
	}

	public int texWidth
	{
		get
		{
			return (mReplacement != null) ? mReplacement.texWidth : ((mFont == null) ? 1 : mFont.texWidth);
		}
	}

	public int texHeight
	{
		get
		{
			return (mReplacement != null) ? mReplacement.texHeight : ((mFont == null) ? 1 : mFont.texHeight);
		}
	}

	public UIAtlas atlas
	{
		get
		{
			return (!(mReplacement != null)) ? mAtlas : mReplacement.atlas;
		}
		set
		{
			if (mReplacement != null)
			{
				mReplacement.atlas = value;
			}
			else
			{
				if (!(mAtlas != value))
				{
					return;
				}
				if (value == null)
				{
					if (mAtlas != null)
					{
						mMat = mAtlas.spriteMaterial;
					}
					if (sprite != null)
					{
						mUVRect = uvRect;
					}
				}
				mAtlas = value;
				MarkAsDirty();
			}
		}
	}

	public Material material
	{
		get
		{
			if (mReplacement != null)
			{
				return mReplacement.material;
			}
			return (!(mAtlas != null)) ? mMat : mAtlas.spriteMaterial;
		}
		set
		{
			if (mReplacement != null)
			{
				mReplacement.material = value;
			}
			else if (mAtlas == null && mMat != value)
			{
				mMat = value;
				MarkAsDirty();
			}
		}
	}

	public Texture2D texture
	{
		get
		{
			if (mReplacement != null)
			{
				return mReplacement.texture;
			}
			Material material = this.material;
			return (!(material != null)) ? null : (material.mainTexture as Texture2D);
		}
	}

	public Rect uvRect
	{
		get
		{
			if (mReplacement != null)
			{
				return mReplacement.uvRect;
			}
			if (mAtlas != null && mSprite == null && sprite != null)
			{
				Texture texture = mAtlas.texture;
				if (texture != null)
				{
					mUVRect = mSprite.outer;
					if (mAtlas.coordinates == UIAtlas.Coordinates.Pixels)
					{
						mUVRect = NGUIMath.ConvertToTexCoords(mUVRect, texture.width, texture.height);
					}
					if (mSprite.hasPadding)
					{
						Rect rect = mUVRect;
						mUVRect.xMin = rect.xMin - mSprite.paddingLeft * rect.width;
						mUVRect.yMin = rect.yMin - mSprite.paddingBottom * rect.height;
						mUVRect.xMax = rect.xMax + mSprite.paddingRight * rect.width;
						mUVRect.yMax = rect.yMax + mSprite.paddingTop * rect.height;
					}
					if (mSprite.hasPadding)
					{
						Trim();
					}
				}
			}
			return mUVRect;
		}
		set
		{
			if (mReplacement != null)
			{
				mReplacement.uvRect = value;
			}
			else if (sprite == null && mUVRect != value)
			{
				mUVRect = value;
				MarkAsDirty();
			}
		}
	}

	public string spriteName
	{
		get
		{
			return (!(mReplacement != null)) ? mFont.spriteName : mReplacement.spriteName;
		}
		set
		{
			if (mReplacement != null)
			{
				mReplacement.spriteName = value;
			}
			else if (mFont.spriteName != value)
			{
				mFont.spriteName = value;
				MarkAsDirty();
			}
		}
	}

	public int horizontalSpacing
	{
		get
		{
			return (!(mReplacement != null)) ? mSpacingX : mReplacement.horizontalSpacing;
		}
		set
		{
			if (mReplacement != null)
			{
				mReplacement.horizontalSpacing = value;
			}
			else if (mSpacingX != value)
			{
				mSpacingX = value;
				MarkAsDirty();
			}
		}
	}

	public int verticalSpacing
	{
		get
		{
			return (!(mReplacement != null)) ? mSpacingY : mReplacement.verticalSpacing;
		}
		set
		{
			if (mReplacement != null)
			{
				mReplacement.verticalSpacing = value;
			}
			else if (mSpacingY != value)
			{
				mSpacingY = value;
				MarkAsDirty();
			}
		}
	}

	public int size
	{
		get
		{
			return (!(mReplacement != null)) ? mFont.charSize : mReplacement.size;
		}
	}

	public UIAtlas.Sprite sprite
	{
		get
		{
			if (mReplacement != null)
			{
				return mReplacement.sprite;
			}
			if (!mSpriteSet)
			{
				mSprite = null;
			}
			if (mSprite == null && mAtlas != null && !string.IsNullOrEmpty(mFont.spriteName))
			{
				mSprite = mAtlas.GetSprite(mFont.spriteName);
				if (mSprite == null)
				{
					mSprite = mAtlas.GetSprite(base.name);
				}
				mSpriteSet = true;
				if (mSprite == null)
				{
					Debug.LogError("Can't find the sprite '" + mFont.spriteName + "' in UIAtlas on " + NGUITools.GetHierarchy(mAtlas.gameObject));
					mFont.spriteName = null;
				}
			}
			return mSprite;
		}
	}

	public UIFont replacement
	{
		get
		{
			return mReplacement;
		}
		set
		{
			UIFont uIFont = value;
			if (uIFont == this)
			{
				uIFont = null;
			}
			if (mReplacement != uIFont)
			{
				if (uIFont != null && uIFont.replacement == this)
				{
					uIFont.replacement = null;
				}
				if (mReplacement != null)
				{
					MarkAsDirty();
				}
				mReplacement = uIFont;
				MarkAsDirty();
			}
		}
	}

	private void Trim()
	{
		Texture texture = mAtlas.texture;
		if (texture != null && mSprite != null)
		{
			Rect rect = NGUIMath.ConvertToPixels(mUVRect, this.texture.width, this.texture.height, true);
			Rect rect2 = ((mAtlas.coordinates != UIAtlas.Coordinates.TexCoords) ? mSprite.outer : NGUIMath.ConvertToPixels(mSprite.outer, texture.width, texture.height, true));
			int xMin = Mathf.RoundToInt(rect2.xMin - rect.xMin);
			int yMin = Mathf.RoundToInt(rect2.yMin - rect.yMin);
			int xMax = Mathf.RoundToInt(rect2.xMax - rect.xMin);
			int yMax = Mathf.RoundToInt(rect2.yMax - rect.yMin);
			mFont.Trim(xMin, yMin, xMax, yMax);
		}
	}

	private bool References(UIFont font)
	{
		if (font == null)
		{
			return false;
		}
		if (font == this)
		{
			return true;
		}
		return mReplacement != null && mReplacement.References(font);
	}

	public static bool CheckIfRelated(UIFont a, UIFont b)
	{
		if (a == null || b == null)
		{
			return false;
		}
		return a == b || a.References(b) || b.References(a);
	}

	public void MarkAsDirty()
	{
		if (mReplacement != null)
		{
			mReplacement.MarkAsDirty();
			return;
		}
		mSprite = null;
		UILabel[] array = NGUITools.FindActive<UILabel>();
		int i = 0;
		for (int num = array.Length; i < num; i++)
		{
			UILabel uILabel = array[i];
			if (uILabel.enabled && NGUITools.GetActive(uILabel.gameObject) && CheckIfRelated(this, uILabel.font))
			{
				UIFont font = uILabel.font;
				uILabel.font = null;
				uILabel.font = font;
			}
		}
	}

	public Vector2 CalculatePrintedSize(string text, bool encoding, SymbolStyle symbolStyle)
	{
		if (mReplacement != null)
		{
			return mReplacement.CalculatePrintedSize(text, encoding, symbolStyle);
		}
		Vector2 zero = Vector2.zero;
		if (mFont != null && mFont.isValid && !string.IsNullOrEmpty(text))
		{
			if (encoding)
			{
				text = NGUITools.StripSymbols(text);
			}
			int length = text.Length;
			int num = 0;
			int num2 = 0;
			int num3 = 0;
			int num4 = 0;
			int num5 = mFont.charSize + mSpacingY;
			for (int i = 0; i < length; i++)
			{
				char c = text[i];
				if (c == '\n')
				{
					if (num2 > num)
					{
						num = num2;
					}
					num2 = 0;
					num3 += num5;
					num4 = 0;
					continue;
				}
				if (c < ' ')
				{
					num4 = 0;
					continue;
				}
				BMSymbol bMSymbol = ((!encoding || symbolStyle == SymbolStyle.None) ? null : mFont.MatchSymbol(text, i, length));
				if (bMSymbol == null)
				{
					BMGlyph glyph = mFont.GetGlyph(c);
					if (glyph != null)
					{
						num2 += mSpacingX + ((num4 == 0) ? glyph.advance : (glyph.advance + glyph.GetKerning(num4)));
						num4 = c;
					}
				}
				else
				{
					num2 += mSpacingX + bMSymbol.width;
					i += bMSymbol.length - 1;
					num4 = 0;
				}
			}
			float num6 = ((mFont.charSize <= 0) ? 1f : (1f / (float)mFont.charSize));
			zero.x = num6 * (float)((num2 <= num) ? num : num2);
			zero.y = num6 * (float)(num3 + num5);
		}
		return zero;
	}

	private static void EndLine(ref StringBuilder s)
	{
		int num = s.Length - 1;
		if (num > 0 && s[num] == ' ')
		{
			s[num] = '\n';
		}
		else
		{
			s.Append('\n');
		}
	}

	public string GetEndOfLineThatFits(string text, float maxWidth, bool encoding, SymbolStyle symbolStyle)
	{
		if (mReplacement != null)
		{
			return mReplacement.GetEndOfLineThatFits(text, maxWidth, encoding, symbolStyle);
		}
		int num = Mathf.RoundToInt(maxWidth * (float)size);
		if (num < 1)
		{
			return text;
		}
		int length = text.Length;
		int num2 = num;
		BMGlyph bMGlyph = null;
		int num3 = length;
		while (num3 > 0 && num2 > 0)
		{
			char c = text[--num3];
			BMSymbol bMSymbol = ((!encoding || symbolStyle == SymbolStyle.None) ? null : mFont.MatchSymbol(text, num3, length));
			BMGlyph bMGlyph2 = ((bMSymbol != null) ? null : mFont.GetGlyph(c));
			int num4 = mSpacingX;
			if (bMSymbol != null)
			{
				num4 += bMSymbol.width;
			}
			else
			{
				if (bMGlyph2 == null)
				{
					bMGlyph = null;
					continue;
				}
				num4 += bMGlyph2.advance + ((bMGlyph != null) ? bMGlyph.GetKerning(c) : 0);
				bMGlyph = bMGlyph2;
			}
			num2 -= num4;
		}
		if (num2 < 0)
		{
			num3++;
		}
		return text.Substring(num3, length - num3);
	}

	public string WrapText(string text, float maxWidth, int maxLineCount, bool encoding, SymbolStyle symbolStyle)
	{
		if (mReplacement != null)
		{
			return mReplacement.WrapText(text, maxWidth, maxLineCount, encoding, symbolStyle);
		}
		int num = Mathf.RoundToInt(maxWidth * (float)size);
		if (num < 1)
		{
			return text;
		}
		StringBuilder s = new StringBuilder();
		int length = text.Length;
		int num2 = num;
		int num3 = 0;
		int i = 0;
		int j = 0;
		bool flag = true;
		bool flag2 = maxLineCount != 1;
		int num4 = 1;
		for (; j < length; j++)
		{
			char c = text[j];
			if (c == '\n')
			{
				if (!flag2 || num4 == maxLineCount)
				{
					break;
				}
				num2 = num;
				if (i < j)
				{
					s.Append(text.Substring(i, j - i + 1));
				}
				else
				{
					s.Append(c);
				}
				flag = true;
				num4++;
				i = j + 1;
				num3 = 0;
				continue;
			}
			if (c == ' ' && num3 != 32 && i < j)
			{
				s.Append(text.Substring(i, j - i + 1));
				flag = false;
				i = j + 1;
				num3 = c;
			}
			if (encoding && c == '[' && j + 2 < length)
			{
				if (text[j + 1] == '-' && text[j + 2] == ']')
				{
					j += 2;
					continue;
				}
				if (j + 7 < length && text[j + 7] == ']' && NGUITools.EncodeColor(NGUITools.ParseColor(text, j + 1)) == text.Substring(j + 1, 6).ToUpper())
				{
					j += 7;
					continue;
				}
			}
			BMSymbol bMSymbol = ((!encoding || symbolStyle == SymbolStyle.None) ? null : mFont.MatchSymbol(text, j, length));
			BMGlyph bMGlyph = ((bMSymbol != null) ? null : mFont.GetGlyph(c));
			int num5 = mSpacingX;
			if (bMSymbol != null)
			{
				num5 += bMSymbol.width;
			}
			else
			{
				if (bMGlyph == null)
				{
					continue;
				}
				num5 += ((num3 == 0) ? bMGlyph.advance : (bMGlyph.advance + bMGlyph.GetKerning(num3)));
			}
			num2 -= num5;
			if (num2 < 0)
			{
				if (!flag && flag2 && num4 != maxLineCount)
				{
					for (; i < length && text[i] == ' '; i++)
					{
					}
					flag = true;
					num2 = num;
					j = i - 1;
					num3 = 0;
					if (!flag2 || num4 == maxLineCount)
					{
						break;
					}
					num4++;
					EndLine(ref s);
					continue;
				}
				s.Append(text.Substring(i, Mathf.Max(0, j - i)));
				if (!flag2 || num4 == maxLineCount)
				{
					i = j;
					break;
				}
				EndLine(ref s);
				flag = true;
				num4++;
				if (c == ' ')
				{
					i = j + 1;
					num2 = num;
				}
				else
				{
					i = j;
					num2 = num - num5;
				}
				num3 = 0;
			}
			else
			{
				num3 = c;
			}
			if (bMSymbol != null)
			{
				j += bMSymbol.length - 1;
				num3 = 0;
			}
		}
		if (i < j)
		{
			s.Append(text.Substring(i, j - i));
		}
		return s.ToString();
	}

	public string WrapText(string text, float maxWidth, int maxLineCount, bool encoding)
	{
		return WrapText(text, maxWidth, maxLineCount, encoding, SymbolStyle.None);
	}

	public string WrapText(string text, float maxWidth, int maxLineCount)
	{
		return WrapText(text, maxWidth, maxLineCount, false, SymbolStyle.None);
	}

	private void Align(BetterList<Vector3> verts, int indexOffset, Alignment alignment, int x, int lineWidth)
	{
		if (alignment != Alignment.Left && mFont.charSize > 0)
		{
			float f = ((alignment != Alignment.Right) ? ((float)(lineWidth - x) * 0.5f) : ((float)(lineWidth - x)));
			f = Mathf.RoundToInt(f);
			if (f < 0f)
			{
				f = 0f;
			}
			f /= (float)mFont.charSize;
			for (int i = indexOffset; i < verts.size; i++)
			{
				Vector3 vector = verts.buffer[i];
				vector.x += f;
				verts.buffer[i] = vector;
			}
		}
	}

	public void Print(string text, Color32 color, BetterList<Vector3> verts, BetterList<Vector2> uvs, BetterList<Color32> cols, bool encoding, SymbolStyle symbolStyle, Alignment alignment, int lineWidth)
	{
		if (mReplacement != null)
		{
			mReplacement.Print(text, color, verts, uvs, cols, encoding, symbolStyle, alignment, lineWidth);
		}
		else
		{
			if (mFont == null || text == null)
			{
				return;
			}
			if (!mFont.isValid)
			{
				Debug.LogError("Attempting to print using an invalid font!");
				return;
			}
			mColors.Clear();
			mColors.Add(color);
			Vector2 vector = ((mFont.charSize <= 0) ? Vector2.one : new Vector2(1f / (float)mFont.charSize, 1f / (float)mFont.charSize));
			int num = verts.size;
			int num2 = 0;
			int num3 = 0;
			int num4 = 0;
			int num5 = 0;
			int num6 = mFont.charSize + mSpacingY;
			Vector3 zero = Vector3.zero;
			Vector3 zero2 = Vector3.zero;
			Vector2 zero3 = Vector2.zero;
			Vector2 zero4 = Vector2.zero;
			float num7 = uvRect.width / (float)mFont.texWidth;
			float num8 = mUVRect.height / (float)mFont.texHeight;
			int length = text.Length;
			for (int i = 0; i < length; i++)
			{
				char c = text[i];
				if (c == '\n')
				{
					if (num3 > num2)
					{
						num2 = num3;
					}
					if (alignment != Alignment.Left)
					{
						Align(verts, num, alignment, num3, lineWidth);
						num = verts.size;
					}
					num3 = 0;
					num4 += num6;
					num5 = 0;
					continue;
				}
				if (c < ' ')
				{
					num5 = 0;
					continue;
				}
				if (encoding && c == '[')
				{
					int num9 = NGUITools.ParseSymbol(text, i, mColors);
					if (num9 > 0)
					{
						color = mColors[mColors.Count - 1];
						i += num9 - 1;
						continue;
					}
				}
				BMSymbol bMSymbol = ((!encoding || symbolStyle == SymbolStyle.None) ? null : mFont.MatchSymbol(text, i, length));
				if (bMSymbol == null)
				{
					BMGlyph glyph = mFont.GetGlyph(c);
					if (glyph == null)
					{
						continue;
					}
					if (num5 != 0)
					{
						num3 += glyph.GetKerning(num5);
					}
					if (c == ' ')
					{
						num3 += mSpacingX + glyph.advance;
						num5 = c;
						continue;
					}
					zero.x = vector.x * (float)(num3 + glyph.offsetX);
					zero.y = (0f - vector.y) * (float)(num4 + glyph.offsetY);
					zero2.x = zero.x + vector.x * (float)glyph.width;
					zero2.y = zero.y - vector.y * (float)glyph.height;
					zero3.x = mUVRect.xMin + num7 * (float)glyph.x;
					zero3.y = mUVRect.yMax - num8 * (float)glyph.y;
					zero4.x = zero3.x + num7 * (float)glyph.width;
					zero4.y = zero3.y - num8 * (float)glyph.height;
					num3 += mSpacingX + glyph.advance;
					num5 = c;
					if (glyph.channel == 0 || glyph.channel == 15)
					{
						for (int j = 0; j < 4; j++)
						{
							cols.Add(color);
						}
					}
					else
					{
						Color color2 = color;
						color2 *= 0.49f;
						switch (glyph.channel)
						{
						case 1:
							color2.b += 0.51f;
							break;
						case 2:
							color2.g += 0.51f;
							break;
						case 4:
							color2.r += 0.51f;
							break;
						case 8:
							color2.a += 0.51f;
							break;
						}
						for (int k = 0; k < 4; k++)
						{
							cols.Add(color2);
						}
					}
				}
				else
				{
					zero.x = vector.x * (float)num3;
					zero.y = (0f - vector.y) * (float)num4;
					zero2.x = zero.x + vector.x * (float)bMSymbol.width;
					zero2.y = zero.y - vector.y * (float)bMSymbol.height;
					zero3.x = mUVRect.xMin + num7 * (float)bMSymbol.x;
					zero3.y = mUVRect.yMax - num8 * (float)bMSymbol.y;
					zero4.x = zero3.x + num7 * (float)bMSymbol.width;
					zero4.y = zero3.y - num8 * (float)bMSymbol.height;
					num3 += mSpacingX + bMSymbol.width;
					i += bMSymbol.length - 1;
					num5 = 0;
					if (symbolStyle == SymbolStyle.Colored)
					{
						for (int l = 0; l < 4; l++)
						{
							cols.Add(color);
						}
					}
					else
					{
						Color32 item = Color.white;
						item.a = color.a;
						for (int m = 0; m < 4; m++)
						{
							cols.Add(item);
						}
					}
				}
				verts.Add(new Vector3(zero2.x, zero.y));
				verts.Add(new Vector3(zero2.x, zero2.y));
				verts.Add(new Vector3(zero.x, zero2.y));
				verts.Add(new Vector3(zero.x, zero.y));
				uvs.Add(new Vector2(zero4.x, zero3.y));
				uvs.Add(new Vector2(zero4.x, zero4.y));
				uvs.Add(new Vector2(zero3.x, zero4.y));
				uvs.Add(new Vector2(zero3.x, zero3.y));
			}
			if (alignment != Alignment.Left && num < verts.size)
			{
				Align(verts, num, alignment, num3, lineWidth);
				num = verts.size;
			}
		}
	}
}
