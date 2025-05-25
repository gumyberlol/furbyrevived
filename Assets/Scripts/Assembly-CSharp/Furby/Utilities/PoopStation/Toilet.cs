using UnityEngine;

namespace Furby.Utilities.PoopStation
{
	public class Toilet : MonoBehaviour
	{
		public const string lidUpAnimName = "poopStation_lidOpen";

		public const string lidDownAnimName = "poopStation_LidShut";

		public const string flushAnimName = "poopStation_flush";

		[SerializeField]
		private GameObject m_asset;

		public void Start()
		{
			m_asset.GetComponent<Animation>().Play("poopStation_lidOpen");
			m_asset.GetComponent<Animation>().Sample();
			m_asset.GetComponent<Animation>().Stop();
		}

		public Bowl GetBowl()
		{
			return base.gameObject.GetComponentInChildren<Bowl>();
		}

		public ToiletLid GetLid()
		{
			return base.gameObject.GetComponentInChildren<ToiletLid>();
		}

		public Spray GetSpray()
		{
			return base.gameObject.GetComponentInChildren<Spray>();
		}
	}
}
