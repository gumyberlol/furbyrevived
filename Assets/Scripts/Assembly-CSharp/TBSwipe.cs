using UnityEngine;
using UnityEngine.InputSystem;
using System;

namespace Furby
{
	[AddComponentMenu("Toolbox/Swipe")]
	public class TBSwipe : MonoBehaviour
	{
		public bool swipeLeft = true;
		public bool swipeRight = true;
		public bool swipeUp = true;
		public bool swipeDown = true;

		public float minVelocity = 1000f;

		public Action OnSwipe;
		public Action OnSwipeLeft;
		public Action OnSwipeRight;
		public Action OnSwipeUp;
		public Action OnSwipeDown;

		private Vector2 startTouchPos;
		private Vector2 endTouchPos;
		private float swipeStartTime;
		private bool isSwiping = false;

		private void Update()
		{
			HandleInput();
		}

		private void HandleInput()
		{
			// Detect touch input
			if (Touchscreen.current.primaryTouch.press.isPressed)
			{
				if (!isSwiping)
				{
					// Start swipe
					startTouchPos = Touchscreen.current.primaryTouch.position.ReadValue();
					swipeStartTime = Time.time;
					isSwiping = true;
				}

				endTouchPos = Touchscreen.current.primaryTouch.position.ReadValue();
			}
			else if (isSwiping)
			{
				// End swipe
				float swipeDuration = Time.time - swipeStartTime;
				float swipeDistance = (endTouchPos - startTouchPos).magnitude;
				float swipeVelocity = swipeDistance / swipeDuration;

				if (swipeVelocity >= minVelocity)
				{
					Vector2 swipeDelta = endTouchPos - startTouchPos;
					SwipeDirection direction = GetSwipeDirection(swipeDelta);

					// Raise swipe event based on direction
					if (direction != SwipeDirection.None)
					{
						RaiseSwipe(direction, swipeVelocity);
					}
				}

				isSwiping = false; // Reset after swipe is completed
			}
		}

		private void RaiseSwipe(SwipeDirection direction, float velocity)
		{
			if (IsValid(direction))
			{
				OnSwipe?.Invoke();  // Generic OnSwipe event

				// Direction-specific events
				switch (direction)
				{
					case SwipeDirection.Left:
						OnSwipeLeft?.Invoke();
						break;
					case SwipeDirection.Right:
						OnSwipeRight?.Invoke();
						break;
					case SwipeDirection.Up:
						OnSwipeUp?.Invoke();
						break;
					case SwipeDirection.Down:
						OnSwipeDown?.Invoke();
						break;
				}
			}
		}

		private bool IsValid(SwipeDirection direction)
		{
			switch (direction)
			{
				case SwipeDirection.Left:
					return swipeLeft;
				case SwipeDirection.Right:
					return swipeRight;
				case SwipeDirection.Up:
					return swipeUp;
				case SwipeDirection.Down:
					return swipeDown;
				default:
					return false;
			}
		}

		private SwipeDirection GetSwipeDirection(Vector2 delta)
		{
			if (Mathf.Abs(delta.x) > Mathf.Abs(delta.y))
			{
				if (delta.x > 0)
					return SwipeDirection.Right;
				else
					return SwipeDirection.Left;
			}
			else
			{
				if (delta.y > 0)
					return SwipeDirection.Up;
				else
					return SwipeDirection.Down;
			}
		}

		private enum SwipeDirection
		{
			None,
			Left,
			Right,
			Up,
			Down
		}
	}
}
