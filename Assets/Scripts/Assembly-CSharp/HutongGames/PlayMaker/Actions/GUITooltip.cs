namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.GUI)]
	[Tooltip("Gets the Tooltip of the control the mouse is currently over and store it in a String Variable.")]
	public class GUITooltip : FsmStateAction
	{
		[UIHint(UIHint.Variable)]
		public FsmString storeTooltip;

		public override void Reset()
		{
			storeTooltip = null;
		}
	}
}
