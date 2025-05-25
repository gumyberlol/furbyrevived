using UnityEngine;

namespace Furby.Utilities.Hose
{
	public class Spray : MonoBehaviour
	{
		public Temperature m_temp;

		public Pressure m_pressure;

		public void Stop()
		{
			base.GetComponent<ParticleSystem>().Stop();
		}

		public bool IsOn()
		{
			return base.GetComponent<ParticleSystem>().IsAlive();
		}
	}
}
