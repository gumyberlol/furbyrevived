namespace HutongGames.PlayMaker.Actions
{
	[Tooltip("Sets the value of any public property or field on the targeted Unity Object. E.g., Drag and drop any component attached to a Game Object to access its properties.")]
	[ActionCategory(ActionCategory.UnityObject)]
	public class SetProperty : FsmStateAction
	{
		public FsmProperty targetProperty;

		public bool everyFrame;

		public override void Reset()
		{
			targetProperty = new FsmProperty
			{
				setProperty = true
			};
			everyFrame = false;
		}

		public override void OnEnter()
		{
			targetProperty.SetValue();
			if (!everyFrame)
			{
				Finish();
			}
		}

		public override void OnUpdate()
		{
			targetProperty.SetValue();
		}
	}
}
