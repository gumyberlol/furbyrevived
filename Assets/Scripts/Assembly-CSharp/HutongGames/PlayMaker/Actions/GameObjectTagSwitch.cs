using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Sends an Event based on a Game Object's Tag.")]
	[ActionCategory(ActionCategory.Logic)]
	public class GameObjectTagSwitch : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmGameObject gameObject;

		[CompoundArray("Tag Switches", "Compare Tag", "Send Event")]
		[UIHint(UIHint.Tag)]
		public FsmString[] compareTo;

		public FsmEvent[] sendEvent;

		public bool everyFrame;

		public override void Reset()
		{
			gameObject = null;
			compareTo = new FsmString[1];
			sendEvent = new FsmEvent[1];
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoTagSwitch();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoTagSwitch();
		}

		private void DoTagSwitch()
		{
			GameObject value = gameObject.Value;
			if (value == null)
			{
				return;
			}
			for (int i = 0; i < compareTo.Length; i++)
			{
				if (value.tag == compareTo[i].Value)
				{
					base.Fsm.Event(sendEvent[i]);
					break;
				}
			}
		}
	}
}
