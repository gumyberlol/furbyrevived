using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Audio)]
	[Tooltip("Sets the global sound volume.")]
	public class SetGameVolume : FsmStateAction
	{
		// REMOVE volume setting completely
		public bool everyFrame;

		public override void Reset()
		{
			everyFrame = false;
		}

		public override void OnEnter()
		{
			// Do nothing
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			// Do nothing
		}
	}
}
