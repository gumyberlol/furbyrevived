using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Physics)]
	[Tooltip("Casts a Ray against all Colliders in the scene. Use either a Game Object or Vector3 world position as the origin of the ray. Use GetRaycastInfo to get more detailed info.")]
	public class Raycast : FsmStateAction
	{
		[Tooltip("Start ray at game object position. \nOr use From Position parameter.")]
		public FsmOwnerDefault fromGameObject;

		[Tooltip("Start ray at a vector3 world position. \nOr use Game Object parameter.")]
		public FsmVector3 fromPosition;

		[Tooltip("A vector3 direction vector")]
		public FsmVector3 direction;

		[Tooltip("Cast the ray in world or local space. Note if no Game Object is specfied, the direction is in world space.")]
		public Space space;

		[Tooltip("The length of the ray. Set to -1 for infinity.")]
		public FsmFloat distance;

		[UIHint(UIHint.Variable)]
		[Tooltip("Event to send if the ray hits an object.")]
		public FsmEvent hitEvent;

		[UIHint(UIHint.Variable)]
		[Tooltip("Set a bool variable to true if hit something, otherwise false.")]
		public FsmBool storeDidHit;

		[Tooltip("Store the game object hit in a variable.")]
		[UIHint(UIHint.Variable)]
		public FsmGameObject storeHitObject;

		[Tooltip("Set how often to cast a ray. 0 = once, don't repeat; 1 = everyFrame; 2 = every other frame... \nSince raycasts can get expensive use the highest repeat interval you can get away with.")]
		public FsmInt repeatInterval;

		[Tooltip("Pick only from these layers.")]
		[UIHint(UIHint.Layer)]
		public FsmInt[] layerMask;

		[Tooltip("Invert the mask, so you pick from all layers except those defined above.")]
		public FsmBool invertMask;

		[Tooltip("The color to use for the debug line.")]
		[ActionSection("Debug")]
		public FsmColor debugColor;

		[Tooltip("Draw a debug line. Note: Check Gizmos in the Game View to see it in game.")]
		public FsmBool debug;

		private int repeat;

		public override void Reset()
		{
			fromGameObject = null;
			fromPosition = new FsmVector3
			{
				UseVariable = true
			};
			direction = new FsmVector3
			{
				UseVariable = true
			};
			space = Space.Self;
			distance = 100f;
			hitEvent = null;
			storeDidHit = null;
			storeHitObject = null;
			repeatInterval = 1;
			layerMask = new FsmInt[0];
			invertMask = false;
			debugColor = Color.yellow;
			debug = false;
		}

		public override void OnEnter()
		{
			DoRaycast();
			if (repeatInterval.Value == 0)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			repeat--;
			if (repeat == 0)
			{
				DoRaycast();
			}
		}

		private void DoRaycast()
		{
			repeat = repeatInterval.Value;
			if (distance.Value != 0f)
			{
				GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(fromGameObject);
				Vector3 vector = ((!(ownerDefaultTarget != null)) ? fromPosition.Value : ownerDefaultTarget.transform.position);
				float a = float.PositiveInfinity;
				if (distance.Value > 0f)
				{
					a = distance.Value;
				}
				Vector3 vector2 = direction.Value;
				if (ownerDefaultTarget != null && space == Space.Self)
				{
					vector2 = ownerDefaultTarget.transform.TransformDirection(direction.Value);
				}
				RaycastHit hitInfo;
				Physics.Raycast(vector, vector2, out hitInfo, a, ActionHelpers.LayerArrayToLayerMask(layerMask, invertMask.Value));
				base.Fsm.RaycastHitInfo = hitInfo;
				bool flag = hitInfo.collider != null;
				storeDidHit.Value = flag;
				if (flag)
				{
					storeHitObject.Value = hitInfo.collider.GetComponent<Collider>().gameObject;
					base.Fsm.Event(hitEvent);
				}
				if (debug.Value)
				{
					float num = Mathf.Min(a, 1000f);
					Debug.DrawLine(vector, vector + vector2 * num, debugColor.Value);
				}
			}
		}
	}
}
