namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Begins a ScrollView. Use GUILayoutEndScrollView at the end of the block.")]
	[ActionCategory(ActionCategory.GUILayout)]
	public class GUILayoutBeginScrollView : GUILayoutAction
	{
		[Tooltip("Assign a Vector2 variable to store the scroll position of this view.")]
		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmVector2 scrollPosition;

		[Tooltip("Always show the horizontal scrollbars.")]
		public FsmBool horizontalScrollbar;

		[Tooltip("Always show the vertical scrollbars.")]
		public FsmBool verticalScrollbar;

		[Tooltip("Define custom styles below. NOTE: You have to define all the styles if you check this option.")]
		public FsmBool useCustomStyle;

		[Tooltip("Named style in the active GUISkin for the horizontal scrollbars.")]
		public FsmString horizontalStyle;

		[Tooltip("Named style in the active GUISkin for the vertical scrollbars.")]
		public FsmString verticalStyle;

		[Tooltip("Named style in the active GUISkin for the background.")]
		public FsmString backgroundStyle;

		public override void Reset()
		{
			base.Reset();
			scrollPosition = null;
			horizontalScrollbar = null;
			verticalScrollbar = null;
			useCustomStyle = null;
			horizontalStyle = null;
			verticalStyle = null;
			backgroundStyle = null;
		}
	}
}
