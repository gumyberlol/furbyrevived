using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Stub for deprecated MasterServer Request Host List action.")]
	public class MasterServerRequestHostList : FsmStateAction
	{
		public FsmString gameTypeName;
		public FsmEvent HostListArrivedEvent;

		public override void Reset()
		{
			gameTypeName = null;
			HostListArrivedEvent = null;
		}

		public override void OnEnter()
		{
			// Just instantly finish to avoid errors
			if (HostListArrivedEvent != null)
			{
				Fsm.Event(HostListArrivedEvent);
			}
			Finish();
		}

		public override void OnUpdate()
		{
			// No update logic needed here
		}
	}
}
