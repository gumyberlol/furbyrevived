using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.GameObject)]
	[Tooltip("Checks if an Object has a Component. Optionally remove the Component on exiting the state.")]
	public class HasComponent : FsmStateAction
	{
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[UIHint(UIHint.ScriptComponent)]
		[RequiredField]
		public FsmString component;

		public FsmBool removeOnExit;

		public FsmEvent trueEvent;

		public FsmEvent falseEvent;

		[UIHint(UIHint.Variable)]
		public FsmBool store;

		public bool everyFrame;

		private Component aComponent;

		public override void Reset()
		{
			aComponent = null;
			gameObject = null;
			trueEvent = null;
			falseEvent = null;
			component = null;
			store = null;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoHasComponent((gameObject.OwnerOption != OwnerDefaultOption.UseOwner) ? gameObject.GameObject.Value : base.Owner);
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoHasComponent((gameObject.OwnerOption != OwnerDefaultOption.UseOwner) ? gameObject.GameObject.Value : base.Owner);
		}

		public override void OnExit()
		{
			if (removeOnExit.Value && aComponent != null)
			{
				Object.Destroy(aComponent);
			}
		}

		private void DoHasComponent(GameObject go)
		{
			aComponent = go.GetComponent(component.Value);
			base.Fsm.Event((!(aComponent != null)) ? falseEvent : trueEvent);
		}
	}
}
