using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.AnimateVariables)]
	[Tooltip("Easing Animation - Vector3")]
	public class EaseVector3 : EaseFsmAction
	{
		[RequiredField]
		public FsmVector3 fromValue;

		[RequiredField]
		public FsmVector3 toValue;

		[UIHint(UIHint.Variable)]
		public FsmVector3 vector3Variable;

		private bool finishInNextStep;

		public override void Reset()
		{
			base.Reset();
			vector3Variable = null;
			fromValue = null;
			toValue = null;
			finishInNextStep = false;
		}

		public override void OnEnter()
		{
			base.OnEnter();
			fromFloats = new float[3];
			fromFloats[0] = fromValue.Value.x;
			fromFloats[1] = fromValue.Value.y;
			fromFloats[2] = fromValue.Value.z;
			toFloats = new float[3];
			toFloats[0] = toValue.Value.x;
			toFloats[1] = toValue.Value.y;
			toFloats[2] = toValue.Value.z;
			resultFloats = new float[3];
			finishInNextStep = false;
		}

		public override void OnExit()
		{
			base.OnExit();
		}

		public override void OnUpdate()
		{
			base.OnUpdate();
			if (!vector3Variable.IsNone && isRunning)
			{
				vector3Variable.Value = new Vector3(resultFloats[0], resultFloats[1], resultFloats[2]);
			}
			if (finishInNextStep)
			{
				Finish();
				if (finishEvent != null)
				{
					base.Fsm.Event(finishEvent);
				}
			}
			if (finishAction && !finishInNextStep)
			{
				if (!vector3Variable.IsNone)
				{
					vector3Variable.Value = new Vector3(reverse.IsNone ? toValue.Value.x : ((!reverse.Value) ? toValue.Value.x : fromValue.Value.x), reverse.IsNone ? toValue.Value.y : ((!reverse.Value) ? toValue.Value.y : fromValue.Value.y), reverse.IsNone ? toValue.Value.z : ((!reverse.Value) ? toValue.Value.z : fromValue.Value.z));
				}
				finishInNextStep = true;
			}
		}
	}
}
