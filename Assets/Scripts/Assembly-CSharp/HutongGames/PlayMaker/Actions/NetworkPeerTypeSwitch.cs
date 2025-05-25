using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Send Events based on the status of the network interface peer type: Disconneced, Server, Client, Connecting.")]
	public class NetworkPeerTypeSwitch : FsmStateAction
	{
		[Tooltip("Event to send if no client connection running. Server not initialized.")]
		public FsmEvent isDisconnected;

		[Tooltip("Event to send if running as server.")]
		public FsmEvent isServer;

		[Tooltip("Event to send if running as client.")]
		public FsmEvent isClient;

		[Tooltip("Event to send attempting to connect to a server.")]
		public FsmEvent isConnecting;

		[Tooltip("Repeat every frame. Useful if you're waiting for a particular network state.")]
		public bool everyFrame;

		public override void Reset()
		{
			isDisconnected = null;
			isServer = null;
			isClient = null;
			isConnecting = null;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoNetworkPeerTypeSwitch();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoNetworkPeerTypeSwitch();
		}

		private void DoNetworkPeerTypeSwitch()
		{
			// im keeping the break method here its so unnecesary
				// break;

		}
	}
}
