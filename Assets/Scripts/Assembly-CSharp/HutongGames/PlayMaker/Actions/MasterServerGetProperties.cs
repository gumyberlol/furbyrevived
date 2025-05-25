using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Stub for getting master server properties (deprecated).")]
	[ActionCategory(ActionCategory.Network)]
	public class MasterServerGetProperties : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		[Tooltip("The IP address of the master server.")]
		public FsmString ipAddress;

		[UIHint(UIHint.Variable)]
		[Tooltip("The connection port of the master server.")]
		public FsmInt port;

		[UIHint(UIHint.Variable)]
		[Tooltip("The minimum update rate for master server host information update.")]
		public FsmInt updateRate;

		[UIHint(UIHint.Variable)]
		[Tooltip("Flag to report if this machine is a dedicated server.")]
		public FsmBool dedicatedServer;

		[Tooltip("Event sent if this machine is a dedicated server")]
		public FsmEvent isDedicatedServerEvent;

		[Tooltip("Event sent if this machine is not a dedicated server")]
		public FsmEvent isNotDedicatedServerEvent;

		public override void Reset()
		{
			ipAddress = null;
			port = null;
			updateRate = null;
			dedicatedServer = null;
			isDedicatedServerEvent = null;
			isNotDedicatedServerEvent = null;
		}

		public override void OnEnter()
		{
			// Just set default values or nulls
			if (ipAddress != null) ipAddress.Value = "127.0.0.1";
			if (port != null) port.Value = 0;
			if (updateRate != null) updateRate.Value = 0;
			if (dedicatedServer != null) dedicatedServer.Value = false;

			// Send event for not dedicated server by default
			if (isNotDedicatedServerEvent != null)
			{
				Fsm.Event(isNotDedicatedServerEvent);
			}
			Finish();
		}
	}
}
