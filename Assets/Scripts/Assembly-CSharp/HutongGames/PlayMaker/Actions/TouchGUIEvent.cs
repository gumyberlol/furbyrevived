using UnityEngine;
using UnityEngine.UIElements;  // Make sure to include UIElements

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Sends events when a GUI Texture or GUI Text is touched. Optionally filter by a fingerID.")]
	[ActionCategory(ActionCategory.Device)]
	public class TouchGUIEvent : FsmStateAction
	{
		public enum OffsetOptions
		{
			TopLeft = 0,
			Center = 1,
			TouchStart = 2
		}

		[CheckForComponent(typeof(VisualElement))] // Replace GUIElement with VisualElement
		[Tooltip("The Game Object that owns the GUI Texture or GUI Text.")]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		public FsmInt fingerId;
		public FsmEvent touchBegan;
		public FsmEvent touchMoved;
		public FsmEvent touchStationary;
		public FsmEvent touchEnded;
		public FsmEvent touchCanceled;
		public FsmEvent notTouching;
		public FsmInt storeFingerId;
		public FsmVector3 storeHitPoint;
		public FsmBool normalizeHitPoint;
		public FsmVector3 storeOffset;
		public OffsetOptions relativeTo;
		public FsmBool normalizeOffset;
		public bool everyFrame;

		private Vector3 touchStartPos;
		private VisualElement visualElement;  // Changed from GUIElement to VisualElement

		public override void Reset()
		{
			gameObject = null;
			fingerId = new FsmInt { UseVariable = true };
			touchBegan = null;
			touchMoved = null;
			touchStationary = null;
			touchEnded = null;
			touchCanceled = null;
			storeFingerId = null;
			storeHitPoint = null;
			normalizeHitPoint = false;
			storeOffset = null;
			relativeTo = OffsetOptions.Center;
			normalizeOffset = true;
			everyFrame = true;
		}

		public override void OnEnter()
		{
			DoTouchGUIEvent();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoTouchGUIEvent();
		}

		private void DoTouchGUIEvent()
		{
			if (Input.touchCount <= 0)
			{
				return;
			}
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget == null)
			{
				return;
			}

			// Replace GUIElement with VisualElement, which is part of UIElements
			visualElement = ownerDefaultTarget.GetComponent<UIDocument>().rootVisualElement;

			if (visualElement != null)
			{
				Touch[] touches = Input.touches;
				foreach (Touch touch in touches)
				{
					DoTouch(touch);
				}
			}
		}

		private void DoTouch(Touch touch)
		{
			if (!fingerId.IsNone && touch.fingerId != fingerId.Value)
			{
				return;
			}
			Vector3 vector = touch.position;
			if (visualElement.worldBound.Contains(new Vector2(vector.x, vector.y)))
			{
				if (touch.phase == TouchPhase.Began)
				{
					touchStartPos = vector;
				}
				storeFingerId.Value = touch.fingerId;
				if (normalizeHitPoint.Value)
				{
					vector.x /= Screen.width;
					vector.y /= Screen.height;
				}
				storeHitPoint.Value = vector;
				DoTouchOffset(vector);
				switch (touch.phase)
				{
					case TouchPhase.Began:
						base.Fsm.Event(touchBegan);
						break;
					case TouchPhase.Moved:
						base.Fsm.Event(touchMoved);
						break;
					case TouchPhase.Stationary:
						base.Fsm.Event(touchStationary);
						break;
					case TouchPhase.Ended:
						base.Fsm.Event(touchEnded);
						break;
					case TouchPhase.Canceled:
						base.Fsm.Event(touchCanceled);
						break;
				}
			}
			else
			{
				base.Fsm.Event(notTouching);
			}
		}

		private void DoTouchOffset(Vector3 touchPos)
		{
			if (!storeOffset.IsNone)
			{
				var style = visualElement.resolvedStyle;
				Rect screenRect = new Rect(style.left, style.top, style.width, style.height);
				Vector3 value = default(Vector3);
				switch (relativeTo)
				{
					case OffsetOptions.TopLeft:
						value.x = touchPos.x - screenRect.x;
						value.y = touchPos.y - screenRect.y;
						break;
					case OffsetOptions.Center:
					{
						Vector3 vector = new Vector3(screenRect.x + screenRect.width * 0.5f, screenRect.y + screenRect.height * 0.5f, 0f);
						value = touchPos - vector;
						break;
					}
					case OffsetOptions.TouchStart:
						value = touchPos - touchStartPos;
						break;
				}
				if (normalizeOffset.Value)
				{
					value.x /= screenRect.width;
					value.y /= screenRect.height;
				}
				storeOffset.Value = value;
			}
		}
	}
}
