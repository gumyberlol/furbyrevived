namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Convert)]
	[Tooltip("Converts a Bool value to a String value.")]
	public class ConvertBoolToString : FsmStateAction
	{
		[RequiredField]
		[UIHint(UIHint.Variable)]
		[Tooltip("The bool variable to test.")]
		public FsmBool boolVariable;

		[UIHint(UIHint.Variable)]
		[RequiredField]
		[Tooltip("The string variable to set based on the bool variable value.")]
		public FsmString stringVariable;

		[Tooltip("String value if bool variable is false.")]
		public FsmString falseString;

		[Tooltip("String value if bool variable is true.")]
		public FsmString trueString;

		[Tooltip("Repeat every frame. Useful if the bool variable is changing.")]
		public bool everyFrame;

		public override void Reset()
		{
			boolVariable = null;
			stringVariable = null;
			falseString = "False";
			trueString = "True";
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoConvertBoolToString();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoConvertBoolToString();
		}

		private void DoConvertBoolToString()
		{
			stringVariable.Value = ((!boolVariable.Value) ? falseString.Value : trueString.Value);
		}
	}
}
