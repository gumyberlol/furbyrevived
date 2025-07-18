namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Gets the value of a curve at a given time and stores it in a Float Variable. NOTE: This can be used for more than just animation! It's a general way to transform an input number into an output number using a curve (e.g., linear input -> bell curve).")]
	[ActionCategory(ActionCategory.Math)]
	public class SampleCurve : FsmStateAction
	{
		[RequiredField]
		public FsmAnimationCurve curve;

		[RequiredField]
		public FsmFloat sampleAt;

		[RequiredField]
		[UIHint(UIHint.Variable)]
		public FsmFloat storeValue;

		public bool everyFrame;

		public override void Reset()
		{
			curve = null;
			sampleAt = null;
			storeValue = null;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoSampleCurve();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoSampleCurve();
		}

		private void DoSampleCurve()
		{
			if (curve != null && curve.curve != null && storeValue != null)
			{
				storeValue.Value = curve.curve.Evaluate(sampleAt.Value);
			}
		}
	}
}
