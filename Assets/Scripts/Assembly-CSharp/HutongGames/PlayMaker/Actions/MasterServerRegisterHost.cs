using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Stub: Register this server on the master server (deprecated, no-op).")]
	public class MasterServerRegisterHost : FsmStateAction
	{
		[RequiredField]
		[Tooltip("The unique game type name.")]
		public FsmString gameTypeName;

		[RequiredField]
		[Tooltip("The game name.")]
		public FsmString gameName;

		[Tooltip("Optional comment")]
		public FsmString comment;

		public override void Reset()
		{
			gameTypeName = null;
			gameName = null;
			comment = null;
		}

		public override void OnEnter()
		{
			// Stub: skip deprecated call to avoid errors :3
			Finish();
		}
	}
}
