using System.Collections;
using UnityEngine;

namespace Furby
{
	public class AndroidObbDownloader : MonoBehaviour
	{
		public enum AndroidObbEvent
		{
			NoExternalStorage = 0,
			DownloadRequired = 1,
			DownloadFailed = 2
		}

		[SerializeField]
		private GameObject[] m_objectsToEnableOnSuccess;

		private IEnumerator Start()
		{
			yield return null;
			// Skip download, just enable success objects
			foreach (GameObject gObj in m_objectsToEnableOnSuccess)
			{
				gObj.SetActive(true);
			}
		}
	}
}
