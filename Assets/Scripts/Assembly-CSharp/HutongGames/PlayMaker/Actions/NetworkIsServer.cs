using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Test if your peer type is server.")]
	[ActionCategory(ActionCategory.Network)]
	public class NetworkIsServer : FsmStateAction
	{
		[Tooltip("True if running as server.")]
		[UIHint(UIHint.Variable)]
		public FsmBool isServer;

		[Tooltip("Event to send if running as server.")]
		public FsmEvent isServerEvent;

		[Tooltip("Event to send if not running as server.")]
		public FsmEvent isNotServerEvent;

		public override void Reset()
		{
			isServer = null;
		}

		public override void OnEnter()
		{
			DoCheckIsServer();
			Finish();
		}

		private void DoCheckIsServer()
		{
			// this was prbably important for relentless, oh well, they can't code without paying for a visual scripting package.
		}
	}
}
