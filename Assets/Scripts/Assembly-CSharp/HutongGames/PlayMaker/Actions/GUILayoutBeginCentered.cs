namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Begin a centered GUILayout block. The block is centered inside a parent GUILayout Area. So to place the block in the center of the screen, first use a GULayout Area the size of the whole screen (the default setting). NOTE: Block must end with a corresponding GUILayoutEndCentered.")]
	[ActionCategory(ActionCategory.GUILayout)]
	public class GUILayoutBeginCentered : FsmStateAction
	{
		public override void Reset()
		{
		}
	}
}
