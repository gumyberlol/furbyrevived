namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Convert)]
	[Tooltip("Converts a Float value to a String value with optional format.")]
	public class ConvertFloatToString : FsmStateAction
	{
		[Tooltip("The float variable to convert.")]
		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmFloat floatVariable;

		[Tooltip("A string variable to store the converted value.")]
		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmString stringVariable;

		[Tooltip("Optional Format, allows for leading zeroes. E.g., 0000")]
		public FsmString format;

		[Tooltip("Repeat every frame. Useful if the float variable is changing.")]
		public bool everyFrame;

		public override void Reset()
		{
			floatVariable = null;
			stringVariable = null;
			everyFrame = false;
			format = null;
		}

		public override void OnEnter()
		{
			DoConvertFloatToString();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoConvertFloatToString();
		}

		private void DoConvertFloatToString()
		{
			if (format.IsNone || string.IsNullOrEmpty(format.Value))
			{
				stringVariable.Value = floatVariable.Value.ToString();
			}
			else
			{
				stringVariable.Value = floatVariable.Value.ToString(format.Value);
			}
		}
	}
}
