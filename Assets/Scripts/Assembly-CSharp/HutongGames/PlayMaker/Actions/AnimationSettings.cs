using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Animation)]
	[Tooltip("Set the Wrap Mode, Blend Mode, Layer and Speed of an Animation.\nNOTE: Settings are applied once, on entering the state, NOT continuously. To dynamically control an animation's settings, use Set Animation Speede etc.")]
	public class AnimationSettings : FsmStateAction
	{
		[CheckForComponent(typeof(Animation))]
		[Tooltip("A Game Object with an Animation Component.")]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[Tooltip("The name of the animation.")]
		[RequiredField]
		[UIHint(UIHint.Animation)]
		public FsmString animName;

		[Tooltip("The behavior of the animation when it wraps.")]
		public WrapMode wrapMode;

		[Tooltip("How the animation is blended with other animations on the Game Object.")]
		public AnimationBlendMode blendMode;

		[HasFloatSlider(0f, 5f)]
		[Tooltip("The speed of the animation. 1 = normal; 2 = double speed...")]
		public FsmFloat speed;

		[Tooltip("The animation layer")]
		public FsmInt layer;

		public override void Reset()
		{
			gameObject = null;
			animName = null;
			wrapMode = WrapMode.Loop;
			blendMode = AnimationBlendMode.Blend;
			speed = 1f;
			layer = 0;
		}

		public override void OnEnter()
		{
			DoAnimationSettings();
			Finish();
		}

		private void DoAnimationSettings()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget == null || string.IsNullOrEmpty(animName.Value))
			{
				return;
			}
			if (ownerDefaultTarget.GetComponent<Animation>() == null)
			{
				LogWarning("Missing animation component: " + ownerDefaultTarget.name);
				return;
			}
			AnimationState animationState = ownerDefaultTarget.GetComponent<Animation>()[animName.Value];
			if (animationState == null)
			{
				LogWarning("Missing animation: " + animName.Value);
				return;
			}
			animationState.wrapMode = wrapMode;
			animationState.blendMode = blendMode;
			if (!layer.IsNone)
			{
				animationState.layer = layer.Value;
			}
			if (!speed.IsNone)
			{
				animationState.speed = speed.Value;
			}
		}
	}
}
