using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Plays an Animation on a Game Object. You can add named animation clips to the object in the Unity editor, or with the Add Animation Clip action.")]
	[ActionCategory(ActionCategory.Animation)]
	public class PlayAnimation : FsmStateAction
	{
		[CheckForComponent(typeof(Animation))]
		[Tooltip("Game Object to play the animation on.")]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[UIHint(UIHint.Animation)]
		[Tooltip("The name of the animation to play.")]
		public FsmString animName;

		[Tooltip("How to treat previously playing animations.")]
		public PlayMode playMode;

		[Tooltip("Time taken to blend to this animation.")]
		[HasFloatSlider(0f, 5f)]
		public FsmFloat blendTime;

		[Tooltip("Event to send when the animation is finished playing. NOTE: Not sent with Loop or PingPong wrap modes!")]
		public FsmEvent finishEvent;

		[Tooltip("Event to send when the animation loops. If you want to send this event to another FSM use Set Event Target. NOTE: This event is only sent with Loop and PingPong wrap modes.")]
		public FsmEvent loopEvent;

		[Tooltip("Stop playing the animation when this state is exited.")]
		public bool stopOnExit;

		private AnimationState anim;

		private float prevAnimtTime;

		public override void Reset()
		{
			gameObject = null;
			animName = null;
			playMode = PlayMode.StopAll;
			blendTime = 0.3f;
			finishEvent = null;
			loopEvent = null;
			stopOnExit = false;
		}

		public override void OnEnter()
		{
			DoPlayAnimation();
		}

		private void DoPlayAnimation()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget == null || string.IsNullOrEmpty(animName.Value))
			{
				Finish();
				return;
			}
			if (string.IsNullOrEmpty(animName.Value))
			{
				LogWarning("Missing animName!");
				Finish();
				return;
			}
			if (ownerDefaultTarget.GetComponent<Animation>() == null)
			{
				LogWarning("Missing animation component!");
				Finish();
				return;
			}
			anim = ownerDefaultTarget.GetComponent<Animation>()[animName.Value];
			if (anim == null)
			{
				LogWarning("Missing animation: " + animName.Value);
				Finish();
				return;
			}
			float value = blendTime.Value;
			if (value < 0.001f)
			{
				ownerDefaultTarget.GetComponent<Animation>().Play(animName.Value, playMode);
			}
			else
			{
				ownerDefaultTarget.GetComponent<Animation>().CrossFade(animName.Value, value, playMode);
			}
			prevAnimtTime = anim.time;
		}

		public override void OnUpdate()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (!(ownerDefaultTarget == null) && !(anim == null))
			{
				if (!anim.enabled || (anim.wrapMode == WrapMode.ClampForever && anim.time > anim.length))
				{
					base.Fsm.Event(finishEvent);
					Finish();
				}
				if (anim.wrapMode != WrapMode.ClampForever && anim.time > anim.length && prevAnimtTime < anim.length)
				{
					base.Fsm.Event(loopEvent);
				}
			}
		}

		public override void OnExit()
		{
			if (stopOnExit)
			{
				StopAnimation();
			}
		}

		private void StopAnimation()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (ownerDefaultTarget != null && ownerDefaultTarget.GetComponent<Animation>() != null)
			{
				ownerDefaultTarget.GetComponent<Animation>().Stop(animName.Value);
			}
		}
	}
}
