using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.StateMachine)]
	[Tooltip("Set the custom log level for game events.")]
	public class SetCustomLogLevel : FsmStateAction
	{
		[Tooltip("The custom log level")]
		public CustomLogLevel logLevel;

		public override void Reset()
		{
			logLevel = CustomLogLevel.Off;
		}

		public override void OnEnter()
		{
			SetLogLevel();
			Finish();
		}

		private void SetLogLevel()
		{
			// Custom logic to handle different log levels
			switch (logLevel)
			{
				case CustomLogLevel.Off:
					Debug.unityLogger.logEnabled = false;
					break;

				case CustomLogLevel.Informational:
					Debug.unityLogger.logEnabled = true;
					break;

				case CustomLogLevel.Full:
					Debug.unityLogger.logEnabled = true;
					// You can customize to log more detailed information if necessary
					break;
			}
			Debug.Log($"Log level set to: {logLevel}");
		}
	}

	// Define custom log levels as needed
	public enum CustomLogLevel
	{
		Off,
		Informational,
		Full
	}
}
