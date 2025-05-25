using UnityEngine;
using UnityEngine.UI;

namespace Relentless
{
	public class GuiTextureFullscreen : RelentlessMonoBehaviour
	{
		private Image _image;

		private void Awake()
		{
			_image = GetComponent<Image>();
			if (_image != null)
			{
				// Set RectTransform to cover full screen
				RectTransform rt = _image.rectTransform;
				rt.anchorMin = Vector2.zero;
				rt.anchorMax = Vector2.one;
				rt.offsetMin = Vector2.zero;
				rt.offsetMax = Vector2.zero;
			}
		}
	}
}
