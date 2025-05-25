using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.GameObject)]
	[Tooltip("Activates/deactivates a Game Object. Use this to hide/show areas, or enable/disable many Behaviours at once.")]
	public class ActivateGameObject : FsmStateAction
	{
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[RequiredField]
		[Tooltip("Check to activate, uncheck to deactivate Game Object.")]
		public FsmBool activate;

		[Tooltip("Reset the game objects when exiting this state. Useful if you want an object to be active only while this state is active.\nNote: Only applies to the last Game Object activated/deactivated (won't work if Game Object changes).")]
		public bool resetOnExit;

		[Tooltip("Repeat this action every frame. Useful if Activate changes over time.")]
		public bool everyFrame;

		private GameObject activatedGameObject;

		public override void Reset()
		{
			gameObject = null;
			activate = true;
			resetOnExit = false;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoActivateGameObject();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoActivateGameObject();
		}

		public override void OnExit()
		{
			if (!(activatedGameObject == null) && resetOnExit)
			{
				activatedGameObject.SetActive(!activate.Value);
			}
		}

		private void DoActivateGameObject()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (!(ownerDefaultTarget == null))
			{
				ownerDefaultTarget.SetActive(activate.Value);
				activatedGameObject = ownerDefaultTarget;
			}
		}
	}
}
