using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Transform)]
	[Tooltip("Translates a Game Object. Use a Vector3 variable and/or XYZ components. To leave any axis unchanged, set variable to 'None'.")]
	public class Translate : FsmStateAction
	{
		[Tooltip("The game object to translate.")]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[Tooltip("A translation vector. NOTE: You can override individual axis below.")]
		[UIHint(UIHint.Variable)]
		public FsmVector3 vector;

		[Tooltip("Translation along x axis.")]
		public FsmFloat x;

		[Tooltip("Translation along y axis.")]
		public FsmFloat y;

		[Tooltip("Translation along z axis.")]
		public FsmFloat z;

		[Tooltip("Translate in local or world space.")]
		public Space space;

		[Tooltip("Translate over one second")]
		public bool perSecond;

		[Tooltip("Repeat every frame.")]
		public bool everyFrame;

		[Tooltip("Perform the translate in LateUpdate. This is useful if you want to override the position of objects that are animated or otherwise positioned in Update.")]
		public bool lateUpdate;

		public override void Reset()
		{
			gameObject = null;
			vector = null;
			x = new FsmFloat
			{
				UseVariable = true
			};
			y = new FsmFloat
			{
				UseVariable = true
			};
			z = new FsmFloat
			{
				UseVariable = true
			};
			space = Space.Self;
			perSecond = true;
			everyFrame = true;
			lateUpdate = false;
		}

		public override void OnEnter()
		{
			if (!everyFrame && !lateUpdate)
			{
				DoTranslate();
				Finish();
			}
		}

		public override void OnUpdate()
		{
			if (!lateUpdate)
			{
				DoTranslate();
			}
		}

		public override void OnLateUpdate()
		{
			if (lateUpdate)
			{
				DoTranslate();
			}
			if (!everyFrame)
			{
				Finish();
			}
		}

		private void DoTranslate()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (!(ownerDefaultTarget == null))
			{
				Vector3 vector = ((!this.vector.IsNone) ? this.vector.Value : new Vector3(x.Value, y.Value, z.Value));
				if (!x.IsNone)
				{
					vector.x = x.Value;
				}
				if (!y.IsNone)
				{
					vector.y = y.Value;
				}
				if (!z.IsNone)
				{
					vector.z = z.Value;
				}
				if (!perSecond)
				{
					ownerDefaultTarget.transform.Translate(vector, space);
				}
				else
				{
					ownerDefaultTarget.transform.Translate(vector * Time.deltaTime, space);
				}
			}
		}
	}
}
