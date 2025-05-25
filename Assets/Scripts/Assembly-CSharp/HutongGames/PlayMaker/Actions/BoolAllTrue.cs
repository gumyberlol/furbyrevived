namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Tests if all the given Bool Variables are True.")]
	[ActionCategory(ActionCategory.Logic)]
	public class BoolAllTrue : FsmStateAction
	{
		[RequiredField]
		[UIHint(UIHint.Variable)]
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
			DoAllTrue();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoAllTrue();
		}

		private void DoAllTrue()
		{
			if (boolVariables.Length == 0)
			{
				return;
			}
			bool flag = true;
			for (int i = 0; i < boolVariables.Length; i++)
			{
				if (!boolVariables[i].Value)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				base.Fsm.Event(sendEvent);
			}
			storeResult.Value = flag;
		}
	}
}
