using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Math)]
	[Tooltip("Sets an Integer Variable to a random value between Min/Max.")]
	public class RandomInt : FsmStateAction
	{
		[RequiredField]
		public FsmInt min;

		[RequiredField]
		public FsmInt max;

		[UIHint(UIHint.Variable)]
		[RequiredField]
		public FsmInt storeResult;

		[Tooltip("Should the Max value be included in the possible results?")]
		public bool inclusiveMax;

		public override void Reset()
		{
			min = 0;
			max = 100;
			storeResult = null;
			inclusiveMax = false;
		}

		public override void OnEnter()
		{
			storeResult.Value = ((!inclusiveMax) ? Random.Range(min.Value, max.Value) : Random.Range(min.Value, max.Value + 1));
			Finish();
		}
	}
}
