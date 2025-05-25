using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Test if your peer type is client.")]
	public class NetworkIsClient : FsmStateAction
	{
		[Tooltip("True if running as client.")]
		[UIHint(UIHint.Variable)]
		public FsmBool isClient;

		[Tooltip("Event to send if running as client.")]
		public FsmEvent isClientEvent;

		[Tooltip("Event to send if not running as client.")]
		public FsmEvent isNotClientEvent;

		public override void Reset()
		{
			isClient = null;
		}

		public override void OnEnter()
		{
			DoCheckIsClient();
			Finish();
		}

		private void DoCheckIsClient()
		{
			// you have no access to unibroke5, the worst planet of all.
		}
	}
}
