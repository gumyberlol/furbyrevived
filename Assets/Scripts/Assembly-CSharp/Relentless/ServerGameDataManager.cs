using System;
using UnityEngine;

namespace Relentless
{
	public class ServerGameDataManager : ProviderManager<ServerGameDataManager, DummyProvider>, IProvider, SaveObject
	{
		private bool m_saveDataLoaded = true;

		private ServerGameData m_gameData = new ServerGameData(); // dummy default

		private DummyAbTests m_abTests = new DummyAbTests();

		public bool SaveDataLoaded => m_saveDataLoaded;

		public ServerGameData GameData => m_gameData;

		public DummyAbTests AbTests => m_abTests;

		public void SerializeTo(SaveGameWriter writer) { }

		public void DeserializeFrom(SaveGameReader reader) { }

		public int GetVersion() => 1;

		protected override void Initialise()
		{
			Singleton<SaveGame>.Instance.Register(new SaveGameItem("GameDataBlobDownloader", this));
			base.Initialise();

			if (m_providers.Count == 0)
			{
				Logging.LogError("No valid provider found!");
				return;
			}

			// Skip networking and downloading, just set dummy data
			m_gameData = m_providers[0].BlobData ?? new ServerGameData();
			m_abTests = new DummyAbTests();

			DebugNotifications.AddNotification("Using dummy ServerGameData (networking disabled).", TimeSpan.FromSeconds(5.0));
			Logging.Log("ServerGameData is ready (dummy version).");
		}

		public class DummyAbTests
		{
			public override string ToString()
			{
				return "Dummy AB Test Data";
			}
		}
	}

	// DummyProvider class outside, in the same namespace, so ServerGameDataManager can see it
	public class DummyProvider : ProviderBase
	{
		protected override string ProviderName => "DummyProvider";
		public ServerGameData BlobData => new ServerGameData();
	}
}
