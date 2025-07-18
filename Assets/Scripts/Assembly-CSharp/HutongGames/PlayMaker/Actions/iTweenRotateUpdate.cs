using System.Collections;
using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory("iTween")]
	[Tooltip("Similar to RotateTo but incredibly less expensive for usage inside the Update function or similar looping situations involving a 'live' set of changing values. Does not utilize an EaseType.")]
	public class iTweenRotateUpdate : FsmStateAction
	{
		[RequiredField]
		public FsmOwnerDefault gameObject;

		[Tooltip("Rotate to a transform rotation.")]
		public FsmGameObject transformRotation;

		[Tooltip("A rotation the GameObject will animate from.")]
		public FsmVector3 vectorRotation;

		[Tooltip("The time in seconds the animation will take to complete. If transformRotation is set, this is used as an offset.")]
		public FsmFloat time;

		[Tooltip("Whether to animate in local or world space.")]
		public Space space;

		private Hashtable hash;

		private GameObject go;

		public override void Reset()
		{
			transformRotation = new FsmGameObject
			{
				UseVariable = true
			};
			vectorRotation = new FsmVector3
			{
				UseVariable = true
			};
			time = 1f;
			space = Space.World;
		}

		public override void OnEnter()
		{
			hash = new Hashtable();
			go = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (go == null)
			{
				Finish();
				return;
			}
			if (transformRotation.IsNone)
			{
				hash.Add("rotation", (!vectorRotation.IsNone) ? vectorRotation.Value : Vector3.zero);
			}
			else if (vectorRotation.IsNone)
			{
				hash.Add("rotation", transformRotation.Value.transform);
			}
			else if (space == Space.World)
			{
				hash.Add("rotation", transformRotation.Value.transform.eulerAngles + vectorRotation.Value);
			}
			else
			{
				hash.Add("rotation", transformRotation.Value.transform.localEulerAngles + vectorRotation.Value);
			}
			hash.Add("time", (!time.IsNone) ? time.Value : 1f);
			hash.Add("islocal", space == Space.Self);
			DoiTween();
		}

		public override void OnExit()
		{
		}

		public override void OnUpdate()
		{
			hash.Remove("rotation");
			if (transformRotation.IsNone)
			{
				hash.Add("rotation", (!vectorRotation.IsNone) ? vectorRotation.Value : Vector3.zero);
			}
			else if (vectorRotation.IsNone)
			{
				hash.Add("rotation", transformRotation.Value.transform);
			}
			else if (space == Space.World)
			{
				hash.Add("rotation", transformRotation.Value.transform.eulerAngles + vectorRotation.Value);
			}
			else
			{
				hash.Add("rotation", transformRotation.Value.transform.localEulerAngles + vectorRotation.Value);
			}
			DoiTween();
		}

		private void DoiTween()
		{
			iTween.RotateUpdate(go, hash);
		}
	}
}
