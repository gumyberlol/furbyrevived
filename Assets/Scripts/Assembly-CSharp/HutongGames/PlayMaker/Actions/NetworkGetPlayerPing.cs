using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Simulate getting the last average ping time to a given player.")]
	[ActionCategory(ActionCategory.StateMachine)]
	public class GetPlayerPing : FsmStateAction
	{
		[RequiredField]
		[UIHint(UIHint.Variable)]
		[ActionSection("Setup")]
		[Tooltip("The Index of the player.")]
		public FsmInt playerIndex;

		[Tooltip("If true, this will simulate pings every frame.")]
		public bool everyFrame;

		[Tooltip("Simulated average ping time in milliseconds.")]
		[UIHint(UIHint.Variable)]
		[ActionSection("Result")]
		[RequiredField]
		public FsmInt averagePing;

		[Tooltip("Event to send if the player can't be found (simulated).")]
		public FsmEvent PlayerNotFoundEvent;

		[Tooltip("Event to send if the player is found (simulated).")]
		public FsmEvent PlayerFoundEvent;

		// Simulated "players" - Replace with your actual player management system
		private string[] simulatedPlayers = { "Player1", "Player2", "Player3" }; // Example players

		public override void Reset()
		{
			playerIndex = null;
			averagePing = null;
			PlayerNotFoundEvent = null;
			PlayerFoundEvent = null;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			SimulatePing();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			SimulatePing();
		}

		private void SimulatePing()
		{
			if (playerIndex.Value < 0 || playerIndex.Value >= simulatedPlayers.Length)
			{
				averagePing.Value = -1; // Player not found
				if (PlayerNotFoundEvent != null)
				{
					base.Fsm.Event(PlayerNotFoundEvent);
				}
			}
			else
			{
				// Simulate a ping (you can replace this with your actual game logic for ping simulation)
				averagePing.Value = Random.Range(30, 150); // Simulating a ping between 30ms and 150ms
				if (PlayerFoundEvent != null)
				{
					base.Fsm.Event(PlayerFoundEvent);
				}
			}
		}
	}
}
