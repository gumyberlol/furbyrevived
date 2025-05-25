using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Stub: Get the next host data from the master server (deprecated, no-op).")]
	[ActionCategory(ActionCategory.Network)]
	public class MasterServerGetNextHostData : FsmStateAction
	{
		[ActionSection("Set up")]
		[Tooltip("Event to send for looping.")]
		public FsmEvent loopEvent;

		[Tooltip("Event to send when there are no more hosts.")]
		public FsmEvent finishedEvent;

		[ActionSection("Result")]
		[Tooltip("The index into the MasterServer Host List")]
		[UIHint(UIHint.Variable)]
		public FsmInt index;

		[UIHint(UIHint.Variable)]
		[Tooltip("Does this server require NAT punchthrough?")]
		public FsmBool useNat;

		[Tooltip("The type of the game (e.g., 'MyUniqueGameType')")]
		[UIHint(UIHint.Variable)]
		public FsmString gameType;

		[UIHint(UIHint.Variable)]
		[Tooltip("The name of the game (e.g., 'John Does's Game')")]
		public FsmString gameName;

		[UIHint(UIHint.Variable)]
		[Tooltip("Currently connected players")]
		public FsmInt connectedPlayers;

		[UIHint(UIHint.Variable)]
		[Tooltip("Maximum players limit")]
		public FsmInt playerLimit;

		[UIHint(UIHint.Variable)]
		[Tooltip("Server IP address.")]
		public FsmString ipAddress;

		[UIHint(UIHint.Variable)]
		[Tooltip("Server port")]
		public FsmInt port;

		[Tooltip("Does the server require a password?")]
		[UIHint(UIHint.Variable)]
		public FsmBool passwordProtected;

		[UIHint(UIHint.Variable)]
		[Tooltip("A miscellaneous comment (can hold data)")]
		public FsmString comment;

		[Tooltip("The GUID of the host, needed when connecting with NAT punchthrough.")]
		[UIHint(UIHint.Variable)]
		public FsmString guid;

		private int nextItemIndex;

		public override void Reset()
		{
			finishedEvent = null;
			loopEvent = null;
			index = null;
			useNat = null;
			gameType = null;
			gameName = null;
			connectedPlayers = null;
			playerLimit = null;
			ipAddress = null;
			port = null;
			passwordProtected = null;
			comment = null;
			guid = null;
			nextItemIndex = 0;
		}

		public override void OnEnter()
		{
			DoGetNextHostData();
			Finish();
		}

		private void DoGetNextHostData()
		{
			// Stub version: no hosts available, so always trigger finishedEvent and clear outputs
			if (index != null) index.Value = -1;
			if (useNat != null) useNat.Value = false;
			if (gameType != null) gameType.Value = "";
			if (gameName != null) gameName.Value = "";
			if (connectedPlayers != null) connectedPlayers.Value = 0;
			if (playerLimit != null) playerLimit.Value = 0;
			if (ipAddress != null) ipAddress.Value = "";
			if (port != null) port.Value = 0;
			if (passwordProtected != null) passwordProtected.Value = false;
			if (comment != null) comment.Value = "";
			if (guid != null) guid.Value = "";

			if (finishedEvent != null)
			{
				base.Fsm.Event(finishedEvent);
			}
		}
	}
}
