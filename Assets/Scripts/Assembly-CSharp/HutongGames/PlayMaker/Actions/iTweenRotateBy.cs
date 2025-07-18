using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory("iTween")]
	[Tooltip("Multiplies supplied values by 360 and rotates a GameObject by calculated amount over time.")]
	public class iTweenRotateBy : iTweenFsmAction
	{
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[Tooltip("iTween ID. If set you can use iTween Stop action to stop it by its id.")]
		public FsmString id;

		[RequiredField]
		[Tooltip("A vector that will multiply current GameObjects rotation.")]
		public FsmVector3 vector;

		[Tooltip("The time in seconds the animation will take to complete.")]
		public FsmFloat time;

		[Tooltip("The time in seconds the animation will wait before beginning.")]
		public FsmFloat delay;

		[Tooltip("Can be used instead of time to allow animation based on speed. When you define speed the time variable is ignored.")]
		public FsmFloat speed;

		[Tooltip("For the shape of the easing curve applied to the animation.")]
		public iTween.EaseType easeType = iTween.EaseType.linear;

		[Tooltip("The type of loop to apply once the animation has completed.")]
		public iTween.LoopType loopType;

		public Space space;

		public override void Reset()
		{
			base.Reset();
			id = new FsmString
			{
				UseVariable = true
			};
			time = 1f;
			delay = 0f;
			loopType = iTween.LoopType.none;
			vector = new FsmVector3
			{
				UseVariable = true
			};
			speed = new FsmFloat
			{
				UseVariable = true
			};
			space = Space.World;
		}

		public override void OnEnter()
		{
			OnEnteriTween(gameObject);
			if (loopType != iTween.LoopType.none)
			{
				IsLoop(true);
			}
			DoiTween();
		}

		public override void OnExit()
		{
			OnExitiTween(gameObject);
		}

		private void DoiTween()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (!(ownerDefaultTarget == null))
			{
				Vector3 vector = Vector3.zero;
				if (!this.vector.IsNone)
				{
					vector = this.vector.Value;
				}
				itweenType = "rotate";
				iTween.RotateBy(ownerDefaultTarget, iTween.Hash("amount", vector, "name", (!id.IsNone) ? id.Value : string.Empty, (!speed.IsNone) ? "speed" : "time", (!speed.IsNone) ? speed.Value : ((!time.IsNone) ? time.Value : 1f), "delay", (!delay.IsNone) ? delay.Value : 0f, "easetype", easeType, "looptype", loopType, "oncomplete", "iTweenOnComplete", "oncompleteparams", itweenID, "onstart", "iTweenOnStart", "onstartparams", itweenID, "ignoretimescale", !realTime.IsNone && realTime.Value, "space", space));
			}
		}
	}
}
