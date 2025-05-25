using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Get the network OnFailedToConnect or MasterServer OnFailedToConnectToMasterServer connection error message.")]
	[ActionCategory(ActionCategory.Network)]
	public class NetworkGetOnFailedToConnectProperties : FsmStateAction
	{
		[Tooltip("Error label")]
		[UIHint(UIHint.Variable)]
		public FsmString errorLabel;

		[Tooltip("No error occurred.")]
		public FsmEvent NoErrorEvent;

		[Tooltip("We presented an RSA public key which does not match what the system we connected to is using.")]
		public FsmEvent RSAPublicKeyMismatchEvent;

		[Tooltip("The server is using a password and has refused our connection because we did not set the correct password.")]
		public FsmEvent InvalidPasswordEvent;

		[Tooltip("onnection attempt failed, possibly because of internal connectivity problems.")]
		public FsmEvent ConnectionFailedEvent;

		[Tooltip("The server is at full capacity, failed to connect.")]
		public FsmEvent TooManyConnectedPlayersEvent;

		[Tooltip("We are banned from the system we attempted to connect to (likely pernamently).")]
		public FsmEvent ConnectionBannedEvent;

		[Tooltip("We are already connected to this particular server (can happen after fast disconnect/reconnect).")]
		public FsmEvent AlreadyConnectedToServerEvent;

		[Tooltip("Cannot connect to two servers at once. Close the connection before connecting again.")]
		public FsmEvent AlreadyConnectedToAnotherServerEvent;

		[Tooltip("Internal error while attempting to initialize network interface. Socket possibly already in use.")]
		public FsmEvent CreateSocketOrThreadFailureEvent;

		[Tooltip("Incorrect parameters given to Connect function.")]
		public FsmEvent IncorrectParametersEvent;

		[Tooltip("No host target given in Connect.")]
		public FsmEvent EmptyConnectTargetEvent;

		[Tooltip("Client could not connect internally to same network NAT enabled server.")]
		public FsmEvent InternalDirectConnectFailedEvent;

		[Tooltip("The NAT target we are trying to connect to is not connected to the facilitator server.")]
		public FsmEvent NATTargetNotConnectedEvent;

		[Tooltip("Connection lost while attempting to connect to NAT target.")]
		public FsmEvent NATTargetConnectionLostEvent;

		[Tooltip("NAT punchthrough attempt has failed. The cause could be a too restrictive NAT implementation on either endpoints.")]
		public FsmEvent NATPunchthroughFailedEvent;

		public override void Reset()
		{
			errorLabel = null;
			NoErrorEvent = null;
			RSAPublicKeyMismatchEvent = null;
			InvalidPasswordEvent = null;
			ConnectionFailedEvent = null;
			TooManyConnectedPlayersEvent = null;
			ConnectionBannedEvent = null;
			AlreadyConnectedToServerEvent = null;
			AlreadyConnectedToAnotherServerEvent = null;
			CreateSocketOrThreadFailureEvent = null;
			IncorrectParametersEvent = null;
			EmptyConnectTargetEvent = null;
			InternalDirectConnectFailedEvent = null;
			NATTargetNotConnectedEvent = null;
			NATTargetConnectionLostEvent = null;
			NATPunchthroughFailedEvent = null;
		}

		public override void OnEnter()
		{
			doGetNetworkErrorInfo();
			Finish();
		}

		private void doGetNetworkErrorInfo()
		{
			// if your network is fucked its your problem
		}
	}
}
