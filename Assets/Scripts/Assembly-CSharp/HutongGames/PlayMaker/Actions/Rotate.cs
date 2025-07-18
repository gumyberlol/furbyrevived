using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Transform)]
	[Tooltip("Rotates a Game Object around each Axis. Use a Vector3 Variable and/or XYZ components. To leave any axis unchanged, set variable to 'None'.")]
	public class Rotate : FsmStateAction
	{
		[RequiredField]
		[Tooltip("The game object to rotate.")]
		public FsmOwnerDefault gameObject;

		[Tooltip("A rotation vector. NOTE: You can override individual axis below.")]
		[UIHint(UIHint.Variable)]
		public FsmVector3 vector;

		[Tooltip("Rotation around x axis.")]
		public FsmFloat xAngle;

		[Tooltip("Rotation around y axis.")]
		public FsmFloat yAngle;

		[Tooltip("Rotation around z axis.")]
		public FsmFloat zAngle;

		[Tooltip("Rotate in local or world space.")]
		public Space space;

		[Tooltip("Rotate over one second")]
		public bool perSecond;

		[Tooltip("Repeat every frame.")]
		public bool everyFrame;

		[Tooltip("Perform the rotation in LateUpdate. This is useful if you want to override the rotation of objects that are animated or otherwise rotated in Update.")]
		public bool lateUpdate;

		public override void Reset()
		{
			gameObject = null;
			vector = null;
			xAngle = new FsmFloat
			{
				UseVariable = true
			};
			yAngle = new FsmFloat
			{
				UseVariable = true
			};
			zAngle = new FsmFloat
			{
				UseVariable = true
			};
			space = Space.Self;
			perSecond = false;
			everyFrame = true;
			lateUpdate = false;
		}

		public override void OnEnter()
		{
			if (!everyFrame && !lateUpdate)
			{
				DoRotate();
				Finish();
			}
		}

		public override void OnUpdate()
		{
			if (!lateUpdate)
			{
				DoRotate();
			}
		}

		public override void OnLateUpdate()
		{
			if (lateUpdate)
			{
				DoRotate();
			}
			if (!everyFrame)
			{
				Finish();
			}
		}

		private void DoRotate()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (!(ownerDefaultTarget == null))
			{
				Vector3 vector = ((!this.vector.IsNone) ? this.vector.Value : new Vector3(xAngle.Value, yAngle.Value, zAngle.Value));
				if (!xAngle.IsNone)
				{
					vector.x = xAngle.Value;
				}
				if (!yAngle.IsNone)
				{
					vector.y = yAngle.Value;
				}
				if (!zAngle.IsNone)
				{
					vector.z = zAngle.Value;
				}
				if (!perSecond)
				{
					ownerDefaultTarget.transform.Rotate(vector, space);
				}
				else
				{
					ownerDefaultTarget.transform.Rotate(vector * Time.deltaTime, space);
				}
			}
		}
	}
}
