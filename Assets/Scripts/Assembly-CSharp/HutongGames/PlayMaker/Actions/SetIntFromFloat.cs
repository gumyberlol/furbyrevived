namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Math)]
	[Tooltip("Sets the value of an integer variable using a float value.")]
	public class SetIntFromFloat : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmInt intVariable;

		public FsmFloat floatValue;

		public bool everyFrame;

		public override void Reset()
		{
			intVariable = null;
			floatValue = null;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			intVariable.Value = (int)floatValue.Value;
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			intVariable.Value = (int)floatValue.Value;
		}
	}
}
