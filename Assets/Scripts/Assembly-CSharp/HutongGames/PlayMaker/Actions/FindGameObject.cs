using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.GameObject)]
	[Tooltip("Finds a Game Object by Name and/or Tag.")]
	public class FindGameObject : FsmStateAction
	{
		public FsmString objectName;

		[UIHint(UIHint.Tag)]
		public FsmString withTag;

		[RequiredField]
		[UIHint(UIHint.Variable)]
		public FsmGameObject store;

		public override void Reset()
		{
			objectName = string.Empty;
			withTag = "Untagged";
			store = null;
		}

		public override void OnEnter()
		{
			Finish();
			if (withTag.Value != "Untagged")
			{
				if (!string.IsNullOrEmpty(objectName.Value))
				{
					GameObject[] array = GameObject.FindGameObjectsWithTag(withTag.Value);
					GameObject[] array2 = array;
					foreach (GameObject gameObject in array2)
					{
						if (gameObject.name == objectName.Value)
						{
							store.Value = gameObject;
							return;
						}
					}
					store.Value = null;
				}
				else
				{
					store.Value = GameObject.FindGameObjectWithTag(withTag.Value);
				}
			}
			else
			{
				store.Value = GameObject.Find(objectName.Value);
			}
		}

		public override string ErrorCheck()
		{
			if (string.IsNullOrEmpty(objectName.Value) && string.IsNullOrEmpty(withTag.Value))
			{
				return "Specify Name, Tag, or both.";
			}
			return null;
		}
	}
}
