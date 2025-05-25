using System;
using Relentless;
using UnityEngine;

namespace Furby.Utilities.Blender
{
	public class FurbyBabyReanimator : MonoBehaviour
	{
		public AnimationClip m_IdleAnimation;

		private GameObject m_CachedTargetModel;

		private void Awake()
		{
			if ((bool)m_IdleAnimation)
			{
				m_IdleAnimation.wrapMode = WrapMode.Loop;
			}
		}

		private void Update()
		{
			if ((bool)m_CachedTargetModel)
			{
				if (!m_CachedTargetModel.GetComponent<Animation>().isPlaying && (bool)m_IdleAnimation)
				{
					m_CachedTargetModel.GetComponent<Animation>().Play(m_IdleAnimation.name, PlayMode.StopSameLayer);
				}
			}
			else
			{
				CacheTargetModel();
			}
		}

		private void CacheTargetModel()
		{
			Component component = GetComponent("BabyInstance");
			if (!component)
			{
				return;
			}
			ModelInstance component2 = component.GetComponent<ModelInstance>();
			if ((bool)component2)
			{
				m_CachedTargetModel = component2.Instance;
				if ((bool)m_CachedTargetModel && (bool)m_CachedTargetModel.GetComponent<Animation>())
				{
					m_CachedTargetModel.GetComponent<Animation>().Stop();
				}
			}
		}

		public bool IsIdling()
		{
			if (m_CachedTargetModel == null)
			{
				throw new ApplicationException("No target model to query");
			}
			return m_CachedTargetModel.GetComponent<Animation>().IsPlaying(m_IdleAnimation.name);
		}
	}
}
