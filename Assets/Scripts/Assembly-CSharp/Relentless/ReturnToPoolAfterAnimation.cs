namespace Relentless
{
	public class ReturnToPoolAfterAnimation : RelentlessMonoBehaviour
	{
		private void Update()
		{
			if ((bool)base.GetComponent<UnityEngine.Animation>() && !base.GetComponent<UnityEngine.Animation>().isPlaying)
			{
				SingletonInstance<PrefabPool>.Instance.ReturnToPool(base.gameObject);
			}
		}
	}
}
