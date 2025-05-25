using UnityEngine;

namespace Furby
{
	public class ScrollButton : MonoBehaviour
	{
		public bool m_leftButton;
		public float contentWidth = 1000f;
		public float viewportWidth = 400f;
		public float scrollPosition = 0f;

		private UIButton m_buttonComponent;

		private void Start()
		{
			m_buttonComponent = GetComponent<UIButton>();
		}

		private void Update()
		{
			if (m_buttonComponent == null)
				return;

			bool canScrollLeft = scrollPosition > 0f;
			bool canScrollRight = scrollPosition < contentWidth - viewportWidth;

			bool enable = false;

			if (m_leftButton && canScrollLeft)
			{
				enable = true;
			}
			else if (!m_leftButton && canScrollRight)
			{
				enable = true;
			}

			m_buttonComponent.isEnabled = enable;
		}

		// Optional: call this from other scripts to update position
		public void SetScrollPosition(float pos)
		{
			scrollPosition = Mathf.Clamp(pos, 0f, contentWidth - viewportWidth);
		}
	}
}
