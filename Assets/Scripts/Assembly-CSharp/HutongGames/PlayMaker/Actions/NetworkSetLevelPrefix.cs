using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Set the level prefix which will then be prefixed to all network ViewID numbers.\n\nThis prevents old network updates from straying into a new level from the previous level.\n\nThis can be set to any number and then incremented with each new level load. This doesn't add overhead to network traffic but just diminishes the pool of network ViewID numbers a little bit.")]
	public class NetworkSetLevelPrefix : FsmStateAction
	{
		[RequiredField]
		[UIHint(UIHint.Variable)]
		[Tooltip("The level prefix which will then be prefixed to all network ViewID numbers.")]
		public FsmInt levelPrefix;

		public override void Reset()
		{
			levelPrefix = null;
		}

		public override void OnEnter()
		{
			if (levelPrefix.IsNone)
			{
				LogError("Network LevelPrefix not set");
				return;
			}
			// h
			Finish();
		}
	}
}
