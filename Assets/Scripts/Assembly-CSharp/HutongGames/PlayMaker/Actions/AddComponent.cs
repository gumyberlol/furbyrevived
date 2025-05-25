using UnityEngine;
using System;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.GameObject)]
	[Tooltip("Adds a Component to a Game Object. Use this to change the behaviour of objects on the fly. Optionally remove the Component on exiting the state.")]
	public class AddComponent : FsmStateAction
	{
		[Tooltip("The Game Object to add the Component to.")]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[Tooltip("The Component to add to the Game Object.")]
		[UIHint(UIHint.ScriptComponent)]
		[RequiredField]
		public FsmString component;

		[Tooltip("Remove the Component when this State is exited.")]
		public FsmBool removeOnExit;

		private Component addedComponent;

		public override void Reset()
		{
			gameObject = null;
			component = null;
			removeOnExit = false;
		}

		public override void OnEnter()
		{
			DoAddComponent();
			Finish();
		}

		public override void OnExit()
		{
			if (removeOnExit.Value && addedComponent != null)
			{
				UnityEngine.Object.Destroy(addedComponent);
			}
		}

		private void DoAddComponent()
		{
			GameObject target = Fsm.GetOwnerDefaultTarget(gameObject);
			if (target == null || string.IsNullOrEmpty(component.Value)) return;

			// Try to find the type by name
			Type type = Type.GetType(component.Value);
			if (type == null)
			{
				LogError("Can't find type: " + component.Value);
				return;
			}

			addedComponent = target.AddComponent(type);
			if (addedComponent == null)
			{
				LogError("Failed to add component: " + component.Value);
			}
		}
	}
}
