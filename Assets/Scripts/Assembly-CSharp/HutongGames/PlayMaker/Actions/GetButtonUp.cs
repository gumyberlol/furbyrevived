using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Input)]
	[Tooltip("Sends an Event when a Button is released.")]
	public class GetButtonUp : FsmStateAction
	{
		[RequiredField]
		public FsmString buttonName;

		public FsmEvent sendEvent;

		[UIHint(UIHint.Variable)]
		public FsmBool storeResult;

		public override void Reset()
		{
			buttonName = "Fire1";
			sendEvent = null;
			storeResult = null;
		}

		public override void OnUpdate()
		{
			bool buttonUp = Input.GetButtonUp(buttonName.Value);
			if (buttonUp)
			{
				base.Fsm.Event(sendEvent);
			}
			storeResult.Value = buttonUp;
		}
	}
}
