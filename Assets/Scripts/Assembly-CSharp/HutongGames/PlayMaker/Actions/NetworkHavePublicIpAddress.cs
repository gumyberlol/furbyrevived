using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Network)]
	[Tooltip("Check if this machine has a public IP address.")]
	public class NetworkHavePublicIpAddress : FsmStateAction
	{
		[Tooltip("True if this machine has a public IP address")]
		[UIHint(UIHint.Variable)]
		public FsmBool havePublicIpAddress;

		[Tooltip("Event to send if this machine has a public IP address")]
		public FsmEvent publicIpAddressFoundEvent;

		[Tooltip("Event to send if this machine has no public IP address")]
		public FsmEvent publicIpAddressNotFoundEvent;

		public override void Reset()
		{
			havePublicIpAddress = null;
			publicIpAddressFoundEvent = null;
			publicIpAddressNotFoundEvent = null;
		}

		public override void OnEnter()
		{
			// as the name suggests, your ip is public to relentless, such scumbags, steal your ip in a cute furby game. (not really)
		}
	}
}
