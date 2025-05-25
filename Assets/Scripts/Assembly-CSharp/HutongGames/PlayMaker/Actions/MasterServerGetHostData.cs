using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Stub: Get host data from the master server (deprecated, no-op).")]
	public class MasterServerGetHostData : FsmStateAction
	{
		[RequiredField]
		[Tooltip("The index into the MasterServer Host List")]
		public FsmInt hostIndex;

		[UIHint(UIHint.Variable)]
		[Tooltip("Does this server require NAT punchthrough?")]
		public FsmBool useNat;

		[Tooltip("The type of the game (e.g., 'MyUniqueGameType')")]
		[UIHint(UIHint.Variable)]
		public FsmString gameType;

		[Tooltip("The name of the game (e.g., 'John Does's Game')")]
		[UIHint(UIHint.Variable)]
		public FsmString gameName;

		[Tooltip("Currently connected players")]
		[UIHint(UIHint.Variable)]
		public FsmInt connectedPlayers;

		[UIHint(UIHint.Variable)]
		[Tooltip("Maximum players limit")]
		public FsmInt playerLimit;

		[Tooltip("Server IP address.")]
		[UIHint(UIHint.Variable)]
		public FsmString ipAddress;

		[UIHint(UIHint.Variable)]
		[Tooltip("Server port")]
		public FsmInt port;

		[Tooltip("Does the server require a password?")]
		[UIHint(UIHint.Variable)]
		public FsmBool passwordProtected;

		[Tooltip("A miscellaneous comment (can hold data)")]
		[UIHint(UIHint.Variable)]
		public FsmString comment;

		[Tooltip("The GUID of the host, needed when connecting with NAT punchthrough.")]
		[UIHint(UIHint.Variable)]
		public FsmString guid;

		public override void Reset()
		{
			hostIndex = null;
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
		}

		public override void OnEnter()
		{
			// Stub: no actual host data, so set default values or clear variables
			if (useNat != null) useNat.Value = false;
			if (gameType != null) gameType.Value = string.Empty;
			if (gameName != null) gameName.Value = string.Empty;
			if (connectedPlayers != null) connectedPlayers.Value = 0;
			if (playerLimit != null) playerLimit.Value = 0;
			if (ipAddress != null) ipAddress.Value = string.Empty;
			if (port != null) port.Value = 0;
			if (passwordProtected != null) passwordProtected.Value = false;
			if (comment != null) comment.Value = string.Empty;
			if (guid != null) guid.Value = string.Empty;

			Finish();
		}
	}
}
