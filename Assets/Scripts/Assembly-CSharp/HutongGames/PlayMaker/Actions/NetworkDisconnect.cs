using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Disconnect from the server.")]
	[ActionCategory(ActionCategory.Network)]
	public class NetworkDisconnect : FsmStateAction
	{
		public override void OnEnter()
		{
			// disconnect and never come back
			Finish();
		}
	}
}
