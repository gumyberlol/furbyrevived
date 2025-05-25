using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Send an Fsm Event.")]
	[ActionCategory(ActionCategory.StateMachine)]
	public class SendRemoteEvent : FsmStateAction
	{
		[RequiredField]
		[Tooltip("The game object that sends the event.")]
		public FsmOwnerDefault gameObject;

		[Tooltip("The event you want to send.")]
		[RequiredField]
		public FsmEvent remoteEvent;

		[Tooltip("Optional string data. Use 'Get Event Info' action to retrieve it.")]
		public FsmString stringData;

		public override void Reset()
		{
			gameObject = null;
			remoteEvent = null;
			stringData = null;
		}

		public override void OnEnter()
		{
			DoRemoteEvent();
			Finish();
		}

		private void DoRemoteEvent()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget != null)
			{
				// Send event locally to the target object
				if (!stringData.IsNone && !string.IsNullOrEmpty(stringData.Value))
				{
					// Do something with stringData.Value (e.g., log or trigger a local action)
					Debug.Log($"Sending event {remoteEvent.Name} with data: {stringData.Value}");
				}
				else
				{
					// Trigger event without data
					Debug.Log($"Sending event {remoteEvent.Name}");
				}

				// Here you can add any custom logic you'd like for the event
				// For example, calling a method on the target object or triggering a local action
			}
		}
	}
}
