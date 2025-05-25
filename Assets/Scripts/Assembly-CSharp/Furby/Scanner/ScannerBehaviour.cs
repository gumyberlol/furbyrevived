using System;
using System.Collections;
using System.Collections.Generic;
using Relentless;
using UnityEngine;

namespace Furby.Scanner
{
	public class ScannerBehaviour : GameEventReceiver
	{
		private static readonly List<AdultFurbyType> CrystalTypes = new List<AdultFurbyType>
		{
			AdultFurbyType.CrystalGreenToBlue,
			AdultFurbyType.CrystalOrangeToPink,
			AdultFurbyType.CrystalPinkToBlue,
			AdultFurbyType.CrystalPinkToPurple,
			AdultFurbyType.CrystalRainbow,
			AdultFurbyType.CrystalYellowToOrange
		};

		[SerializeField]
		private int m_ScanMessageCount = 4;

		[NonSerialized]
		private bool m_CurrentlyScanning;

		[SerializeField]
		private bool m_isInitialScanner;

		[SerializeField]
		private FurbyNamingData m_namingData;

		[NonSerialized]
		private bool m_RequiresExcusivity = true;

		[NonSerialized]
		private bool m_DebugOverride;

		[NonSerialized]
		private GameEventSubscription m_DebugObserver;

		[NonSerialized]
		private FurbyStatus m_DebugStatus;

		public override Type EventType
		{
			get
			{
				return typeof(ScannerEvents);
			}
		}

		private void Start()
		{
			if (!FurbyGlobals.Player.NoFurbyOnSaveGame())
			{
				bool flag = false;
				if (m_isInitialScanner || !Singleton<GameDataStoreObject>.Instance.Data.HasCompletedFirstTimeFlow)
				{
					GameEventRouter.SendEvent(ScannerEvents.RequiresInitialScan);
					flag = true;
				}
				else if (FurbyGlobals.Player.FlowStage >= FlowStage.Normal && !FurbyGlobals.Player.HasScannedThisPlaythrough())
				{
					GameEventRouter.SendEvent(ScannerEvents.ScanButtonPressed);
					flag = true;
				}
				if (!flag)
				{
					m_RequiresExcusivity = false;
				}
			}
		}

		protected override void OnEnable()
		{
			base.OnEnable();
			m_DebugObserver = new GameEventSubscription(OnDebugPanelGUI, DebugPanelEvent.DrawElementRequested);
			m_DebugStatus = default(FurbyStatus);
			m_DebugStatus.Happyness = 50;
			m_DebugStatus.Fullness = 50;
			m_DebugStatus.Name = FurbyReceiveName.Tay_Toh;
			m_DebugStatus.Pattern = FurbyPattern.Hearts;
			m_DebugStatus.Sickness = 0;
		}

		protected override void OnDisable()
		{
			m_DebugObserver.Dispose();
			base.OnDisable();
		}

		protected override void OnEvent(Enum enumValue, GameObject gameObject, params object[] paramList)
		{
			ScannerEvents scannerEvents = (ScannerEvents)(object)enumValue;
			if (!FurbyGlobals.Player.NoFurbyOnSaveGame() || scannerEvents == ScannerEvents.RequiresInitialScan)
			{
				switch (scannerEvents)
				{
				case ScannerEvents.ScanButtonPressed:
					GameEventRouter.SendEvent(ScannerEvents.FirstScanDisableInput);
					if (!FurbyGlobals.Player.HasScannedThisPlaythrough())
					{
						FurbyGlobals.Player.SetScannedFlag(true);
					}
					StartCoroutine(ScanningFlow(false));
					break;
				case ScannerEvents.RequiresInitialScan:
					GameEventRouter.SendEvent(ScannerEvents.FirstScanDisableInput);
					StartCoroutine(ScanningFlow(true));
					break;
				case ScannerEvents.PlayWithoutFurbyTemporarily:
					GameEventRouter.SendEvent(PlayerFurbyCommand.TurnOnNoFurbyMode);
					GameEventRouter.SendEvent(PlayerFurbyEvent.StatusUpdated, null, FurbyGlobals.Player);
					m_RequiresExcusivity = false;
					break;
				}
			}
			if (scannerEvents != ScannerEvents.ScanningCancelled)
			{
				return;
			}
			if (FurbyGlobals.SettingsHelper.IsChangeFurbyRequested())
			{
				AdultFurbyType previousFurbyType = FurbyGlobals.SettingsHelper.GetPreviousFurbyType();
				Singleton<GameDataStoreObject>.Instance.Data.FurbyType = previousFurbyType;
				Singleton<GameDataStoreObject>.Instance.Data.HasCompletedFirstTimeFlow = true;
				FurbyGlobals.SettingsHelper.ClearChangeFurbyRequest();
				if (FurbyGlobals.SettingsHelper.RequestCameFromFrontEnd())
				{
					GameEventRouter.SendEvent(ScannerEvents.GoBackToModeChoice);
				}
				else
				{
					GameEventRouter.SendEvent(ScannerEvents.GoBackToSettingsScreen);
				}
			}
			else
			{
				GameEventRouter.SendEvent(ScannerEvents.GoBackToModeChoice);
			}
		}

		private IEnumerator ScanningFlow(bool firstScan)
		{
			if (m_CurrentlyScanning)
			{
				yield break;
			}
			bool furbyPresent = false;
			FurbyReply furbyReply = delegate(bool acknowledged)
			{
				furbyPresent = acknowledged;
			};
			ScanningStarted(firstScan);
			GameEventRouter.SendEvent(ScannerEvents.ScanningStarted);
			for (int i = 0; i < m_ScanMessageCount; i++)
			{
				if (!Singleton<FurbyDataChannel>.Instance.FurbyStatus.Supported && !FurbyGlobals.SettingsHelper.IsChangeFurbyRequested())
				{
					yield return new WaitForSeconds(0.5f);
					GameEventRouter.SendEvent(ScannerEvents.OldFurbyFound);
					ScanningFinished(firstScan);
					yield break;
				}
				if (furbyPresent)
				{
					yield return this.CommandAwaitReply(FurbyCommand.Status, furbyReply);
					if (furbyPresent)
					{
						yield return StartCoroutine(ScanningSucceeded(firstScan));
						yield break;
					}
				}
				else
				{
					yield return this.CommandAwaitReply(FurbyCommand.Application, furbyReply);
				}
			}
			ScanningFailed(firstScan);
		}

		private void ScanningStarted(bool firstScan)
		{
			Singleton<FurbyDataChannel>.Instance.AutoConnect = false;
			m_CurrentlyScanning = true;
		}

		private void ScanningFinished(bool firstScan)
		{
			Singleton<FurbyDataChannel>.Instance.AutoConnect = true;
			Singleton<FurbyDataChannel>.Instance.SetConnectionTone(FurbyCommand.Application);
			m_CurrentlyScanning = false;
		}

		private void ScanningFailed(bool firstScan)
		{
			m_RequiresExcusivity = !firstScan;
			if (!firstScan)
			{
				string fullName = FurbyGlobals.Player.FullName;
				GameEventRouter.SendEvent(ScannerEvents.ScanningFailed, null, fullName, fullName);
				GameEventRouter.SendEvent(ScannerEvents.NoFurbyFound, null, fullName, fullName);
			}
			else
			{
				GameEventRouter.SendEvent(ScannerEvents.ScanningFailed);
				GameEventRouter.SendEvent(ScannerEvents.InitialScanFailed);
			}
			ScanningFinished(firstScan);
		}

		private IEnumerator ScanningSucceeded(bool firstScan)
		{
			FurbyStatus furbyStatus = Singleton<FurbyDataChannel>.Instance.FurbyStatus;
			if (m_DebugOverride)
			{
				furbyStatus = m_DebugStatus;
				m_DebugOverride = false;
			}
			if (!firstScan)
			{
				if (!FurbyGlobals.Player.IsPlayersFurby(furbyStatus))
				{
					string furbyName = FurbyGlobals.Player.FullName;
					GameEventRouter.SendEvent(ScannerEvents.ScanningSucceeded);
					GameEventRouter.SendEvent(PlayerFurbyEvent.StatusUpdated, null, FurbyGlobals.Player);
					m_RequiresExcusivity = true;
					GameEventRouter.SendEvent(ScannerEvents.IncorrectFurbyFound, null, furbyName, furbyName);
				}
				else
				{
					FurbyGlobals.Player.NewHappiness = (float)furbyStatus.Happyness / 100f;
					if (!FurbyGlobals.Player.HasScannedThisPlaythrough())
					{
						FurbyGlobals.Player.NewSatiatedness = (float)furbyStatus.Fullness / 100f;
					}
					FurbyGlobals.Player.Sickness = furbyStatus.Sickness == 1;
					GameEventRouter.SendEvent(PlayerFurbyCommand.TurnOffNoFurbyMode);
					GameEventRouter.SendEvent(ScannerEvents.ScanningSucceeded);
					GameEventRouter.SendEvent(PlayerFurbyEvent.StatusUpdated, null, FurbyGlobals.Player);
					m_RequiresExcusivity = false;
				}
			}
			else
			{
				FurbyGlobals.SettingsHelper.ClearChangeFurbyRequest();
				FurbyGlobals.Player.SetScannedFlag(true);
				Singleton<GameDataStoreObject>.Instance.Data.FurbyType = AdultFurbyLibrary.ConvertComAirPatternToAdultType(furbyStatus.Pattern);
				if (!Singleton<GameDataStoreObject>.Instance.Data.MetFurbies.Contains(Singleton<GameDataStoreObject>.Instance.Data.FurbyType))
				{
					Singleton<GameDataStoreObject>.Instance.Data.MetFurbies.Add(Singleton<GameDataStoreObject>.Instance.Data.FurbyType);
				}
				GameEventRouter.SendEvent(ScannerEvents.ScanningSucceeded);
				if (furbyStatus.Name == FurbyReceiveName.Anonymous)
				{
					if (m_namingData != null)
					{
						Singleton<GameDataStoreObject>.Instance.Data.FurbyNameLeft = m_namingData.m_leftNames[UnityEngine.Random.Range(0, m_namingData.m_leftNames.Length)];
						Singleton<GameDataStoreObject>.Instance.Data.FurbyNameRight = m_namingData.m_rightNames[UnityEngine.Random.Range(0, m_namingData.m_rightNames.Length)];
					}
					GameEventRouter.SendEvent(PlayerFurbyEvent.StatusUpdated, null, FurbyGlobals.Player);
					yield return new WaitForSeconds(1f);
					GameEventRouter.SendEvent(ScannerEvents.InitialScanComplete);
				}
				else
				{
					string[] nameParts = furbyStatus.Name.ToString().Split('_');
					if (nameParts.Length == 2)
					{
						Singleton<GameDataStoreObject>.Instance.Data.FurbyNameLeft = nameParts[0].ToUpper();
						Singleton<GameDataStoreObject>.Instance.Data.FurbyNameRight = nameParts[1].ToUpper();
						Singleton<GameDataStoreObject>.Instance.Data.HasCompletedFirstTimeFlow = true;
						Singleton<GameDataStoreObject>.Instance.Save();
						GameEventRouter.SendEvent(PlayerFurbyEvent.StatusUpdated, null, FurbyGlobals.Player);
						yield return new WaitForSeconds(1f);
						GameEventRouter.SendEvent(ScannerEvents.InitialScanCompleteNamingNotRequired);
					}
					else
					{
						GameEventRouter.SendEvent(PlayerFurbyEvent.StatusUpdated, null, FurbyGlobals.Player);
						yield return new WaitForSeconds(1f);
						GameEventRouter.SendEvent(ScannerEvents.InitialScanComplete);
					}
				}
				m_RequiresExcusivity = false;
			}
			GameDataStoreObject store = Singleton<GameDataStoreObject>.Instance;
			if (CrystalTypes.Contains(store.Data.FurbyType) && !Singleton<GameDataStoreObject>.Instance.GlobalData.CrystalUnlocked)
			{
				store.UnlockCrystal();
				GameEventRouter.SendEvent(CrystalUnlockTelemetryEvents.CrystalUnlocked_ScannedFurby);
			}
			ScanningFinished(firstScan);
		}

		public bool IsBusy()
		{
			return m_RequiresExcusivity && !FurbyGlobals.Player.NoFurbyOnSaveGame();
		}

		private void OnDebugPanelGUI(Enum evtType, GameObject gObj, params object[] parameters)
		{
			if (DebugPanel.StartSection("Fake Furby Scanning"))
			{
				GUILayout.BeginHorizontal();
				GUILayout.Label("Pattern");
				if (GUILayout.Button(" < "))
				{
					int num = (int)(m_DebugStatus.Pattern - 1);
					if (num == 0)
					{
						num = 12;
					}
					m_DebugStatus.Pattern = (FurbyPattern)num;
				}
				GUILayout.TextField(m_DebugStatus.Pattern.ToString(), GUILayout.Width(200f));
				if (GUILayout.Button(" > "))
				{
					int num2 = (int)(m_DebugStatus.Pattern + 1);
					if (num2 == 13)
					{
						num2 = 1;
					}
					m_DebugStatus.Pattern = (FurbyPattern)num2;
				}
				GUILayout.EndHorizontal();
				GUILayout.BeginHorizontal();
				GUILayout.Label("Personality");
				if (GUILayout.Button(" < "))
				{
					int num3 = (int)(m_DebugStatus.Personality - 918) % 5;
					if (num3 < 0)
					{
						num3 += 5;
					}
					m_DebugStatus.Personality = (FurbyPersonality)(num3 + 917);
				}
				GUILayout.TextField(m_DebugStatus.Personality.ToString(), GUILayout.Width(200f));
				if (GUILayout.Button(" > "))
				{
					int personality = (int)(m_DebugStatus.Personality - 916) % 5 + 917;
					m_DebugStatus.Personality = (FurbyPersonality)personality;
				}
				GUILayout.EndHorizontal();
				GUILayout.BeginHorizontal();
				GUILayout.Label("Happiness");
				m_DebugStatus.Happyness = (int)GUILayout.HorizontalSlider(m_DebugStatus.Happyness, 0f, 100f);
				GUILayout.EndHorizontal();
				GUILayout.BeginHorizontal();
				GUILayout.Label("Hunger");
				m_DebugStatus.Fullness = (int)GUILayout.HorizontalSlider(m_DebugStatus.Fullness, 0f, 100f);
				GUILayout.EndHorizontal();
				if (GUILayout.Button("Override Status"))
				{
					m_DebugOverride = true;
				}
			}
			DebugPanel.EndSection();
		}
	}
}
