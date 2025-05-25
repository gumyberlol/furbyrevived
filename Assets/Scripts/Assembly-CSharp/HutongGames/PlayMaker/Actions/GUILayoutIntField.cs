namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.GUILayout)]
	[Tooltip("GUILayout Text Field to edit an Int Variable. Optionally send an event if the text has been edited.")]
	public class GUILayoutIntField : GUILayoutAction
	{
		[UIHint(UIHint.Variable)]
		[Tooltip("Int Variable to show in the edit field.")]
		public FsmInt intVariable;

		[Tooltip("Optional GUIStyle in the active GUISKin.")]
		public FsmString style;

		[Tooltip("Optional event to send when the value changes.")]
		public FsmEvent changedEvent;

		public override void Reset()
		{
			base.Reset();
			intVariable = null;
			style = string.Empty;
			changedEvent = null;
		}
	}
}
