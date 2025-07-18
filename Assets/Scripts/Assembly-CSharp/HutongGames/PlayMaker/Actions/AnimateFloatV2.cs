using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Animates the value of a Float Variable using an Animation Curve.")]
	[ActionCategory(ActionCategory.AnimateVariables)]
	public class AnimateFloatV2 : AnimateFsmAction
	{
		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmFloat floatVariable;

		[RequiredField]
		public FsmAnimationCurve animCurve;

		[Tooltip("Calculation lets you set a type of curve deformation that will be applied to floatVariable")]
		public Calculation calculation;

		private bool finishInNextStep;

		public override void Reset()
		{
			base.Reset();
			floatVariable = new FsmFloat
			{
				UseVariable = true
			};
		}

		public override void OnEnter()
		{
			base.OnEnter();
			finishInNextStep = false;
			resultFloats = new float[1];
			fromFloats = new float[1];
			fromFloats[0] = ((!floatVariable.IsNone) ? floatVariable.Value : 0f);
			calculations = new Calculation[1];
			calculations[0] = calculation;
			curves = new AnimationCurve[1];
			curves[0] = animCurve.curve;
			Init();
		}

		public override void OnExit()
		{
		}

		public override void OnUpdate()
		{
			base.OnUpdate();
			if (!floatVariable.IsNone && isRunning)
			{
				floatVariable.Value = resultFloats[0];
			}
			if (finishInNextStep && !looping)
			{
				Finish();
				if (finishEvent != null)
				{
					base.Fsm.Event(finishEvent);
				}
			}
			if (finishAction && !finishInNextStep)
			{
				if (!floatVariable.IsNone)
				{
					floatVariable.Value = resultFloats[0];
				}
				finishInNextStep = true;
			}
		}
	}
}
