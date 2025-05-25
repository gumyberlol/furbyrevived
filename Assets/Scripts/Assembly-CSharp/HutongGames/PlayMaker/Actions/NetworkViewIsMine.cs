using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Legacy network check removed — no longer needed.")]
	public class NetworkViewIsMine : FsmStateAction
	{
		public override void Reset()
		{
		}

		public override void OnEnter()
		{
			Finish();
		}
	}
}
