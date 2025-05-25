using UnityEngine;
using UnityEngine.InputSystem;

namespace Furby
{
	public class FingerGesturesSwipe : MonoBehaviour
	{
		public string m_leftAction;
		public string m_rightAction;

		public float m_screenWidth = 1024f;
		public int m_max;
		public int m_min = -4;
		public bool m_noBounds;
		public float m_maxSpeed = 4096f;
		public float m_maxAcceleration = 2048f;
		public float m_dampingPerSec = 0.5f;
		public bool m_rememberLocation;

		private float m_currentSpeed;
		private float m_fractionToScroll = 0.25f;
		private Vector2 m_startDragPos;
		private Vector3 m_beginPos;
		private bool m_isDragging;
		private int m_currentScreen;

		private void Start()
		{
			if (m_rememberLocation)
			{
				float value = 0f;
				// Remember the scroll position here if necessary (optional)
			}
		}

		private void Update()
		{
			HandleSwipeInput();
		}

		private void HandleSwipeInput()
		{
			// Check if touch or mouse input is active
			if (Touchscreen.current.primaryTouch.press.isPressed)  // For touch input
			{
				var touch = Touchscreen.current.primaryTouch;
				if (touch.phase.ReadValue() == UnityEngine.InputSystem.TouchPhase.Began)
				{
					m_startDragPos = touch.position.ReadValue();
					m_beginPos = transform.localPosition;
					m_isDragging = true;
				}

				if (touch.phase.ReadValue() == UnityEngine.InputSystem.TouchPhase.Moved)
				{
					HandleDrag(touch.position.ReadValue());
				}

				if (touch.phase.ReadValue() == UnityEngine.InputSystem.TouchPhase.Ended)
				{
					HandleDragEnd(touch.position.ReadValue());
				}
			}
			else if (Mouse.current.leftButton.isPressed)  // For mouse input
			{
				if (!m_isDragging)
				{
					m_startDragPos = Mouse.current.position.ReadValue();
					m_beginPos = transform.localPosition;
					m_isDragging = true;
				}
				HandleDrag(Mouse.current.position.ReadValue());
			}
			else if (!Mouse.current.leftButton.isPressed && m_isDragging)  // Mouse release
			{
				HandleDragEnd(Mouse.current.position.ReadValue());
			}
		}

		private void HandleDrag(Vector2 fingerPos)
		{
			float delta = fingerPos.x - m_startDragPos.x;
			delta /= (float)Screen.width;
			delta *= m_screenWidth;

			float f = delta / m_screenWidth;
			m_currentSpeed = delta / Time.deltaTime;

			if (Mathf.Abs(delta) > 0f)
			{
				int num2 = m_currentScreen + (int)Mathf.Sign(delta);
				if (!m_noBounds && (num2 > m_max || num2 < m_min))
				{
					delta = m_screenWidth * Mathf.Sign(f);  // Stops movement if it exceeds bounds
					m_currentSpeed = 0f;
				}
				else
				{
					delta = m_screenWidth * Mathf.Sign(f);
				}
			}

			transform.localPosition = m_beginPos + new Vector3(delta, 0f, 0f);
		}

		private void HandleDragEnd(Vector2 fingerPos)
		{
			float num = fingerPos.x - m_startDragPos.x;
			num /= (float)Screen.width;
			num *= m_screenWidth;

			if (Mathf.Abs(num) > m_fractionToScroll)
			{
				int currentScreen = m_currentScreen;
				m_currentScreen += (int)Mathf.Sign(num);
				if (!m_noBounds)
				{
					m_currentScreen = Mathf.Clamp(m_currentScreen, m_min, m_max);
				}

				// Notify listeners that drag motion has ended
				// For example, broadcast the message to notify a UI transition
			}

			m_isDragging = false;
		}

		// You can add your own methods for OnScrollLeft and OnScrollRight, similar to your original code.
	}
}
