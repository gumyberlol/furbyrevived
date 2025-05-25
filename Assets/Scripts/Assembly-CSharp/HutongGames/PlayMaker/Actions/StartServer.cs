using UnityEngine;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Start a simple TCP server for networking.")]
	[ActionCategory(ActionCategory.Network)]
	public class StartServer : FsmStateAction
	{
		[RequiredField]
		[Tooltip("The number of allowed incoming connections/number of players allowed in the game.")]
		public FsmInt connections;

		[RequiredField]
		[Tooltip("The port number we want to listen to.")]
		public FsmInt listenPort;

		[Tooltip("Sets the password for the server.")]
		public FsmString incomingPassword;

		[Tooltip("Run the server in the background, even if it doesn't have focus.")]
		public FsmBool runInBackground;

		[ActionSection("Events")]
		[Tooltip("Event to send when server starts successfully.")]
		public FsmEvent successEvent;

		[Tooltip("Event to send in case of an error creating the server.")]
		public FsmEvent errorEvent;

		[UIHint(UIHint.Variable)]
		[Tooltip("Store the error string in a variable.")]
		public FsmString errorString;

		[UIHint(UIHint.Variable)]
		[Tooltip("Store a reference to the server in a variable.")]
		public FsmObject serverReference;

		// Internal server object
		private NetworkServerComponent serverComponent;

		public override void Reset()
		{
			connections = 32;
			listenPort = 25001;
			incomingPassword = string.Empty;
			errorEvent = null;
			successEvent = null;
			errorString = null;
			serverReference = null;
			runInBackground = true;
		}

		public override void OnEnter()
		{
			// Setup background running if needed
			if (runInBackground.Value)
			{
				Application.runInBackground = true;
			}

			try
			{
				// Create a new GameObject for the server
				GameObject serverGO = new GameObject("NetworkServer");
				serverComponent = serverGO.AddComponent<NetworkServerComponent>();

				// Configure the server
				bool success = serverComponent.StartServer(
					listenPort.Value,
					connections.Value,
					incomingPassword.Value
				);

				if (success)
				{
					// Store reference if requested
					if (!serverReference.IsNone)
					{
						serverReference.Value = serverComponent;
					}

					if (successEvent != null)
					{
						Fsm.Event(successEvent);
					}
				}
				else
				{
					if (errorString != null)
					{
						errorString.Value = "Failed to start server";
					}

					if (errorEvent != null)
					{
						Fsm.Event(errorEvent);
					}
				}
			}
			catch (System.Exception e)
			{
				if (errorString != null)
				{
					errorString.Value = e.Message;
				}

				Debug.LogError("StartServer Error: " + e.Message);

				if (errorEvent != null)
				{
					Fsm.Event(errorEvent);
				}
			}

			Finish();
		}
	}

	// Custom server component class
	public class NetworkServerComponent : MonoBehaviour
	{
		private Socket serverSocket;
		private Thread listenThread;
		private bool isRunning = false;
		private int maxConnections = 32;
		private string password = "";

		// Client sockets
		private Socket[] clientSockets;
		private int connectedClients = 0;

		void Awake()
		{
			DontDestroyOnLoad(gameObject);
		}

		public bool StartServer(int port, int maxConn, string pass)
		{
			try
			{
				// Save settings
				maxConnections = maxConn;
				password = pass;

				// Initialize client sockets array
				clientSockets = new Socket[maxConnections];

				// Create server socket
				serverSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

				// Bind to port
				serverSocket.Bind(new IPEndPoint(IPAddress.Any, port));

				// Start listening
				serverSocket.Listen(10);

				// Mark as running
				isRunning = true;

				// Start listen thread
				listenThread = new Thread(new ThreadStart(ListenForClients));
				listenThread.IsBackground = true;
				listenThread.Start();

				Debug.Log("Server started on port " + port);
				return true;
			}
			catch (System.Exception e)
			{
				Debug.LogError("Error starting server: " + e.Message);
				return false;
			}
		}

		private void ListenForClients()
		{
			while (isRunning)
			{
				try
				{
					// Accept new client
					Socket clientSocket = serverSocket.Accept();

					// If we have room for more clients
					if (connectedClients < maxConnections)
					{
						// Find free slot
						int slot = -1;
						for (int i = 0; i < maxConnections; i++)
						{
							if (clientSockets[i] == null)
							{
								slot = i;
								break;
							}
						}

						if (slot != -1)
						{
							// Store client socket
							clientSockets[slot] = clientSocket;
							connectedClients++;

							// Start handling client in new thread
							Thread clientThread = new Thread(new ParameterizedThreadStart(HandleClient));
							clientThread.IsBackground = true;
							clientThread.Start(slot);

							Debug.Log("Client connected. Total clients: " + connectedClients);
						}
						else
						{
							// This shouldn't happen
							clientSocket.Close();
							Debug.LogError("No free slot found despite connectedClients < maxConnections");
						}
					}
					else
					{
						// Server full, reject client
						clientSocket.Close();
						Debug.Log("Server full, client rejected");
					}
				}
				catch (System.Exception e)
				{
					if (isRunning)
					{
						Debug.LogError("Error accepting client: " + e.Message);
					}
				}
			}
		}

		private void HandleClient(object slotObject)
		{
			int slot = (int)slotObject;
			Socket client = clientSockets[slot];

			try
			{
				// TODO: Add authentication using password
				// TODO: Add actual networking logic

				// For now, just keep connection open
				byte[] buffer = new byte[1024];
				while (isRunning && client.Connected)
				{
					Thread.Sleep(100);
				}
			}
			catch (System.Exception e)
			{
				Debug.Log("Client disconnected: " + e.Message);
			}
			finally
			{
				// Clean up
				if (client != null)
				{
					client.Close();
				}

				clientSockets[slot] = null;
				connectedClients--;
			}
		}

		public void StopServer()
		{
			isRunning = false;

			// Close all client connections
			for (int i = 0; i < maxConnections; i++)
			{
				if (clientSockets[i] != null)
				{
					clientSockets[i].Close();
					clientSockets[i] = null;
				}
			}

			// Close server socket
			if (serverSocket != null)
			{
				try
				{
					serverSocket.Close();
				}
				catch (System.Exception e)
				{
					Debug.LogError("Error closing server socket: " + e.Message);
				}
			}

			connectedClients = 0;
		}

		void OnDestroy()
		{
			StopServer();
		}

		void OnApplicationQuit()
		{
			StopServer();
		}
	}
}
