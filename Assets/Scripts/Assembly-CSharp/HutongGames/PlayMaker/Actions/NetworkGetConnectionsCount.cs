using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Get the number of connected players.\n\nOn a client this returns 1 (the server).")]
	[ActionCategory(ActionCategory.Network)]
	public class NetworkGetConnectionsCount : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		[Tooltip("Number of connected players.")]
		public FsmInt connectionsCount;

		[Tooltip("Repeat every frame.")]
		public bool everyFrame;

		public override void Reset()
		{
			connectionsCount = null;
			everyFrame = true;
		}

		public override void OnEnter()
		{
			// todo: nothing
		}

		public override void OnUpdate()
		{
			// you can have 1 conection
		}
	}
}
