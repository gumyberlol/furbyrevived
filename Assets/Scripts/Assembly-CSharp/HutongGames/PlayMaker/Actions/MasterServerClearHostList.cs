using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Stub: Clear the host list (deprecated MasterServer removed).")]
	public class MasterServerClearHostList : FsmStateAction
	{
		public override void OnEnter()
		{
			// Do nothing, MasterServer.ClearHostList is obsolete
			Finish();
		}
	}
}
