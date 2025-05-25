using UnityEngine;

public class TriggerEffects : MonoBehaviour
{
	public AnimationClip m_animEmit;

	public AnimationClip m_animReset;

	public void EffectsEmit()
	{
		base.GetComponent<Animation>().Play(m_animEmit.name);
	}

	public void EffectsReset()
	{
		if (m_animReset != null)
		{
			base.GetComponent<Animation>().Play(m_animReset.name);
		}
	}
}
