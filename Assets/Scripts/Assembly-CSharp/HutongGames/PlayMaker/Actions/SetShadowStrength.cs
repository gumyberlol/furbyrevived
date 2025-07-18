using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Sets the strength of the shadows cast by a Light.")]
	[ActionCategory(ActionCategory.Lights)]
	public class SetShadowStrength : FsmStateAction
	{
		[CheckForComponent(typeof(Light))]
		[RequiredField]
		public FsmOwnerDefault gameObject;

		public FsmFloat shadowStrength;

		public bool everyFrame;

		public override void Reset()
		{
			gameObject = null;
			shadowStrength = 0.8f;
			everyFrame = false;
		}

		public override void OnEnter()
		{
			DoSetShadowStrength();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			DoSetShadowStrength();
		}

		private void DoSetShadowStrength()
		{
			GameObject ownerDefaultTarget = base.Fsm.GetOwnerDefaultTarget(gameObject);
			if (!(ownerDefaultTarget == null))
			{
				Light light = ownerDefaultTarget.GetComponent<Light>();
				if (light == null)
				{
					LogError("Missing Light Component!");
				}
				else
				{
					light.shadowStrength = shadowStrength.Value;
				}
			}
		}
	}
}
