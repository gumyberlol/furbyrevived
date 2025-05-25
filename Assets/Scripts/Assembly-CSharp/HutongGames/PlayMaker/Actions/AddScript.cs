using UnityEngine;
using System;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Adds a Script to a Game Object. Use this to change the behaviour of objects on the fly. Optionally remove the Script on exiting the state.")]
	[ActionCategory(ActionCategory.ScriptControl)]
	public class AddScript : FsmStateAction
	{
		[Tooltip("The Game Object to add the script to.")]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[RequiredField]
		[Tooltip("The Script to add to the Game Object.")]
		[UIHint(UIHint.ScriptComponent)]
		public FsmString script;

		[Tooltip("Remove the script from the Game Object when this State is exited.")]
		public FsmBool removeOnExit;

		private Component addedComponent;

		public override void Reset()
		{
			gameObject = null;
			script = null;
			removeOnExit = false;
		}

		public override void OnEnter()
		{
			GameObject go = Fsm.GetOwnerDefaultTarget(gameObject);
			DoAddComponent(go);
			Finish();
		}

		public override void OnExit()
		{
			if (removeOnExit.Value && addedComponent != null)
			{
				UnityEngine.Object.Destroy(addedComponent);
			}
		}

		private void DoAddComponent(GameObject go)
		{
			if (go == null || string.IsNullOrEmpty(script.Value)) return;

			Type type = Type.GetType(script.Value);
			if (type == null)
			{
				LogError("Can't find script type: " + script.Value);
				return;
			}

			addedComponent = go.AddComponent(type);
			if (addedComponent == null)
			{
				LogError("Failed to add script: " + script.Value);
			}
		}
	}
}
