namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Math)]
	[Tooltip("Sets the value of a Bool Variable.")]
	public class SetBoolValue : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmBool boolVariable;

		[RequiredField]
		public FsmBool boolValue;

		public bool everyFrame;

		public override void Reset()
		{
			boolVariable = null;
			boolValue = null;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			boolVariable.Value = boolValue.Value;
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			boolVariable.Value = boolValue.Value;
		}
	}
}
