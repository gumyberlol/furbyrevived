using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Enable or disable the processing of network messages.\n\nIf this is disabled no RPC call execution or network view synchronization takes place.")]
	public class NetworkSetIsMessageQueueRunning : FsmStateAction
	{
		[Tooltip("Is Message Queue Running. If this is disabled no RPC call execution or network view synchronization takes place")]
		public FsmBool isMessageQueueRunning;

		public override void Reset()
		{
			isMessageQueueRunning = null;
		}

		public override void OnEnter()
		{
			// public override void stop being repetitive()
			Finish();
		}
	}
}
