using UnityEngine;

namespace Relentless
{
	public class InstantiateOnMissing : MonoBehaviour
	{
		public enum ReparentType
		{
			None = 0,
			This = 1,
			Parent = 2
		}

		[SerializeField]
		private string m_objectName;

		[SerializeField]
		private GameObject m_prefab;

		[SerializeField]
		private ReparentType m_reparentTo;

		[SerializeField]
		private bool m_keepTransforms;

		private void Awake()
		{
			if (m_prefab == null)
			{
				Debug.LogWarning("InstantiateOnMissing: Missing prefab, skipping instantiation :3");
				return;
			}

			string text = string.IsNullOrEmpty(m_objectName) ? m_prefab.name : m_objectName;
			string text2 = "/";
			switch (m_reparentTo)
			{
				case ReparentType.This:
					if (transform == null)
					{
						Debug.LogWarning("InstantiateOnMissing: 'This' reparent target is null, skipping.");
						return;
					}
					text2 = transform.GetPath();
					break;
				case ReparentType.Parent:
					if (transform.parent == null)
					{
						Debug.LogWarning("InstantiateOnMissing: Parent transform is missing, skipping.");
						return;
					}
					text2 = transform.parent.GetPath();
					break;
			}

			GameObject existing = GameObject.Find(text2 + text);
			if (!existing)
			{
				GameObject instance;
				if (m_keepTransforms)
				{
					instance = Instantiate(m_prefab);
				}
				else
				{
					instance = Instantiate(m_prefab, transform.position, transform.rotation);
				}

				instance.name = text;
				Vector3 pos = instance.transform.position;
				Quaternion rot = instance.transform.rotation;

				switch (m_reparentTo)
				{
					case ReparentType.This:
						instance.transform.parent = transform;
						break;
					case ReparentType.Parent:
						instance.transform.parent = transform.parent;
						break;
				}

				if (m_keepTransforms)
				{
					instance.transform.position = pos;
					instance.transform.rotation = rot;
				}
				Debug.Log($"InstantiateOnMissing: Instantiated missing object '{text}' :3");
			}
			else
			{
				Debug.Log($"InstantiateOnMissing: Found existing '{text}', nothing to do :3");
			}
		}
	}
}
