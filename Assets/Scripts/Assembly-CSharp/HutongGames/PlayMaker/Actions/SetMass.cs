using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Physics)]
	[Tooltip("Sets the Mass of a Game Object's Rigid Body.")]
	public class SetMass : FsmStateAction
	{
		[CheckForComponent(typeof(Rigidbody))]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[HasFloatSlider(0.1f, 10f)]
		[RequiredField]
		public FsmFloat mass;

		public override void Reset()
		{
			gameObject = null;
			mass = 1f;
		}

		public override void OnEnter()
		{
			DoSetMass();
			Finish();
		}

		private void DoSetMass()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (!(ownerDefaultTarget == null) && !(ownerDefaultTarget.GetComponent<Rigidbody>() == null))
			{
				ownerDefaultTarget.GetComponent<Rigidbody>().mass = mass.Value;
			}
		}
	}
}
