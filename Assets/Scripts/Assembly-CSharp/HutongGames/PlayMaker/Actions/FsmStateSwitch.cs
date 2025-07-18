using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Sends Events based on the current State of an FSM.")]
	[ActionCategory(ActionCategory.Logic)]
	public class FsmStateSwitch : FsmStateAction
	{
		[RequiredField]
		public FsmGameObject gameObject;

		[UIHint(UIHint.FsmName)]
		[Tooltip("Optional name of Fsm on Game Object")]
		public FsmString fsmName;

		[CompoundArray("State Switches", "Compare State", "Send Event")]
		public FsmString[] compareTo;

		public FsmEvent[] sendEvent;

		[Tooltip("Repeat")]
		public bool everyFrame;

		private GameObject previousGo;

		private PlayMakerFSM fsm;

		public override void Reset()
		{
			gameObject = null;
			fsmName = null;
			compareTo = new FsmString[1];
			sendEvent = new FsmEvent[1];
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoFsmStateSwitch();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoFsmStateSwitch();
		}

		private void DoFsmStateSwitch()
		{
			GameObject value = gameObject.Value;
			if (value == null)
			{
				return;
			}
			if (value != previousGo)
			{
				fsm = ActionHelpers.GetGameObjectFsm(value, fsmName.Value);
				previousGo = value;
			}
			if (fsm == null)
			{
				return;
			}
			string activeStateName = fsm.ActiveStateName;
			for (int i = 0; i < compareTo.Length; i++)
			{
				if (activeStateName == compareTo[i].Value)
				{
					base.Fsm.Event(sendEvent[i]);
					break;
				}
			}
		}
	}
}
