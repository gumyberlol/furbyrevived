using Relentless;
using UnityEngine;

namespace Furby.Utilities.Bath
{
	public class DropTarget : MonoBehaviour
	{
		public bool MyDrop(GameObject drag)
		{
			Logging.Log(string.Format("DropTarget.MyDrop(): Got an item - {0}", drag.name));
			return true;
		}

		public void EnableCollider()
		{
			base.GetComponent<Collider>().enabled = true;
		}

		public void DisableCollider()
		{
			base.GetComponent<Collider>().enabled = false;
		}
	}
}
