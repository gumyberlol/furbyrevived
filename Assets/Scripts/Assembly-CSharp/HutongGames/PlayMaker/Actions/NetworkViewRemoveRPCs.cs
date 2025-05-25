using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Remove the simulated RPC function calls associated with a Game Object.")]
	[ActionCategory(ActionCategory.StateMachine)]
	public class RemoveSimulatedRPCs : FsmStateAction
	{
		[Tooltip("The GameObject to remove the simulated RPC calls from.")]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		public override void Reset()
		{
			gameObject = null;
		}

		public override void OnEnter()
		{
			DoRemoveSimulatedRPCs();
			Finish();
		}

		private void DoRemoveSimulatedRPCs()
		{
			GameObject target = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (target != null)
			{
				// Simulate removal of RPCs here
				// For non-networked games, you could implement a custom system to handle "simulated" RPC calls
				Debug.Log("Removing simulated RPCs for: " + target.name);

				// Example: Custom logic for removing RPCs in a non-networked context
				// You can implement your own RPC handling here or simply track local game state changes
			}
		}
	}
}
