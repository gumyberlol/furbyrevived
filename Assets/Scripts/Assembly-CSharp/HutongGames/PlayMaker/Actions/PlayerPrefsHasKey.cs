using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory("PlayerPrefs")]
	[Tooltip("Returns true if key exists in the preferences.")]
	public class PlayerPrefsHasKey : FsmStateAction
	{
		[RequiredField]
		public FsmString key;

		[Title("Store Result")]
		[UIHint(UIHint.Variable)]
		public FsmBool variable;

		[Tooltip("Event to send if key exists.")]
		public FsmEvent trueEvent;

		[Tooltip("Event to send if key does not exist.")]
		public FsmEvent falseEvent;

		public override void Reset()
		{
			key = string.Empty;
		}

		public override void OnEnter()
		{
			Finish();
			if (!key.IsNone && !key.Value.Equals(string.Empty))
			{
				variable.Value = PlayerPrefs.HasKey(key.Value);
			}
			base.Fsm.Event((!variable.Value) ? falseEvent : trueEvent);
		}
	}
}
