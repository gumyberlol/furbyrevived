namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Easing Animation - Float")]
	[ActionCategory(ActionCategory.AnimateVariables)]
	public class EaseFloat : EaseFsmAction
	{
		[RequiredField]
		public FsmFloat fromValue;

		[RequiredField]
		public FsmFloat toValue;

		[UIHint(UIHint.Variable)]
		public FsmFloat floatVariable;

		private bool finishInNextStep;

		public override void Reset()
		{
			base.Reset();
			floatVariable = null;
			fromValue = null;
			toValue = null;
			finishInNextStep = false;
		}

		public override void OnEnter()
		{
			base.OnEnter();
			fromFloats = new float[1];
			fromFloats[0] = fromValue.Value;
			toFloats = new float[1];
			toFloats[0] = toValue.Value;
			resultFloats = new float[1];
			finishInNextStep = false;
		}

		public override void OnExit()
		{
			base.OnExit();
		}

		public override void OnUpdate()
		{
			base.OnUpdate();
			if (!floatVariable.IsNone && isRunning)
			{
				floatVariable.Value = resultFloats[0];
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
				if (!floatVariable.IsNone)
				{
					floatVariable.Value = (reverse.IsNone ? toValue.Value : ((!reverse.Value) ? toValue.Value : fromValue.Value));
				}
				finishInNextStep = true;
			}
		}
	}
}
