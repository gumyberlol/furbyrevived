using UnityEngine;

public static class NGUIMath
{
	public static float Lerp(float from, float to, float factor)
	{
		return from * (1f - factor) + to * factor;
	}

	public static int ClampIndex(int val, int max)
	{
		return (val >= 0) ? ((val >= max) ? (max - 1) : val) : 0;
	}

	public static int RepeatIndex(int val, int max)
	{
		if (max < 1)
		{
			return 0;
		}
		while (val < 0)
		{
			val += max;
		}
		while (val >= max)
		{
			val -= max;
		}
		return val;
	}

	public static float WrapAngle(float angle)
	{
		while (angle > 180f)
		{
			angle -= 360f;
		}
		while (angle < -180f)
		{
			angle += 360f;
		}
		return angle;
	}

	public static float Wrap01(float val)
	{
		return val - (float)Mathf.FloorToInt(val);
	}

	public static int HexToDecimal(char ch)
	{
		switch (ch)
		{
			case '0':
				return 0;
			case '1':
				return 1;
			case '2':
				return 2;
			case '3':
				return 3;
			case '4':
				return 4;
			case '5':
				return 5;
			case '6':
				return 6;
			case '7':
				return 7;
			case '8':
				return 8;
			case '9':
				return 9;
			case 'A':
			case 'a':
				return 10;
			case 'B':
			case 'b':
				return 11;
			case 'C':
			case 'c':
				return 12;
			case 'D':
			case 'd':
				return 13;
			case 'E':
			case 'e':
				return 14;
			case 'F':
			case 'f':
				return 15;
			default:
				return 15;
		}
	}

	public static char DecimalToHexChar(int num)
	{
		if (num > 15)
		{
			return 'F';
		}
		if (num < 10)
		{
			return (char)(48 + num);
		}
		return (char)(65 + num - 10);
	}

	public static string DecimalToHex(int num)
	{
		num &= 0xFFFFFF;
		return num.ToString("X6");
	}

	public static int ColorToInt(Color c)
	{
		int num = 0;
		num |= Mathf.RoundToInt(c.r * 255f) << 24;
		num |= Mathf.RoundToInt(c.g * 255f) << 16;
		num |= Mathf.RoundToInt(c.b * 255f) << 8;
		return num | Mathf.RoundToInt(c.a * 255f);
	}

	public static Color IntToColor(int val)
	{
		float num = 0.003921569f;
		Color black = Color.black;
		black.r = num * (float)((val >> 24) & 0xFF);
		black.g = num * (float)((val >> 16) & 0xFF);
		black.b = num * (float)((val >> 8) & 0xFF);
		black.a = num * (float)(val & 0xFF);
		return black;
	}

	public static string IntToBinary(int val, int bits)
	{
		string text = string.Empty;
		int num = bits;
		while (num > 0)
		{
			if (num == 8 || num == 16 || num == 24)
			{
				text += " ";
			}
			text += (((val & (1 << --num)) == 0) ? '0' : '1');
		}
		return text;
	}

	public static Color HexToColor(uint val)
	{
		return IntToColor((int)val);
	}

	public static Rect ConvertToTexCoords(Rect rect, int width, int height)
	{
		Rect result = rect;
		if ((float)width != 0f && (float)height != 0f)
		{
			result.xMin = rect.xMin / (float)width;
			result.xMax = rect.xMax / (float)width;
			result.yMin = 1f - rect.yMax / (float)height;
			result.yMax = 1f - rect.yMin / (float)height;
		}
		return result;
	}

	public static Rect ConvertToPixels(Rect rect, int width, int height, bool round)
	{
		Rect result = rect;
		if (round)
		{
			result.xMin = Mathf.RoundToInt(rect.xMin * (float)width);
			result.xMax = Mathf.RoundToInt(rect.xMax * (float)width);
			result.yMin = Mathf.RoundToInt((1f - rect.yMax) * (float)height);
			result.yMax = Mathf.RoundToInt((1f - rect.yMin) * (float)height);
		}
		else
		{
			result.xMin = rect.xMin * (float)width;
			result.xMax = rect.xMax * (float)width;
			result.yMin = (1f - rect.yMax) * (float)height;
			result.yMax = (1f - rect.yMin) * (float)height;
		}
		return result;
	}

	public static Rect MakePixelPerfect(Rect rect)
	{
		rect.xMin = Mathf.RoundToInt(rect.xMin);
		rect.yMin = Mathf.RoundToInt(rect.yMin);
		rect.xMax = Mathf.RoundToInt(rect.xMax);
		rect.yMax = Mathf.RoundToInt(rect.yMax);
		return rect;
	}

	public static Rect MakePixelPerfect(Rect rect, int width, int height)
	{
		rect = ConvertToPixels(rect, width, height, true);
		rect.xMin = Mathf.RoundToInt(rect.xMin);
		rect.yMin = Mathf.RoundToInt(rect.yMin);
		rect.xMax = Mathf.RoundToInt(rect.xMax);
		rect.yMax = Mathf.RoundToInt(rect.yMax);
		return ConvertToTexCoords(rect, width, height);
	}

	public static Vector3 ApplyHalfPixelOffset(Vector3 pos)
	{
		// Fix: Removed the obsolete WindowsWebPlayer reference
		if (Application.platform == RuntimePlatform.WindowsPlayer || Application.platform == RuntimePlatform.WindowsEditor)
		{
			pos.x -= 0.5f;
			pos.y += 0.5f;
		}
		return pos;
	}

	public static Vector3 ApplyHalfPixelOffset(Vector3 pos, Vector3 scale)
	{
		// Fix: Removed the obsolete WindowsWebPlayer reference
		if (Application.platform == RuntimePlatform.WindowsPlayer || Application.platform == RuntimePlatform.WindowsEditor)
		{
			if (Mathf.RoundToInt(scale.x) == Mathf.RoundToInt(scale.x * 0.5f) * 2)
			{
				pos.x -= 0.5f;
			}
			if (Mathf.RoundToInt(scale.y) == Mathf.RoundToInt(scale.y * 0.5f) * 2)
			{
				pos.y += 0.5f;
			}
		}
		return pos;
	}

	public static Vector2 ConstrainRect(Vector2 minRect, Vector2 maxRect, Vector2 minArea, Vector2 maxArea)
	{
		Vector2 zero = Vector2.zero;
		float num = maxRect.x - minRect.x;
		float num2 = maxRect.y - minRect.y;
		float num3 = maxArea.x - minArea.x;
		float num4 = maxArea.y - minArea.y;
		if (num > num3)
		{
			float num5 = num - num3;
			minArea.x -= num5;
			maxArea.x += num5;
		}
		if (num2 > num4)
		{
			float num6 = num2 - num4;
			minArea.y -= num6;
			maxArea.y += num6;
		}
		if (minRect.x < minArea.x)
		{
			zero.x += minArea.x - minRect.x;
		}
		if (maxRect.x > maxArea.x)
		{
			zero.x -= maxRect.x - maxArea.x;
		}
		if (minRect.y < minArea.y)
		{
			zero.y += minArea.y - minRect.y;
		}
		if (maxRect.y > maxArea.y)
		{
			zero.y -= maxRect.y - maxArea.y;
		}
		return zero;
	}

	public static Bounds CalculateAbsoluteWidgetBounds(Transform trans)
	{
		UIWidget[] componentsInChildren = trans.GetComponentsInChildren<UIWidget>();
		if (componentsInChildren.Length == 0)
		{
			return new Bounds(trans.position, Vector3.zero);
		}
		Vector3 vector = new Vector3(float.MaxValue, float.MaxValue, float.MaxValue);
		Vector3 vector2 = new Vector3(float.MinValue, float.MinValue, float.MinValue);
		int i = 0;
		for (int num = componentsInChildren.Length; i < num; i++)
		{
			UIWidget uIWidget = componentsInChildren[i];
			Vector2 relativeSize = uIWidget.relativeSize;
			Vector2 pivotOffset = uIWidget.pivotOffset;
			float num2 = (pivotOffset.x + 0.5f) * relativeSize.x;
			float num3 = (pivotOffset.y - 0.5f) * relativeSize.y;
			relativeSize *= 0.5f;
			Transform cachedTransform = uIWidget.cachedTransform;
			Vector3 lhs = cachedTransform.TransformPoint(new Vector3(num2 - relativeSize.x, num3 - relativeSize.y, 0f));
			vector2 = Vector3.Max(lhs, vector2);
			vector = Vector3.Min(lhs, vector);
			lhs = cachedTransform.TransformPoint(new Vector3(num2 - relativeSize.x, num3 + relativeSize.y, 0f));
			vector2 = Vector3.Max(lhs, vector2);
			vector = Vector3.Min(lhs, vector);
			lhs = cachedTransform.TransformPoint(new Vector3(num2 + relativeSize.x, num3 - relativeSize.y, 0f));
			vector2 = Vector3.Max(lhs, vector2);
			vector = Vector3.Min(lhs, vector);
			lhs = cachedTransform.TransformPoint(new Vector3(num2 + relativeSize.x, num3 + relativeSize.y, 0f));
			vector2 = Vector3.Max(lhs, vector2);
			vector = Vector3.Min(lhs, vector);
		}
		Bounds result = new Bounds(vector, Vector3.zero);
		result.Encapsulate(vector2);
		return result;
	}

	public static Bounds CalculateRelativeWidgetBounds(Transform root, Transform child)
	{
		UIWidget[] componentsInChildren = child.GetComponentsInChildren<UIWidget>();
		if (componentsInChildren.Length == 0)
		{
			return new Bounds(Vector3.zero, Vector3.zero);
		}
		Vector3 vector = new Vector3(float.MaxValue, float.MaxValue, float.MaxValue);
		Vector3 vector2 = new Vector3(float.MinValue, float.MinValue, float.MinValue);
		Matrix4x4 worldToLocalMatrix = root.worldToLocalMatrix;
		int i = 0;
		for (int num = componentsInChildren.Length; i < num; i++)
		{
			UIWidget uIWidget = componentsInChildren[i];
			Vector2 relativeSize = uIWidget.relativeSize;
			Vector2 pivotOffset = uIWidget.pivotOffset;
			Transform cachedTransform = uIWidget.cachedTransform;
			float num2 = (pivotOffset.x + 0.5f) * relativeSize.x;
			float num3 = (pivotOffset.y - 0.5f) * relativeSize.y;
			relativeSize *= 0.5f;
			Vector3 position = new Vector3(num2 - relativeSize.x, num3 - relativeSize.y, 0f);
			position = cachedTransform.TransformPoint(position);
			position = worldToLocalMatrix.MultiplyPoint3x4(position);
			vector2 = Vector3.Max(position, vector2);
			vector = Vector3.Min(position, vector);
			position = new Vector3(num2 - relativeSize.x, num3 + relativeSize.y, 0f);
			position = cachedTransform.TransformPoint(position);
			position = worldToLocalMatrix.MultiplyPoint3x4(position);
			vector2 = Vector3.Max(position, vector2);
			vector = Vector3.Min(position, vector);
			position = new Vector3(num2 + relativeSize.x, num3 - relativeSize.y, 0f);
			position = cachedTransform.TransformPoint(position);
			position = worldToLocalMatrix.MultiplyPoint3x4(position);
			vector2 = Vector3.Max(position, vector2);
			vector = Vector3.Min(position, vector);
			position = new Vector3(num2 + relativeSize.x, num3 + relativeSize.y, 0f);
			position = cachedTransform.TransformPoint(position);
			position = worldToLocalMatrix.MultiplyPoint3x4(position);
			vector2 = Vector3.Max(position, vector2);
			vector = Vector3.Min(position, vector);
		}
		Bounds result = new Bounds(vector, Vector3.zero);
		result.Encapsulate(vector2);
		return result;
	}

	public static Bounds CalculateRelativeInnerBounds(Transform root, UISlicedSprite sprite)
	{
		Matrix4x4 worldToLocalMatrix = root.worldToLocalMatrix;
		Vector2 relativeSize = sprite.relativeSize;
		Vector2 pivotOffset = sprite.pivotOffset;
		Transform cachedTransform = sprite.cachedTransform;
		float num = (pivotOffset.x + 0.5f) * relativeSize.x;
		float num2 = (pivotOffset.y - 0.5f) * relativeSize.y;
		relativeSize *= 0.5f;
		float x = cachedTransform.localScale.x;
		float y = cachedTransform.localScale.y;
		Vector4 border = sprite.border;
		if (x != 0f)
		{
			border.x /= x;
			border.z /= x;
		}
		if (y != 0f)
		{
			border.y /= y;
			border.w /= y;
		}
		float x2 = num - relativeSize.x + border.x;
		float x3 = num + relativeSize.x - border.z;
		float y2 = num2 - relativeSize.y + border.y;
		float y3 = num2 + relativeSize.y - border.w;
		Vector3 position = new Vector3(x2, y2, 0f);
		position = cachedTransform.TransformPoint(position);
		position = worldToLocalMatrix.MultiplyPoint3x4(position);
		Bounds result = new Bounds(position, Vector3.zero);
		position = new Vector3(x2, y3, 0f);
		position = cachedTransform.TransformPoint(position);
		position = worldToLocalMatrix.MultiplyPoint3x4(position);
		result.Encapsulate(position);
		position = new Vector3(x3, y3, 0f);
		position = cachedTransform.TransformPoint(position);
		position = worldToLocalMatrix.MultiplyPoint3x4(position);
		result.Encapsulate(position);
		position = new Vector3(x3, y2, 0f);
		position = cachedTransform.TransformPoint(position);
		position = worldToLocalMatrix.MultiplyPoint3x4(position);
		result.Encapsulate(position);
		return result;
	}

	public static Bounds CalculateRelativeInnerBounds(Transform root, UISprite sprite)
	{
		if (sprite is UISlicedSprite)
		{
			return CalculateRelativeInnerBounds(root, sprite as UISlicedSprite);
		}
		return CalculateRelativeWidgetBounds(root, sprite.cachedTransform);
	}

	public static Bounds CalculateRelativeWidgetBounds(Transform trans)
	{
		return CalculateRelativeWidgetBounds(trans, trans);
	}

	public static Vector3 SpringDampen(ref Vector3 velocity, float strength, float deltaTime)
	{
		if (deltaTime > 1f)
		{
			deltaTime = 1f;
		}
		float num = 1f - strength * 0.001f;
		int num2 = Mathf.RoundToInt(deltaTime * 1000f);
		Vector3 zero = Vector3.zero;
		for (int i = 0; i < num2; i++)
		{
			zero += velocity * 0.06f;
			velocity *= num;
		}
		return zero;
	}

	public static Vector2 SpringDampen(ref Vector2 velocity, float strength, float deltaTime)
	{
		if (deltaTime > 1f)
		{
			deltaTime = 1f;
		}
		float num = 1f - strength * 0.001f;
		int num2 = Mathf.RoundToInt(deltaTime * 1000f);
		Vector2 zero = Vector2.zero;
		for (int i = 0; i < num2; i++)
		{
			zero += velocity * 0.06f;
			velocity *= num;
		}
		return zero;
	}

	public static float SpringLerp(float strength, float deltaTime)
	{
		if (deltaTime > 1f)
		{
			deltaTime = 1f;
		}
		int num = Mathf.RoundToInt(deltaTime * 1000f);
		deltaTime = 0.001f * strength;
		float num2 = 0f;
		for (int i = 0; i < num; i++)
		{
			num2 = Mathf.Lerp(num2, 1f, deltaTime);
		}
		return num2;
	}

	public static float SpringLerp(float from, float to, float strength, float deltaTime)
	{
		if (deltaTime > 1f)
		{
			deltaTime = 1f;
		}
		int num = Mathf.RoundToInt(deltaTime * 1000f);
		deltaTime = 0.001f * strength;
		for (int i = 0; i < num; i++)
		{
			from = Mathf.Lerp(from, to, deltaTime);
		}
		return from;
	}

	public static Vector2 SpringLerp(Vector2 from, Vector2 to, float strength, float deltaTime)
	{
		return Vector2.Lerp(from, to, SpringLerp(strength, deltaTime));
	}

	public static Vector3 SpringLerp(Vector3 from, Vector3 to, float strength, float deltaTime)
	{
		return Vector3.Lerp(from, to, SpringLerp(strength, deltaTime));
	}

	public static Quaternion SpringLerp(Quaternion from, Quaternion to, float strength, float deltaTime)
	{
		return Quaternion.Slerp(from, to, SpringLerp(strength, deltaTime));
	}

	public static float RotateTowards(float from, float to, float maxAngle)
	{
		float num = WrapAngle(to - from);
		if (Mathf.Abs(num) > maxAngle)
		{
			num = maxAngle * Mathf.Sign(num);
		}
		return from + num;
	}
}
