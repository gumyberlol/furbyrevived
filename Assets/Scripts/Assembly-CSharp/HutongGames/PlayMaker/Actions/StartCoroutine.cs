using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Start a Coroutine in a Behaviour on a Game Object. See Unity StartCoroutine docs.")]
	[ActionCategory(ActionCategory.ScriptControl)]
	public class StartCoroutine : FsmStateAction
	{
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[RequiredField]
		[UIHint(UIHint.Behaviour)]
		public FsmString behaviour;

		[UIHint(UIHint.Coroutine)]
		[RequiredField]
		public FunctionCall functionCall;

		public bool stopOnExit;

		private MonoBehaviour component;

		public override void Reset()
		{
			gameObject = null;
			behaviour = null;
			functionCall = null;
			stopOnExit = false;
		}

		public override void OnEnter()
		{
			DoStartCoroutine();
			Finish();
		}

		private void DoStartCoroutine()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget == null)
			{
				return;
			}
			component = ownerDefaultTarget.GetComponent(behaviour.Value) as MonoBehaviour;
			if (component == null)
			{
				LogWarning("StartCoroutine: " + ownerDefaultTarget.name + " missing behaviour: " + behaviour.Value);
				return;
			}
			switch (functionCall.ParameterType)
			{
			case "None":
				component.StartCoroutine(functionCall.FunctionName);
				break;
			case "int":
				component.StartCoroutine(functionCall.FunctionName, functionCall.IntParameter.Value);
				break;
			case "float":
				component.StartCoroutine(functionCall.FunctionName, functionCall.FloatParameter.Value);
				break;
			case "string":
				component.StartCoroutine(functionCall.FunctionName, functionCall.StringParameter.Value);
				break;
			case "bool":
				component.StartCoroutine(functionCall.FunctionName, functionCall.BoolParameter.Value);
				break;
			case "Vector3":
				component.StartCoroutine(functionCall.FunctionName, functionCall.Vector3Parameter.Value);
				break;
			case "Rect":
				component.StartCoroutine(functionCall.FunctionName, functionCall.RectParamater.Value);
				break;
			case "GameObject":
				component.StartCoroutine(functionCall.FunctionName, functionCall.GameObjectParameter.Value);
				break;
			case "Material":
				component.StartCoroutine(functionCall.FunctionName, functionCall.MaterialParameter.Value);
				break;
			case "Texture":
				component.StartCoroutine(functionCall.FunctionName, functionCall.TextureParameter.Value);
				break;
			case "Quaternion":
				component.StartCoroutine(functionCall.FunctionName, functionCall.QuaternionParameter.Value);
				break;
			case "Object":
				component.StartCoroutine(functionCall.FunctionName, functionCall.ObjectParameter.Value);
				break;
			}
		}

		public override void OnExit()
		{
			if (!(component == null) && stopOnExit)
			{
				component.StopCoroutine(functionCall.FunctionName);
			}
		}
	}
}
