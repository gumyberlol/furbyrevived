using UnityEngine;
using UnityEngine.UI; // For UI components like Text and Image

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Sets the Image used by the UI.Image attached to a Game Object.")]
	[ActionCategory("UI")]
	public class SetUIImage : FsmStateAction
	{
		[RequiredField]
		[CheckForComponent(typeof(Image))] // Checking for UI.Image instead of GUITexture
		public FsmOwnerDefault gameObject;

		public FsmTexture texture;

		public override void Reset()
		{
			gameObject = null;
			texture = null;
		}

		public override void OnEnter()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget != null && ownerDefaultTarget.GetComponent<Image>() != null)
			{
				ownerDefaultTarget.GetComponent<Image>().sprite = Sprite.Create((Texture2D)texture.Value, new Rect(0, 0, texture.Value.width, texture.Value.height), new Vector2(0.5f, 0.5f));
			}
			Finish();
		}
	}
}
