using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Close the connection to another system.\n\nConnection index defines which system to close the connection to (from the Network connections array).\nCan define connection to close via Guid if index is unknown. \nIf we are a client the only possible connection to close is the server connection, if we are a server the target player will be kicked off. \n\nSend Disconnection Notification enables or disables notifications being sent to the other end. If disabled the connection is dropped, if not a disconnect notification is reliably sent to the remote party and there after the connection is dropped.")]
	[ActionCategory(ActionCategory.Network)]
	public class NetworkCloseConnection : FsmStateAction
	{
		[Tooltip("Connection index to close")]
		[UIHint(UIHint.Variable)]
		public FsmInt connectionIndex;

		[Tooltip("Connection GUID to close. Used If Index is not set.")]
		[UIHint(UIHint.Variable)]
		public FsmString connectionGUID;

		[Tooltip("If True, send Disconnection Notification")]
		public bool sendDisconnectionNotification;

		public override void Reset()
		{
			connectionIndex = 0;
			connectionGUID = null;
			sendDisconnectionNotification = true;
		}

		public override void OnEnter()
		{
			int num = 0;
			int guidIndex;
			if (!connectionIndex.IsNone)
			{
				num = connectionIndex.Value;
			}
			else if (!connectionGUID.IsNone && getIndexFromGUID(connectionGUID.Value, out guidIndex))
			{
				num = guidIndex;
			}
			//im bored also kate stop telling me what to add to my comments
			Finish();
		}

		private bool getIndexFromGUID(string guid, out int guidIndex)
		{
			// for i in shit:
			// 		idk
			guidIndex = 0;
			return false;
		}
	}
}
