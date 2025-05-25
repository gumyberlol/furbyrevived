using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.GameObject)]
	[Tooltip("Creates a Game Object at a spawn point.\nUse a Game Object and/or Position/Rotation for the Spawn Point. If you specify a Game Object, Position is used as a local offset, and Rotation will override the object's rotation.")]
	public class CreateEmptyObject : FsmStateAction
	{
		public FsmGameObject gameObject;

		public FsmGameObject spawnPoint;

		public FsmVector3 position;

		public FsmVector3 rotation;

		[Tooltip("Optionally store the created object.")]
		[UIHint(UIHint.Variable)]
		public FsmGameObject storeObject;

		public override void Reset()
		{
			gameObject = null;
			spawnPoint = null;
			position = new FsmVector3
			{
				UseVariable = true
			};
			rotation = new FsmVector3
			{
				UseVariable = true
			};
			storeObject = null;
		}

		public override void OnEnter()
		{
			GameObject value = gameObject.Value;
			Vector3 vector = Vector3.zero;
			Vector3 eulerAngles = Vector3.up;
			if (spawnPoint.Value != null)
			{
				vector = spawnPoint.Value.transform.position;
				if (!position.IsNone)
				{
					vector += position.Value;
				}
				eulerAngles = (rotation.IsNone ? spawnPoint.Value.transform.eulerAngles : rotation.Value);
			}
			else
			{
				if (!position.IsNone)
				{
					vector = position.Value;
				}
				if (!rotation.IsNone)
				{
					eulerAngles = rotation.Value;
				}
			}
			GameObject value2 = storeObject.Value;
			if (value != null)
			{
				value2 = (GameObject)Object.Instantiate(value);
				storeObject.Value = value2;
			}
			else
			{
				value2 = new GameObject("EmptyObjectFromNull");
				storeObject.Value = value2;
			}
			if (value2 != null)
			{
				value2.transform.position = vector;
				value2.transform.eulerAngles = eulerAngles;
			}
			Finish();
		}
	}
}
