using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Get the value of a Color Variable from another FSM.")]
	[ActionCategory(ActionCategory.StateMachine)]
	public class GetFsmColor : FsmStateAction
	{
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[UIHint(UIHint.FsmName)]
		[Tooltip("Optional name of FSM on Game Object")]
		public FsmString fsmName;

		[UIHint(UIHint.FsmColor)]
		[RequiredField]
		public FsmString variableName;

		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmColor storeValue;

		public bool everyFrame;

		private GameObject goLastFrame;

		private PlayMakerFSM fsm;

		public override void Reset()
		{
			gameObject = null;
			fsmName = string.Empty;
			storeValue = null;
		}

		public override void OnEnter()
		{
			DoGetFsmColor();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoGetFsmColor();
		}

		private void DoGetFsmColor()
		{
			if (storeValue == null)
			{
				return;
			}
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget == null)
			{
				return;
			}
			if (ownerDefaultTarget != goLastFrame)
			{
				goLastFrame = ownerDefaultTarget;
				fsm = ActionHelpers.GetGameObjectFsm(ownerDefaultTarget, fsmName.Value);
			}
			if (!(fsm == null))
			{
				FsmColor fsmColor = fsm.FsmVariables.GetFsmColor(variableName.Value);
				if (fsmColor != null)
				{
					storeValue.Value = fsmColor.Value;
				}
			}
		}
	}
}
