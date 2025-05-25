using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Animates the value of a Vector3 Variable using an Animation Curve.")]
	[ActionCategory(ActionCategory.AnimateVariables)]
	public class AnimateVector3 : AnimateFsmAction
	{
		[RequiredField]
		[UIHint(UIHint.Variable)]
		public FsmVector3 vectorVariable;

		[RequiredField]
		public FsmAnimationCurve curveX;

		[Tooltip("Calculation lets you set a type of curve deformation that will be applied to vectorVariable.x.")]
		public Calculation calculationX;

		[RequiredField]
		public FsmAnimationCurve curveY;

		[Tooltip("Calculation lets you set a type of curve deformation that will be applied to vectorVariable.y.")]
		public Calculation calculationY;

		[RequiredField]
		public FsmAnimationCurve curveZ;

		[Tooltip("Calculation lets you set a type of curve deformation that will be applied to vectorVariable.z.")]
		public Calculation calculationZ;

		private bool finishInNextStep;

		private Vector3 vct;

		public override void Reset()
		{
			base.Reset();
			vectorVariable = new FsmVector3
			{
				UseVariable = true
			};
		}

		public override void OnEnter()
		{
			base.OnEnter();
			finishInNextStep = false;
			resultFloats = new float[3];
			fromFloats = new float[3];
			fromFloats[0] = ((!vectorVariable.IsNone) ? vectorVariable.Value.x : 0f);
			fromFloats[1] = ((!vectorVariable.IsNone) ? vectorVariable.Value.y : 0f);
			fromFloats[2] = ((!vectorVariable.IsNone) ? vectorVariable.Value.z : 0f);
			curves = new AnimationCurve[3];
			curves[0] = curveX.curve;
			curves[1] = curveY.curve;
			curves[2] = curveZ.curve;
			calculations = new Calculation[3];
			calculations[0] = calculationX;
			calculations[1] = calculationY;
			calculations[2] = calculationZ;
			Init();
		}

		public override void OnUpdate()
		{
			base.OnUpdate();
			if (!vectorVariable.IsNone && isRunning)
			{
				vct = new Vector3(resultFloats[0], resultFloats[1], resultFloats[2]);
				vectorVariable.Value = vct;
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
				if (!vectorVariable.IsNone)
				{
					vct = new Vector3(resultFloats[0], resultFloats[1], resultFloats[2]);
					vectorVariable.Value = vct;
				}
				finishInNextStep = true;
			}
		}
	}
}
