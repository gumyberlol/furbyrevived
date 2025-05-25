using UnityEngine;
using UnityEngine.UI; // For UI components like Image

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Sets the Color of the UI.Image attached to a Game Object.")]
	[ActionCategory("UI")]
	public class SetUIImageColor : FsmStateAction
	{
		[CheckForComponent(typeof(Image))] // Check for UI.Image component
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[RequiredField]
		public FsmColor color;

		public bool everyFrame;

		public override void Reset()
		{
			gameObject = null;
			color = Color.white;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoSetUIImageColor();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoSetUIImageColor();
		}

		private void DoSetUIImageColor()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget != null && ownerDefaultTarget.GetComponent<Image>() != null)
			{
				ownerDefaultTarget.GetComponent<Image>().color = color.Value;
			}
		}
	}
}
