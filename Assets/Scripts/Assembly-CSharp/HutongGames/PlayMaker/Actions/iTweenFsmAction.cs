using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("iTween base action - don't use!")]
	public abstract class iTweenFsmAction : FsmStateAction
	{
		public enum AxisRestriction
		{
			none = 0,
			x = 1,
			y = 2,
			z = 3,
			xy = 4,
			xz = 5,
			yz = 6
		}

		[ActionSection("Events")]
		public FsmEvent startEvent;

		public FsmEvent finishEvent;

		[Tooltip("Setting this to true will allow the animation to continue independent of the current time which is helpful for animating menus after a game has been paused by setting Time.timeScale=0.")]
		public FsmBool realTime;

		public FsmBool stopOnExit;

		public FsmBool loopDontFinish;

		internal iTweenFSMEvents itweenEvents;

		protected string itweenType = string.Empty;

		protected int itweenID = -1;

		public override void Reset()
		{
			startEvent = null;
			finishEvent = null;
			realTime = new FsmBool
			{
				Value = false
			};
			stopOnExit = new FsmBool
			{
				Value = true
			};
			loopDontFinish = new FsmBool
			{
				Value = true
			};
			itweenType = string.Empty;
		}

		protected void OnEnteriTween(FsmOwnerDefault anOwner)
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(anOwner);
			itweenEvents = (iTweenFSMEvents)ownerDefaultTarget.AddComponent<iTweenFSMEvents>();
			itweenEvents.itweenFSMAction = this;
			iTweenFSMEvents.itweenIDCount++;
			itweenID = iTweenFSMEvents.itweenIDCount;
			itweenEvents.itweenID = iTweenFSMEvents.itweenIDCount;
			itweenEvents.donotfinish = !loopDontFinish.IsNone && loopDontFinish.Value;
		}

		protected void IsLoop(bool aValue)
		{
			if (itweenEvents != null)
			{
				itweenEvents.islooping = aValue;
			}
		}

		protected void OnExitiTween(FsmOwnerDefault anOwner)
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(anOwner);
			if ((bool)itweenEvents)
			{
				Object.Destroy(itweenEvents);
			}
			if (stopOnExit.IsNone)
			{
				iTween.Stop(ownerDefaultTarget, itweenType);
			}
			else if (stopOnExit.Value)
			{
				iTween.Stop(ownerDefaultTarget, itweenType);
			}
		}
	}
}
