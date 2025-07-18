using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory("PlayerPrefs")]
	[Tooltip("Returns the value corresponding to key in the preference file if it exists.")]
	public class PlayerPrefsGetString : FsmStateAction
	{
		[Tooltip("Case sensitive key.")]
		[CompoundArray("Count", "Key", "Variable")]
		public FsmString[] keys;

		[UIHint(UIHint.Variable)]
		public FsmString[] variables;

		public override void Reset()
		{
			keys = new FsmString[1];
			variables = new FsmString[1];
		}

		public override void OnEnter()
		{
			for (int i = 0; i < keys.Length; i++)
			{
				if (!keys[i].IsNone || !keys[i].Value.Equals(string.Empty))
				{
					variables[i].Value = PlayerPrefs.GetString(keys[i].Value, (!variables[i].IsNone) ? variables[i].Value : string.Empty);
				}
			}
			Finish();
		}
	}
}
