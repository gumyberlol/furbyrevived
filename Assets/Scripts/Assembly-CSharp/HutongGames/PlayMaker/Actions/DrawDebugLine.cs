using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Draws a line from a Start point to an End point. Specify the points as Game Objects or Vector3 world positions. If both are specified, position is used as a local offset from the Object's position.")]
	[ActionCategory(ActionCategory.Debug)]
	public class DrawDebugLine : FsmStateAction
	{
		[Tooltip("From a Game Object.")]
		public FsmGameObject fromObject;

		[Tooltip("From a world position, or local offset from Game Object if provided.")]
		public FsmVector3 fromPosition;

		[Tooltip("To a Game Object.")]
		public FsmGameObject toObject;

		[Tooltip("To a world position, or local offset from Game Object if provided.")]
		public FsmVector3 toPosition;

		[Tooltip("The color of the line.")]
		public FsmColor color;

		public override void Reset()
		{
			fromObject = new FsmGameObject
			{
				UseVariable = true
			};
			fromPosition = new FsmVector3
			{
				UseVariable = true
			};
			toObject = new FsmGameObject
			{
				UseVariable = true
			};
			toPosition = new FsmVector3
			{
				UseVariable = true
			};
			color = Color.white;
		}

		public override void OnUpdate()
		{
			Vector3 position = ActionHelpers.GetPosition(fromObject, fromPosition);
			Vector3 position2 = ActionHelpers.GetPosition(toObject, toPosition);
			Debug.DrawLine(position, position2, color.Value);
		}
	}
}
