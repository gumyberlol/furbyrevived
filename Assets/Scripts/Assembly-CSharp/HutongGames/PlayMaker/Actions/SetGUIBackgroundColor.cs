using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.GUI)]
	[Tooltip("Sets the Tinting Color for all background elements rendered by the GUI. By default only effects GUI rendered by this FSM, check Apply Globally to effect all GUI controls.")]
	public class SetGUIBackgroundColor : FsmStateAction
	{
		[RequiredField]
		public FsmColor backgroundColor;

		public FsmBool applyGlobally;

		public override void Reset()
		{
			backgroundColor = Color.white;
		}
	}
}
