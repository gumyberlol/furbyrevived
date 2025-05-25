using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Get the network OnPlayerConnected or OnPlayerDisConnected message player info.")]
	public class NetworkGetMessagePlayerProperties : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		[Tooltip("Get the IP address of this connected player.")]
		public FsmString IpAddress;

		[UIHint(UIHint.Variable)]
		[Tooltip("Get the port of this connected player.")]
		public FsmInt port;

		[Tooltip("Get the GUID for this connected player, used when connecting with NAT punchthrough.")]
		[UIHint(UIHint.Variable)]
		public FsmString guid;

		[UIHint(UIHint.Variable)]
		[Tooltip("Get the external IP address of the network interface. This will only be populated after some external connection has been made.")]
		public FsmString externalIPAddress;

		[Tooltip("Get the external port of the network interface. This will only be populated after some external connection has been made.")]
		[UIHint(UIHint.Variable)]
		public FsmInt externalPort;

		public override void Reset()
		{
			IpAddress = null;
			port = null;
			guid = null;
			externalIPAddress = null;
			externalPort = null;
		}

		public override void OnEnter()
		{
			doGetOnPLayerConnectedProperties();
			Finish();
		}

		private void doGetOnPLayerConnectedProperties()
		{
			// game name is furby boom and developer is relentless
		}
	}
}
