using UnityEngine;
using UnityEngine.UI; // Add this namespace for the Text component

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.GUIElement)]
	[Tooltip("Sets the Text used by the Text Component attached to a Game Object.")]
	public class SetGUIText : FsmStateAction
	{
		[RequiredField]
		[CheckForComponent(typeof(Text))] // Change to Text instead of GUIText
		public FsmOwnerDefault gameObject;

		public FsmString text;

		public bool everyFrame;

		public override void Reset()
		{
			gameObject = null;
			text = string.Empty;
		}

		public override void OnEnter()
		{
			DoSetGUIText();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoSetGUIText();
		}

		private void DoSetGUIText()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget != null)
			{
				// Use the Text component instead of GUIText
				Text guiText = ownerDefaultTarget.GetComponent<Text>();
				if (guiText != null)
				{
					guiText.text = text.Value;
				}
			}
		}
	}
}
