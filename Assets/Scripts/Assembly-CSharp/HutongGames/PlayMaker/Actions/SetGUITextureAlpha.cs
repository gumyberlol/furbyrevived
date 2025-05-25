using UnityEngine;
using UnityEngine.UI; // For UI components like Image

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory("UI")]
	[Tooltip("Sets the Alpha of the UI.Image attached to a Game Object. Useful for fading UI elements in/out.")]
	public class SetUIImageAlpha : FsmStateAction
	{
		[CheckForComponent(typeof(Image))] // Check for UI.Image component
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[RequiredField]
		public FsmFloat alpha;

		public bool everyFrame;

		public override void Reset()
		{
			gameObject = null;
			alpha = 1f;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoUIImageAlpha();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoUIImageAlpha();
		}

		private void DoUIImageAlpha()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget != null && ownerDefaultTarget.GetComponent<Image>() != null)
			{
				Color color = ownerDefaultTarget.GetComponent<Image>().color;
				ownerDefaultTarget.GetComponent<Image>().color = new Color(color.r, color.g, color.b, alpha.Value);
			}
		}
	}
}
