namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Draws a state label for this FSM in the Game View. The label is drawn on the game object that owns the FSM. Use this to override the global setting in the PlayMaker Debug menu.")]
	[ActionCategory(ActionCategory.Debug)]
	public class DrawStateLabel : FsmStateAction
	{
		[RequiredField]
		public FsmBool showLabel;

		public override void Reset()
		{
			showLabel = true;
		}

		public override void OnEnter()
		{
			base.Fsm.ShowStateLabel = showLabel.Value;
			Finish();
		}
	}
}
