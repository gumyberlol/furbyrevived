using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Delays a State from finishing by the specified time. NOTE: Other actions continue, but FINISHED can't happen before Time.")]
	[ActionCategory(ActionCategory.Time)]
	public class Wait : FsmStateAction
	{
		[RequiredField]
		public FsmFloat time;

		public FsmEvent finishEvent;

		public bool realTime;

		private float startTime;

		private float timer;

		public override void Reset()
		{
			time = 1f;
			finishEvent = null;
			realTime = false;
		}

		public override void OnEnter()
		{
			if (time.Value <= 0f)
			{
				Finish();
				return;
			}
			startTime = FsmTime.RealtimeSinceStartup;
			timer = 0f;
		}

		public override void OnUpdate()
		{
			if (realTime)
			{
				timer = FsmTime.RealtimeSinceStartup - startTime;
			}
			else
			{
				timer += Time.deltaTime;
			}
			if (timer >= time.Value)
			{
				Finish();
				if (finishEvent != null)
				{
					base.Fsm.Event(finishEvent);
				}
			}
		}
	}
}
