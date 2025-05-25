using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Stub: SetMasterServerProperties is deprecated.")]
	[ActionCategory(ActionCategory.Network)]
	public class MasterServerSetProperties : FsmStateAction
	{
		public FsmString ipAddress;
		public FsmInt port;
		public FsmInt updateRate;
		public FsmBool dedicatedServer;

		public override void Reset()
		{
			ipAddress = "127.0.0.1";
			port = 10002;
			updateRate = 60;
			dedicatedServer = false;
		}

		public override void OnEnter()
		{
			// Stubbed - removed MasterServer API
			Debug.Log("MasterServerSetProperties stubbed: Legacy networking removed.");
			Finish();
		}
	}
}
