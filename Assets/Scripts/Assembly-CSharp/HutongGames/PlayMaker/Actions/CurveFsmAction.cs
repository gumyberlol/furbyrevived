using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Animate base action - DON'T USE IT!")]
	public abstract class CurveFsmAction : FsmStateAction
	{
		public enum Calculation
		{
			None = 0,
			AddToValue = 1,
			SubtractFromValue = 2,
			SubtractValueFromCurve = 3,
			MultiplyValue = 4,
			DivideValue = 5,
			DivideCurveByValue = 6
		}

		[Tooltip("Define time to use your curve scaled to be stretched or shrinked.")]
		public FsmFloat time;

		[Tooltip("If you define speed, your animation will be speeded up or slowed down.")]
		public FsmFloat speed;

		[Tooltip("Delayed animimation start.")]
		public FsmFloat delay;

		[Tooltip("Animation curve start from any time. If IgnoreCurveOffset is true the animation starts right after the state become entered.")]
		public FsmBool ignoreCurveOffset;

		[Tooltip("Optionally send an Event when the animation finishes.")]
		public FsmEvent finishEvent;

		[Tooltip("Ignore TimeScale. Useful if the game is paused.")]
		public bool realTime;

		private float startTime;

		private float currentTime;

		private float[] endTimes;

		private float lastTime;

		private float deltaTime;

		private float delayTime;

		private float[] keyOffsets;

		protected AnimationCurve[] curves;

		protected Calculation[] calculations;

		protected float[] resultFloats;

		protected float[] fromFloats;

		protected float[] toFloats;

		private float[] distances;

		protected bool finishAction;

		protected bool isRunning;

		protected bool looping;

		private bool start;

		private float largestEndTime;

		public override void Reset()
		{
			finishEvent = null;
			realTime = false;
			time = new FsmFloat
			{
				UseVariable = true
			};
			speed = new FsmFloat
			{
				UseVariable = true
			};
			delay = new FsmFloat
			{
				UseVariable = true
			};
			ignoreCurveOffset = new FsmBool
			{
				Value = true
			};
			resultFloats = new float[0];
			fromFloats = new float[0];
			toFloats = new float[0];
			distances = new float[0];
			endTimes = new float[0];
			keyOffsets = new float[0];
			curves = new AnimationCurve[0];
			finishAction = false;
			start = false;
		}

		public override void OnEnter()
		{
			startTime = FsmTime.RealtimeSinceStartup;
			lastTime = FsmTime.RealtimeSinceStartup - startTime;
			deltaTime = 0f;
			currentTime = 0f;
			isRunning = false;
			finishAction = false;
			looping = false;
			delayTime = ((!delay.IsNone) ? (delayTime = delay.Value) : 0f);
			start = true;
		}

		protected void Init()
		{
			endTimes = new float[curves.Length];
			keyOffsets = new float[curves.Length];
			largestEndTime = 0f;
			for (int i = 0; i < curves.Length; i++)
			{
				if (curves[i] != null && curves[i].keys.Length > 0)
				{
					keyOffsets[i] = ((curves[i].keys.Length <= 0) ? 0f : ((!time.IsNone) ? (time.Value / curves[i].keys[curves[i].length - 1].time * curves[i].keys[0].time) : curves[i].keys[0].time));
					currentTime = (ignoreCurveOffset.IsNone ? 0f : ((!ignoreCurveOffset.Value) ? 0f : keyOffsets[i]));
					if (!time.IsNone)
					{
						endTimes[i] = time.Value;
					}
					else
					{
						endTimes[i] = curves[i].keys[curves[i].length - 1].time;
					}
					if (largestEndTime < endTimes[i])
					{
						largestEndTime = endTimes[i];
					}
					if (!looping)
					{
						looping = ActionHelpers.IsLoopingWrapMode(curves[i].postWrapMode);
					}
				}
				else
				{
					endTimes[i] = -1f;
				}
			}
			for (int j = 0; j < curves.Length; j++)
			{
				if (largestEndTime > 0f && endTimes[j] == -1f)
				{
					endTimes[j] = largestEndTime;
				}
				else if (largestEndTime == 0f && endTimes[j] == -1f)
				{
					if (time.IsNone)
					{
						endTimes[j] = 1f;
					}
					else
					{
						endTimes[j] = time.Value;
					}
				}
			}
			distances = new float[fromFloats.Length];
			for (int k = 0; k < fromFloats.Length; k++)
			{
				distances[k] = Mathf.Sqrt(Mathf.Pow(fromFloats[k] - toFloats[k], 2f));
			}
		}

		public override void OnUpdate()
		{
			if (!isRunning && start)
			{
				if (delayTime >= 0f)
				{
					if (realTime)
					{
						deltaTime = FsmTime.RealtimeSinceStartup - startTime - lastTime;
						lastTime = FsmTime.RealtimeSinceStartup - startTime;
						delayTime -= deltaTime;
					}
					else
					{
						delayTime -= Time.deltaTime;
					}
				}
				else
				{
					isRunning = true;
					start = false;
					startTime = FsmTime.RealtimeSinceStartup;
					lastTime = FsmTime.RealtimeSinceStartup - startTime;
				}
			}
			if (!isRunning || finishAction)
			{
				return;
			}
			if (realTime)
			{
				deltaTime = FsmTime.RealtimeSinceStartup - startTime - lastTime;
				lastTime = FsmTime.RealtimeSinceStartup - startTime;
				if (!speed.IsNone)
				{
					currentTime += deltaTime * speed.Value;
				}
				else
				{
					currentTime += deltaTime;
				}
			}
			else if (!speed.IsNone)
			{
				currentTime += Time.deltaTime * speed.Value;
			}
			else
			{
				currentTime += Time.deltaTime;
			}
			for (int i = 0; i < curves.Length; i++)
			{
				if (curves[i] != null && curves[i].keys.Length > 0)
				{
					if (calculations[i] != Calculation.None)
					{
						switch (calculations[i])
						{
						case Calculation.AddToValue:
							if (!time.IsNone)
							{
								resultFloats[i] = fromFloats[i] + (distances[i] * (currentTime / time.Value) + curves[i].Evaluate(currentTime / time.Value * curves[i].keys[curves[i].length - 1].time));
							}
							else
							{
								resultFloats[i] = fromFloats[i] + (distances[i] * (currentTime / endTimes[i]) + curves[i].Evaluate(currentTime));
							}
							break;
						case Calculation.SubtractFromValue:
							if (!time.IsNone)
							{
								resultFloats[i] = fromFloats[i] + (distances[i] * (currentTime / time.Value) - curves[i].Evaluate(currentTime / time.Value * curves[i].keys[curves[i].length - 1].time));
							}
							else
							{
								resultFloats[i] = fromFloats[i] + (distances[i] * (currentTime / endTimes[i]) - curves[i].Evaluate(currentTime));
							}
							break;
						case Calculation.SubtractValueFromCurve:
							if (!time.IsNone)
							{
								resultFloats[i] = curves[i].Evaluate(currentTime / time.Value * curves[i].keys[curves[i].length - 1].time) - distances[i] * (currentTime / time.Value) + fromFloats[i];
							}
							else
							{
								resultFloats[i] = curves[i].Evaluate(currentTime) - distances[i] * (currentTime / endTimes[i]) + fromFloats[i];
							}
							break;
						case Calculation.MultiplyValue:
							if (!time.IsNone)
							{
								resultFloats[i] = curves[i].Evaluate(currentTime / time.Value * curves[i].keys[curves[i].length - 1].time) * distances[i] * (currentTime / time.Value) + fromFloats[i];
							}
							else
							{
								resultFloats[i] = curves[i].Evaluate(currentTime) * distances[i] * (currentTime / endTimes[i]) + fromFloats[i];
							}
							break;
						case Calculation.DivideValue:
							if (!time.IsNone)
							{
								resultFloats[i] = ((curves[i].Evaluate(currentTime / time.Value * curves[i].keys[curves[i].length - 1].time) == 0f) ? float.MaxValue : (fromFloats[i] + distances[i] * (currentTime / time.Value) / curves[i].Evaluate(currentTime / time.Value * curves[i].keys[curves[i].length - 1].time)));
							}
							else
							{
								resultFloats[i] = ((curves[i].Evaluate(currentTime) == 0f) ? float.MaxValue : (fromFloats[i] + distances[i] * (currentTime / endTimes[i]) / curves[i].Evaluate(currentTime)));
							}
							break;
						case Calculation.DivideCurveByValue:
							if (!time.IsNone)
							{
								resultFloats[i] = ((fromFloats[i] == 0f) ? float.MaxValue : (curves[i].Evaluate(currentTime / time.Value * curves[i].keys[curves[i].length - 1].time) / (distances[i] * (currentTime / time.Value)) + fromFloats[i]));
							}
							else
							{
								resultFloats[i] = ((fromFloats[i] == 0f) ? float.MaxValue : (curves[i].Evaluate(currentTime) / (distances[i] * (currentTime / endTimes[i])) + fromFloats[i]));
							}
							break;
						}
					}
					else if (!time.IsNone)
					{
						resultFloats[i] = fromFloats[i] + distances[i] * (currentTime / time.Value);
					}
					else
					{
						resultFloats[i] = fromFloats[i] + distances[i] * (currentTime / endTimes[i]);
					}
				}
				else if (!time.IsNone)
				{
					resultFloats[i] = fromFloats[i] + distances[i] * (currentTime / time.Value);
				}
				else if (largestEndTime == 0f)
				{
					resultFloats[i] = fromFloats[i] + distances[i] * (currentTime / 1f);
				}
				else
				{
					resultFloats[i] = fromFloats[i] + distances[i] * (currentTime / largestEndTime);
				}
			}
			if (!isRunning)
			{
				return;
			}
			finishAction = true;
			for (int j = 0; j < endTimes.Length; j++)
			{
				if (currentTime < endTimes[j])
				{
					finishAction = false;
				}
			}
			isRunning = !finishAction;
		}
	}
}
