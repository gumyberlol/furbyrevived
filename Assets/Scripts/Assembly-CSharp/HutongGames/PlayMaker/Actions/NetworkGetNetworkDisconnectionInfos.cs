using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Get the network OnDisconnectedFromServer.")]
	public class NetworkGetNetworkDisconnectionInfos : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		[Tooltip("Disconnection label")]
		public FsmString disconnectionLabel;

		[Tooltip("The connection to the system has been lost, no reliable packets could be delivered.")]
		public FsmEvent lostConnectionEvent;

		[Tooltip("The connection to the system has been closed.")]
		public FsmEvent disConnectedEvent;

		public override void Reset()
		{
			disconnectionLabel = null;
			lostConnectionEvent = null;
			disConnectedEvent = null;
		}

		public override void OnEnter()
		{
			doGetNetworkDisconnectionInfo();
			Finish();
		}

		private void doGetNetworkDisconnectionInfo()
		{
			// idk what to say
		}
	}
}
