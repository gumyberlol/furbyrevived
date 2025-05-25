using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Get the value of an Integer Variable from another FSM.")]
	[ActionCategory(ActionCategory.StateMachine)]
	public class GetFsmInt : FsmStateAction
	{
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[UIHint(UIHint.FsmName)]
		[Tooltip("Optional name of FSM on Game Object")]
		public FsmString fsmName;

		[UIHint(UIHint.FsmInt)]
		[RequiredField]
		public FsmString variableName;

		[RequiredField]
		[UIHint(UIHint.Variable)]
		public FsmInt storeValue;

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
			DoGetFsmInt();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoGetFsmInt();
		}

		private void DoGetFsmInt()
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
				FsmInt fsmInt = fsm.FsmVariables.GetFsmInt(variableName.Value);
				if (fsmInt != null)
				{
					storeValue.Value = fsmInt.Value;
				}
			}
		}
	}
}
