using Relentless;
using UnityEngine;

namespace Furby
{
	public class SkipNamingBecauseNoFurby : MonoBehaviour
	{
		private void OnClick()
		{
			AdultFurbyType[] array = new AdultFurbyType[10]
			{
				AdultFurbyType.Checkerboard,
				AdultFurbyType.Cubes,
				AdultFurbyType.Diagonals,
				AdultFurbyType.Hearts,
				AdultFurbyType.Lightning,
				AdultFurbyType.Peacock,
				AdultFurbyType.Stripes,
				AdultFurbyType.Triangles,
				AdultFurbyType.Waves,
				AdultFurbyType.Zigzags
			};
			// here lies the disable comair stuff, comair doesnt even work so whats the point on disabling it
			Singleton<GameDataStoreObject>.Instance.Data.FurbyType = AdultFurbyType.NoFurby;
			Singleton<GameDataStoreObject>.Instance.Data.NoFurbyUnlockType = array[Random.Range(0, array.Length)];
			Singleton<GameDataStoreObject>.Instance.Data.HasCompletedFirstTimeFlow = true;
		}
	}
}
