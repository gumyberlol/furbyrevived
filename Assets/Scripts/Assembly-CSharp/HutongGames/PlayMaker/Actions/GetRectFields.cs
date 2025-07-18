namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Rect)]
	[Tooltip("Get the individual fields of a Rect Variable and store them in Float Variables.")]
	public class GetRectFields : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmRect rectVariable;

		[UIHint(UIHint.Variable)]
		public FsmFloat storeX;

		[UIHint(UIHint.Variable)]
		public FsmFloat storeY;

		[UIHint(UIHint.Variable)]
		public FsmFloat storeWidth;

		[UIHint(UIHint.Variable)]
		public FsmFloat storeHeight;

		public bool everyFrame;

		public override void Reset()
		{
			rectVariable = null;
			storeX = null;
			storeY = null;
			storeWidth = null;
			storeHeight = null;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoGetRectFields();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoGetRectFields();
		}

		private void DoGetRectFields()
		{
			if (!rectVariable.IsNone)
			{
				storeX.Value = rectVariable.Value.x;
				storeY.Value = rectVariable.Value.y;
				storeWidth.Value = rectVariable.Value.width;
				storeHeight.Value = rectVariable.Value.height;
			}
		}
	}
}
