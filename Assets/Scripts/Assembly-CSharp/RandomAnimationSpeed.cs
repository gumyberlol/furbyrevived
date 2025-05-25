using UnityEngine;

public class RandomAnimationSpeed : MonoBehaviour
{
	public float m_minAnimSpeed = 0.75f;

	public float m_maxAnimSpeed = 1.25f;

	private void Start()
	{
		AnimationClip clip = base.GetComponent<Animation>().clip;
		base.GetComponent<Animation>()[clip.name].speed = Random.Range(m_minAnimSpeed, m_maxAnimSpeed);
	}
}
