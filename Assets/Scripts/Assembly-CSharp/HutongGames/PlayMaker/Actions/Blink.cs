using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Effects)]
	[Tooltip("Turns a Game Object on/off in a regular repeating pattern.")]
	public class Blink : FsmStateAction
	{
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[HasFloatSlider(0f, 5f)]
		public FsmFloat timeOff;

		[HasFloatSlider(0f, 5f)]
		public FsmFloat timeOn;

		[Tooltip("Should the object start in the active/visible state?")]
		public FsmBool startOn;

		[Tooltip("Check this to keep the object active, but not rendered.")]
		public bool rendererOnly;

		[Tooltip("Ignore TimeScale. Useful if the game is paused.")]
		public bool realTime;

		private float startTime;

		private float timer;

		private bool blinkOn;

		public override void Reset()
		{
			gameObject = null;
			timeOff = 0.5f;
			timeOn = 0.5f;
			rendererOnly = true;
			startOn = false;
			realTime = false;
		}

		public override void OnEnter()
		{
			startTime = FsmTime.RealtimeSinceStartup;
			timer = 0f;
			UpdateBlinkState(startOn.Value);
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
			if (blinkOn && timer > timeOn.Value)
			{
				UpdateBlinkState(false);
			}
			if (!blinkOn && timer > timeOff.Value)
			{
				UpdateBlinkState(true);
			}
		}

		private void UpdateBlinkState(bool state)
		{
			GameObject gameObject = ((this.gameObject.OwnerOption != OwnerDefaultOption.UseOwner) ? this.gameObject.GameObject.Value : base.Owner);
			if (gameObject == null)
			{
				return;
			}
			if (rendererOnly)
			{
				if (gameObject.GetComponent<Renderer>() != null)
				{
					gameObject.GetComponent<Renderer>().enabled = state;
				}
			}
			else
			{
				gameObject.SetActive(state);
			}
			blinkOn = state;
			startTime = FsmTime.RealtimeSinceStartup;
			timer = 0f;
		}
	}
}
