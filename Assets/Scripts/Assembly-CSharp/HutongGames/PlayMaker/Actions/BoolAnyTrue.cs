namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Logic)]
	[Tooltip("Tests if any of the given Bool Variables are True.")]
	public class BoolAnyTrue : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmBool[] boolVariables;

		public FsmEvent sendEvent;

		[UIHint(UIHint.Variable)]
		public FsmBool storeResult;

		public bool everyFrame;

		public override void Reset()
		{
			boolVariables = null;
			sendEvent = null;
			storeResult = null;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoAnyTrue();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoAnyTrue();
		}

		private void DoAnyTrue()
		{
			if (boolVariables.Length == 0)
			{
				return;
			}
			storeResult.Value = false;
			for (int i = 0; i < boolVariables.Length; i++)
			{
				if (boolVariables[i].Value)
				{
					base.Fsm.Event(sendEvent);
					storeResult.Value = true;
					break;
				}
			}
		}
	}
}
