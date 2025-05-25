using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.StateMachine)]
	[Tooltip("Get the value of a Game Object Variable from another FSM.")]
	public class GetFsmGameObject : FsmStateAction
	{
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[UIHint(UIHint.FsmName)]
		[Tooltip("Optional name of FSM on Game Object")]
		public FsmString fsmName;

		[RequiredField]
		[UIHint(UIHint.FsmGameObject)]
		public FsmString variableName;

		[RequiredField]
		[UIHint(UIHint.Variable)]
		public FsmGameObject storeValue;

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
			DoGetFsmGameObject();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoGetFsmGameObject();
		}

		private void DoGetFsmGameObject()
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
				FsmGameObject fsmGameObject = fsm.FsmVariables.GetFsmGameObject(variableName.Value);
				if (fsmGameObject != null)
				{
					storeValue.Value = fsmGameObject.Value;
				}
			}
		}
	}
}
