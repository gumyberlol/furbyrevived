using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Gets the Velocity of a Game Object and stores it in a Vector3 Variable or each Axis in a Float Variable. NOTE: The Game Object must have a Rigid Body.")]
	[ActionCategory(ActionCategory.Physics)]
	public class GetVelocity : FsmStateAction
	{
		[CheckForComponent(typeof(Rigidbody))]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[UIHint(UIHint.Variable)]
		public FsmVector3 vector;

		[UIHint(UIHint.Variable)]
		public FsmFloat x;

		[UIHint(UIHint.Variable)]
		public FsmFloat y;

		[UIHint(UIHint.Variable)]
		public FsmFloat z;

		public Space space;

		public bool everyFrame;

		public override void Reset()
		{
			gameObject = null;
			vector = null;
			x = null;
			y = null;
			z = null;
			space = Space.World;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoGetVelocity();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoGetVelocity();
		}

		private void DoGetVelocity()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (!(ownerDefaultTarget == null) && !(ownerDefaultTarget.GetComponent<Rigidbody>() == null))
			{
				Vector3 vector = ownerDefaultTarget.GetComponent<Rigidbody>().velocity;
				if (space == Space.Self)
				{
					vector = ownerDefaultTarget.transform.InverseTransformDirection(vector);
				}
				this.vector.Value = vector;
				x.Value = vector.x;
				y.Value = vector.y;
				z.Value = vector.z;
			}
		}
	}
}
