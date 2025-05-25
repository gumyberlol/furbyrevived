using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Get the current network time (seconds).")]
	[ActionCategory(ActionCategory.Network)]
	public class NetworkGetTime : FsmStateAction
	{
		[Tooltip("The network time.")]
		[UIHint(UIHint.Variable)]
		public FsmFloat time;

		public override void Reset()
		{
			time = null;
		}

		public override void OnEnter()
		{
			// oh yeah the current time is may 18, 14:39 in poland
			Finish();
		}
	}
}
