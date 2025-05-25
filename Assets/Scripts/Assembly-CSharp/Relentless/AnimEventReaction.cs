using System;
using UnityEngine;

namespace Relentless
{
	[Serializable]
	public class AnimEventReaction : GameEventReaction
	{
		public enum Operation
		{
			Play = 0,
			Stop = 1,
			CrossFade = 2,
			Blend = 3
		}

		public string AnimName;

		public string[] AnimNameArray = new string[0];

		public Operation AnimOperation;

		public bool AnimQueued;

		public QueueMode AnimQueueMode;

		public PlayMode AnimPlayMode;

		public AnimationBlendMode AnimBlendMode;

		public WrapMode AnimWrapMode;

		public float AnimFadeLength = 0.3f;

		public float AnimTargetWeight = 1f;

		public bool OverrideGameobject = true;

		public float StartPos;

		public float Speed = 1f;

		public override void React(GameObject gameObject, params object[] paramlist)
		{
			string text = AnimName;
			if (!OverrideGameobject)
			{
				gameObject = (GameObject)paramlist[0];
			}
			if (gameObject == null)
			{
				return;
			}
			ModelInstance component = gameObject.GetComponent<ModelInstance>();
			if (component != null)
			{
				gameObject = component.Instance;
			}
			if (gameObject == null || gameObject.GetComponent<Animation>() == null)
			{
				return;
			}
			if (AnimNameArray.Length > 1)
			{
				text = AnimNameArray[UnityEngine.Random.Range(0, AnimNameArray.Length)];
			}
			switch (AnimOperation)
			{
			case Operation.Play:
				if (AnimQueued)
				{
					gameObject.GetComponent<Animation>().PlayQueued(text, AnimQueueMode, AnimPlayMode);
				}
				else
				{
					gameObject.GetComponent<Animation>().Play(text, AnimPlayMode);
				}
				gameObject.GetComponent<Animation>()[text].wrapMode = AnimWrapMode;
				gameObject.GetComponent<Animation>()[text].time = StartPos;
				gameObject.GetComponent<Animation>()[text].speed = Speed;
				break;
			case Operation.Stop:
			{
				string[] animNameArray = AnimNameArray;
				foreach (string name in animNameArray)
				{
					gameObject.GetComponent<Animation>().Stop(name);
				}
				gameObject.GetComponent<Animation>().Stop(text);
				break;
			}
			case Operation.CrossFade:
				if (AnimQueued)
				{
					gameObject.GetComponent<Animation>().CrossFadeQueued(text, AnimFadeLength, AnimQueueMode, AnimPlayMode);
				}
				else
				{
					gameObject.GetComponent<Animation>().CrossFade(text, AnimFadeLength);
				}
				gameObject.GetComponent<Animation>()[text].wrapMode = AnimWrapMode;
				break;
			case Operation.Blend:
				gameObject.GetComponent<Animation>()[text].blendMode = AnimBlendMode;
				gameObject.GetComponent<Animation>().Blend(text, AnimTargetWeight, AnimFadeLength);
				break;
			}
		}
	}
}
