using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Device)]
	[Tooltip("Causes the device to vibrate for half a second.")]
	public class DeviceVibrate : FsmStateAction
	{
		public override void Reset()
		{
		}

		public override void OnEnter()
		{
			// Removed vibration call since it's not supported on this platform
			Finish(); // immediately finish the action
		}
	}
}
