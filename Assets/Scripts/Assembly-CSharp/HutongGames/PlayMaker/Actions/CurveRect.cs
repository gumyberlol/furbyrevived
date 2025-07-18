using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Animates the value of a Rect Variable FROM-TO with assistance of Deformation Curves.")]
	[ActionCategory("AnimateVariables")]
	public class CurveRect : CurveFsmAction
	{
		[RequiredField]
		[UIHint(UIHint.Variable)]
		public FsmRect rectVariable;

		[RequiredField]
		public FsmRect fromValue;

		[RequiredField]
		public FsmRect toValue;

		[RequiredField]
		public FsmAnimationCurve curveX;

		[Tooltip("Calculation lets you set a type of curve deformation that will be applied to otherwise linear move between fromValue.x and toValue.x.")]
		public Calculation calculationX;

		[RequiredField]
		public FsmAnimationCurve curveY;

		[Tooltip("Calculation lets you set a type of curve deformation that will be applied to otherwise linear move between fromValue.y and toValue.y.")]
		public Calculation calculationY;

		[RequiredField]
		public FsmAnimationCurve curveW;

		[Tooltip("Calculation lets you set a type of curve deformation that will be applied to otherwise linear move between fromValue.width and toValue.width.")]
		public Calculation calculationW;

		[RequiredField]
		public FsmAnimationCurve curveH;

		[Tooltip("Calculation lets you set a type of curve deformation that will be applied to otherwise linear move between fromValue.height and toValue.height.")]
		public Calculation calculationH;

		private Rect rct;

		private bool finishInNextStep;

		public override void Reset()
		{
			base.Reset();
			rectVariable = new FsmRect
			{
				UseVariable = true
			};
			toValue = new FsmRect
			{
				UseVariable = true
			};
			fromValue = new FsmRect
			{
				UseVariable = true
			};
		}

		public override void OnEnter()
		{
			base.OnEnter();
			finishInNextStep = false;
			resultFloats = new float[4];
			fromFloats = new float[4];
			fromFloats[0] = ((!fromValue.IsNone) ? fromValue.Value.x : 0f);
			fromFloats[1] = ((!fromValue.IsNone) ? fromValue.Value.y : 0f);
			fromFloats[2] = ((!fromValue.IsNone) ? fromValue.Value.width : 0f);
			fromFloats[3] = ((!fromValue.IsNone) ? fromValue.Value.height : 0f);
			toFloats = new float[4];
			toFloats[0] = ((!toValue.IsNone) ? toValue.Value.x : 0f);
			toFloats[1] = ((!toValue.IsNone) ? toValue.Value.y : 0f);
			toFloats[2] = ((!toValue.IsNone) ? toValue.Value.width : 0f);
			toFloats[3] = ((!toValue.IsNone) ? toValue.Value.height : 0f);
			curves = new AnimationCurve[4];
			curves[0] = curveX.curve;
			curves[1] = curveY.curve;
			curves[2] = curveW.curve;
			curves[3] = curveH.curve;
			calculations = new Calculation[4];
			calculations[0] = calculationX;
			calculations[1] = calculationY;
			calculations[2] = calculationW;
			calculations[2] = calculationH;
			Init();
		}

		public override void OnExit()
		{
		}

		public override void OnUpdate()
		{
			base.OnUpdate();
			if (!rectVariable.IsNone && isRunning)
			{
				rct = new Rect(resultFloats[0], resultFloats[1], resultFloats[2], resultFloats[3]);
				rectVariable.Value = rct;
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
				if (!rectVariable.IsNone)
				{
					rct = new Rect(resultFloats[0], resultFloats[1], resultFloats[2], resultFloats[3]);
					rectVariable.Value = rct;
				}
				finishInNextStep = true;
			}
		}
	}
}
