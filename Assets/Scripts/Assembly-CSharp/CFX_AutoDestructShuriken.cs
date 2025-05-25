using UnityEngine;

[RequireComponent(typeof(ParticleSystem))]
public class CFX_AutoDestructShuriken : MonoBehaviour
{
	private void Update()
	{
		if (!base.GetComponent<ParticleSystem>().IsAlive(true))
		{
			Object.Destroy(base.gameObject);
		}
	}
}
