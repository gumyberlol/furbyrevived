using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Furby;
using Relentless.Core.DesignPatterns.ProviderManager;
using UnityEngine;
using UnityEngine.Purchasing;

namespace Relentless
{
	public class RsStoreMediator : SingletonInstance<RsStoreMediator>
	{
		public static class UnityResourceLoader {
			public static string HackJsonBucket;
		}
		public enum StoreResponse
		{
			Succeeded = 0,
			Cancelled = 1,
			Failed = 2,
			CouldntValidate = 3
		}

		public enum TransactionsRestoredState
		{
			NotSet = 0,
			InProgress = 1,
			SuccessfullyRestored = 2,
			RestoreFailed = 3
		}

		public delegate void RsStoreMediatorValidationDelegate_ForItems(string itemID);

		public delegate void RsStoreMediatorValidationDelegate_ForState(bool success);

		[SerializeField]
		public string m_DestinationFile = "c:\\Inventory.xml";

		private static readonly object m_Lock = new object();

		private bool m_InitializationSequenceComplete;

		private StoreMediatorStatus m_Status;

		private string m_uniBillJson = string.Empty;

		[SerializeField]
		public StoreResponse m_ResponseAfterFailingToValidate = StoreResponse.Failed;

		[SerializeField]
		private int m_MaxNumOfReceiptValidationAttempts = 2;

		private StoreResponse? m_LastStoreResponse;

		private TransactionsRestoredState m_TransactionRestored;

		public RsStoreMediatorValidationDelegate_ForItems m_PurchaseFailed = delegate
		{
			SingletonInstance<RsStoreMediator>.Instance.LastStoreResponse = StoreResponse.Failed;
		};

		public RsStoreMediatorValidationDelegate_ForItems m_PurchaseCancelled = delegate
		{
			SingletonInstance<RsStoreMediator>.Instance.LastStoreResponse = StoreResponse.Cancelled;
		};

		public RsStoreMediatorValidationDelegate_ForItems m_PurchaseComplete = delegate
		{
			SingletonInstance<RsStoreMediator>.Instance.LastStoreResponse = StoreResponse.Succeeded;
		};

		public RsStoreMediatorValidationDelegate_ForItems m_PurchaseCouldntValidate = delegate
		{
			SingletonInstance<RsStoreMediator>.Instance.LastStoreResponse = StoreResponse.CouldntValidate;
		};

		public RsStoreMediatorValidationDelegate_ForState m_TransactionsRestoredSuccess = delegate
		{
			SingletonInstance<RsStoreMediator>.Instance.TransactionRestored = TransactionsRestoredState.SuccessfullyRestored;
		};

		public RsStoreMediatorValidationDelegate_ForState m_TransactionsRestoredFailure = delegate
		{
			SingletonInstance<RsStoreMediator>.Instance.TransactionRestored = TransactionsRestoredState.RestoreFailed;
		};

		private GameEventSubscription m_DebugPanelSub;

		public StoreMediatorStatus Status
		{
			get
			{
				return m_Status;
			}
		}

		public bool InitializationSequenceComplete
		{
			get
			{
				lock (m_Lock)
				{
					return m_InitializationSequenceComplete;
				}
			}
			private set
			{
				lock (m_Lock)
				{
					m_InitializationSequenceComplete = value;
				}
			}
		}

		public StoreResponse? LastStoreResponse
		{
			get
			{
				return m_LastStoreResponse;
			}
			set
			{
				m_LastStoreResponse = value;
			}
		}

		public TransactionsRestoredState TransactionRestored
		{
			get
			{
				return m_TransactionRestored;
			}
			set
			{
				m_TransactionRestored = value;
			}
		}

		public event RsStoreMediatorValidationDelegate_ForItems OnPurchaseComplete_ReceiptValidationSucceeded;

		public event RsStoreMediatorValidationDelegate_ForItems OnPurchaseComplete_ReceiptValidationFailed;

		public event RsStoreMediatorValidationDelegate_ForItems OnPurchaseComplete_ReceiptValidationUnresolved;

		public event RsStoreMediatorValidationDelegate_ForItems OnPurchaseCancelled;

		public event RsStoreMediatorValidationDelegate_ForItems OnPurchaseFailed;

		public event RsStoreMediatorValidationDelegate_ForState OnTransactionsRestored_Success;

		public event RsStoreMediatorValidationDelegate_ForState OnTransactionsRestored_Failure;

		public bool AmAbleToMediatePurchases()
		{
			return m_Status == StoreMediatorStatus.AbleToMediatePurchases;
		}

		public override void Awake()
		{
			base.Awake();
			StartCoroutine(InitializeSelf());
		}

		private IEnumerator InitializeSelf()
		{
			RsStoreMediatorLogger("Initialization started...");
			m_Status = StoreMediatorStatus.NotStarted;
			m_InitializationSequenceComplete = false;
			yield return StartCoroutine(WaitForNetwork());
			m_Status = StoreMediatorStatus.WaitingForInventory;
			yield return StartCoroutine(WaitForInventoryDownloader());
			m_Status = StoreMediatorStatus.WaitingForBillingSystem;
			if (!string.IsNullOrEmpty(m_uniBillJson))
			{
				yield return StartCoroutine(WaitForIAPBillingSystem());
				RsStoreMediatorLogger(" ...Initialization complete.");
				SingletonInstance<RsUniBillInterface>.Instance.OnPurchaseComplete_NoReceipt += OnUniBillPurchaseComplete_NoReceipt;
				SingletonInstance<RsUniBillInterface>.Instance.OnPurchaseComplete_WithReceipt += OnUniBillPurchaseComplete_WithReceipt;
				SingletonInstance<RsUniBillInterface>.Instance.OnPurchaseCancelled += OnUniBillPurchaseCancelled;
				SingletonInstance<RsUniBillInterface>.Instance.OnTransactionsRestored += OnUniBillTransactionsRestored;
				Helpers_AttachToDelegates();
				m_Status = StoreMediatorStatus.AbleToMediatePurchases;
			}
			else
			{
				m_Status = StoreMediatorStatus.NoInventory_Halted;
				RsStoreMediatorLogger("No xml downloaded.");
			}
			m_InitializationSequenceComplete = true;
		}

		private IEnumerator WaitForIAPBillingSystem()
		{
			RsStoreMediatorLogger("Initializing Billing System...");
			StartCoroutine(SingletonInstance<RsUniBillInterface>.Instance.Initialize());
			while (!SingletonInstance<RsUniBillInterface>.Instance.InitializationComplete)
			{
				yield return new WaitForEndOfFrame();
			}
			RsStoreMediatorLogger("...Billing System Initialized!");
		}

		public bool IsBillingSystemFunctional()
		{
			return true;
		}

		private IEnumerator WaitForNetwork()
		{
			RsStoreMediatorLogger("Initializing Network...");
			while (!SetupNetworking.IsReady)
			{
				yield return new WaitForEndOfFrame();
			}
			RsStoreMediatorLogger("...Networking Initialized!");
		}

		private IEnumerator WaitForInventoryDownloader()
		{
			RsStoreMediatorLogger("Downloading Inventory...");
			while (!InAppPurchaseServer.IsReady)
			{
				yield return new WaitForEndOfFrame();
			}
			bool isSandbox = Debug.isDebugBuild;
			RsStoreMediatorLogger("Inventory Downloader Initialized...");
			m_uniBillJson = ""; // Stubbed UniBill JSON, skipping GetUniBillJson call :3
			RsStoreMediatorLogger("UniBill JSON:\r\n" + m_uniBillJson);
			UnityResourceLoader.HackJsonBucket = m_uniBillJson;
			RsStoreMediatorLogger("...Downloaded Inventory!");
		}

		private void RsStoreMediatorLogger(string logString)
		{
		}

		private void OnUniBillPurchaseComplete_WithReceipt(string userId, string itemID, string receipt)
		{
			RsStoreMediatorLogger("OnUniBillPurchaseComplete_WithReceipt ... [" + itemID + "] ... ");
			string text = Convert.ToBase64String(Encoding.UTF8.GetBytes(receipt));
			RsStoreMediatorLogger("userId = " + userId + ", itemID = " + itemID + ", receipt = " + receipt + "\r\nreceiptBase64 = " + text);
			AttemptValidation(userId, itemID, text);
		}

		private void OnUniBillPurchaseComplete_NoReceipt(string empty_do_not_use, string itemID, string also_empty_do_not_use)
		{
			RsStoreMediatorLogger("OnUniBillPurchaseComplete_NoReceipt ... [" + itemID + "] ... ");
			if (this.OnPurchaseComplete_ReceiptValidationFailed != null)
			{
				this.OnPurchaseComplete_ReceiptValidationFailed(itemID);
			}
		}

		private void AttemptValidation(string userId, string itemID, string receiptBase64)
		{
			GameData saveGameData = Singleton<GameDataStoreObject>.Instance.Data;
			SingletonInstance<InAppPurchaseServer>.Instance.StartValidatingProduct(userId, itemID, receiptBase64, delegate(string id, bool? result)
			{
				if (result.HasValue)
				{
					if (saveGameData.HaveUnresolvedReceipt(itemID))
					{
						saveGameData.SetReceiptAsResolved(itemID);
					}
					if (result.Value)
					{
						RsStoreMediatorLogger("OnUniBillPurchaseComplete:: Validation SUCCEEDED. [itemID = " + itemID + "]");
						if (this.OnPurchaseComplete_ReceiptValidationSucceeded != null)
						{
							this.OnPurchaseComplete_ReceiptValidationSucceeded(itemID);
						}
					}
					else
					{
						RsStoreMediatorLogger("OnUniBillPurchaseComplete:: Validation FAILED. [itemID = " + itemID + "]");
						if (this.OnPurchaseComplete_ReceiptValidationFailed != null)
						{
							this.OnPurchaseComplete_ReceiptValidationFailed(itemID);
						}
					}
				}
				else
				{
					RsStoreMediatorLogger("OnUniBillPurchaseComplete:: Validation couldnt complete. [itemID = " + itemID + "]");
					if (saveGameData.HaveUnresolvedReceipt(itemID))
					{
						saveGameData.UpdateResolvedReceipt(itemID);
					}
					else
					{
						saveGameData.RememberUnresolvedReceipt(itemID, receiptBase64);
					}
					if (this.OnPurchaseComplete_ReceiptValidationUnresolved != null)
					{
						this.OnPurchaseComplete_ReceiptValidationUnresolved(itemID);
					}
				}
				Singleton<GameDataStoreObject>.Instance.Save();
			});
		}

		private void OnUniBillPurchaseCancelled(string itemID)
		{
			RsStoreMediatorLogger("OnPurchaseCancelledHandler... [" + itemID + "]");
			if (this.OnPurchaseCancelled != null)
			{
				this.OnPurchaseCancelled(itemID);
			}
			else
			{
				RsStoreMediatorLogger("OnPurchaseCancelledHandler (ignored)");
			}
			GameEventRouter.SendEvent(IAPPurchaseEvents.PurchaseCancelled, null, itemID);
		}

		private void OnUniBillPurchaseFailed(string itemID)
		{
			RsStoreMediatorLogger("OnPurchaseFailedHandler... [" + itemID + "]");
			if (this.OnPurchaseFailed != null)
			{
				this.OnPurchaseFailed(itemID);
			}
			else
			{
				RsStoreMediatorLogger("OnPurchaseFailedHandler (ignored)");
			}
			GameEventRouter.SendEvent(IAPPurchaseEvents.PurchaseFailed, null, itemID);
		}

		private void OnUniBillTransactionsRestored(bool successState)
		{
			TransactionRestored = TransactionsRestoredState.InProgress;
			RsStoreMediatorLogger("RsStoreMediator::OnUniBillTransactionsRestored...");
			if (successState)
			{
				if (this.OnTransactionsRestored_Success != null)
				{
					RsStoreMediatorLogger("RsStoreMediator::OnUniBillTransactionsRestored Success! (Calling callback)");
					this.OnTransactionsRestored_Success(successState);
				}
				else
				{
					RsStoreMediatorLogger("RsStoreMediator::OnUniBillTransactionsRestored Success! (no callback)");
				}
			}
			else if (this.OnTransactionsRestored_Failure != null)
			{
				RsStoreMediatorLogger("RsStoreMediator::OnUniBillTransactionsRestored Failure! (Calling callback)");
				this.OnTransactionsRestored_Failure(successState);
			}
			else
			{
				RsStoreMediatorLogger("RsStoreMediator::OnUniBillTransactionsRestored Failure! (no callback)");
			}
		}

		public bool IsBillingSystemIsAvailable()
		{
			return SingletonInstance<RsUniBillInterface>.Instance.AbleToProcessPurchases();
		}

		public bool IsItemAvailable(string itemID)
		{
			bool? flag = SingletonInstance<InAppPurchaseServer>.Instance.IsProductAvaliable(itemID);
			if (flag.HasValue)
			{
				return flag.Value;
			}
			return false;
		}

		public bool AreFastForwardsAvailable()
		{
			return CanItemBePurchased("FurbyIAPBundle1") && CanItemBePurchased("FurbyIAPBundle2") && CanItemBePurchased("FurbyIAPBundle3");
		}

		public bool IsCrystalSkinAvailable()
		{
			return CanItemBePurchased("FurbyIAPBundle4");
		}

		public bool IsCrystalSkinOnTheStore()
		{
			return IsItemAvailable("FurbyIAPBundle4");
		}

		public ProductType GetPurchaseType(string itemID)
		{
			return ProductType.Consumable;
		}


		public bool CanItemBeRestored(string itemID)
		{
			return false;
		}

		public bool CanItemBePurchased(string itemID)
		{
			if (!IsItemAvailable(itemID))
			{
				return false;
			}
			if (!IsBillingSystemFunctional())
			{
				return false;
			}

			// UniBill removed – assume all items can be purchased
			return true;
		}


		public void AttemptToPurchaseItem(string itemID)
		{
			RsStoreMediatorLogger("AttemptToPurchaseItem: " + itemID);
			if (IsItemAvailable(itemID))
			{
				if (IsBillingSystemIsAvailable())
				{
					SingletonInstance<RsUniBillInterface>.Instance.ConductPurchase(itemID);
				}
				else
				{
					RsStoreMediatorLogger("AttemptToPurchaseItem: " + itemID + ", billing system unavailable.");
				}
			}
			else
			{
				RsStoreMediatorLogger("AttemptToPurchaseItem: " + itemID + ", item NOT available.");
			}
		}

		public void AttemptToReValidatePurchase(string itemID)
		{
			RsStoreMediatorLogger("AttemptToReValidatePurchase::" + itemID);
			GameData.IAPReceipt unresolvedReceipt = Singleton<GameDataStoreObject>.Instance.Data.GetUnresolvedReceipt(itemID);
			if (unresolvedReceipt == null)
			{
				RsStoreMediatorLogger("AttemptToReValidatePurchase:" + itemID + ", No receipt; cant validate.");
				if (this.OnPurchaseComplete_ReceiptValidationFailed != null)
				{
					this.OnPurchaseComplete_ReceiptValidationFailed(itemID);
				}
			}
			else
			{
				RsStoreMediatorLogger("AttemptToReValidatePurchase:" + itemID + ", got receipt; validating...");
			}
		}

		public int GetPurchaseCount(string itemID)
		{
			return SingletonInstance<RsUniBillInterface>.Instance.GetPurchaseCount(itemID);
		}

		public bool HasItemBeenPurchased(string itemID)
		{
			return SingletonInstance<RsUniBillInterface>.Instance.HasItemBeenPurchased(itemID);
		}

		public string GetPurchaseItemPriceForDisplay(string itemID)
		{
			return SingletonInstance<RsUniBillInterface>.Instance.GetLocalizedPriceString(itemID);
		}

		public IEnumerator ConductRestorePurchasesFlow()
		{
			SingletonInstance<RsUniBillInterface>.Instance.RestorePurchasedItems();
			RsStoreMediatorLogger("ConductRestorePurchasesFlow: Waiting for state...");
			while (SetupNetworking.IsInternetReady && TransactionRestored == TransactionsRestoredState.InProgress)
			{
				yield return null;
			}
		}

		public IEnumerator ConductPurchaseFlow(string bundleID)
		{
			RsStoreMediatorLogger("ConductPurchaseFlow:" + bundleID);
			LastStoreResponse = null;
			if (SingletonInstance<RsStoreMediator>.Instance.CanItemBePurchased(bundleID))
			{
				AttemptToPurchaseItem(bundleID);
				RsStoreMediatorLogger("ConductPurchaseFlow:" + bundleID + ", waiting for store response.");
				while (SetupNetworking.IsInternetReady && !LastStoreResponse.HasValue)
				{
					yield return null;
				}
				if (SetupNetworking.IsInternetReady && LastStoreResponse.HasValue)
				{
					RsStoreMediatorLogger("ConductPurchaseFlow:" + bundleID + ", got store response.");
					yield return StartCoroutine(ResolveResponseViaReceiptValidation(bundleID));
					RsStoreMediatorLogger("ConductPurchaseFlow:" + bundleID + ", validation complete.");
				}
				else
				{
					LastStoreResponse = StoreResponse.Failed;
				}
			}
			else
			{
				LastStoreResponse = StoreResponse.Failed;
			}
		}

		private void Helpers_AttachToDelegates()
		{
			this.OnPurchaseFailed = (RsStoreMediatorValidationDelegate_ForItems)Delegate.Combine(this.OnPurchaseFailed, m_PurchaseFailed);
			this.OnPurchaseCancelled = (RsStoreMediatorValidationDelegate_ForItems)Delegate.Combine(this.OnPurchaseCancelled, m_PurchaseCancelled);
			this.OnPurchaseComplete_ReceiptValidationSucceeded = (RsStoreMediatorValidationDelegate_ForItems)Delegate.Combine(this.OnPurchaseComplete_ReceiptValidationSucceeded, m_PurchaseComplete);
			this.OnPurchaseComplete_ReceiptValidationFailed = (RsStoreMediatorValidationDelegate_ForItems)Delegate.Combine(this.OnPurchaseComplete_ReceiptValidationFailed, m_PurchaseFailed);
			this.OnPurchaseComplete_ReceiptValidationUnresolved = (RsStoreMediatorValidationDelegate_ForItems)Delegate.Combine(this.OnPurchaseComplete_ReceiptValidationUnresolved, m_PurchaseCouldntValidate);
			this.OnTransactionsRestored_Success = (RsStoreMediatorValidationDelegate_ForState)Delegate.Combine(this.OnTransactionsRestored_Success, m_TransactionsRestoredSuccess);
			this.OnTransactionsRestored_Failure = (RsStoreMediatorValidationDelegate_ForState)Delegate.Combine(this.OnTransactionsRestored_Failure, m_TransactionsRestoredFailure);
		}

		public IEnumerator ResolveResponseViaReceiptValidation(string bundleID)
		{
			RsStoreMediatorLogger("ResolveResponseViaReceiptValidation:" + bundleID + " - Store response: " + LastStoreResponse.ToString());
			if (LastStoreResponse != StoreResponse.CouldntValidate)
			{
				yield break;
			}
			GameConfigBlob gameConfig = SingletonInstance<GameConfiguration>.Instance.GetGameConfigBlob();
			if (!gameConfig.m_RequireValidatedReceipts)
			{
				RsStoreMediatorLogger("ResolveResponseViaReceiptValidation:" + bundleID + " - Dont require validation, marking as success");
				LastStoreResponse = StoreResponse.Succeeded;
			}
			else
			{
				RsStoreMediatorLogger("ResolveResponseViaReceiptValidation:" + bundleID + " - Do require validation, processing...");
				GameData saveGameData = Singleton<GameDataStoreObject>.Instance.Data;
				int numOfValidationAttempts = 0;
				if (saveGameData.HaveUnresolvedReceipt(bundleID))
				{
					numOfValidationAttempts = saveGameData.GetUnresolvedReceipt(bundleID).m_ValidationCount;
				}
				RsStoreMediatorLogger("ResolveResponseViaReceiptValidation:" + bundleID + " - Attempting to validate");
				for (int nthValidationAttempt = numOfValidationAttempts; nthValidationAttempt < m_MaxNumOfReceiptValidationAttempts; nthValidationAttempt++)
				{
					LastStoreResponse = null;
					AttemptToReValidatePurchase(bundleID);
					while (SetupNetworking.IsInternetReady && !LastStoreResponse.HasValue)
					{
						yield return null;
					}
					if (LastStoreResponse != StoreResponse.CouldntValidate)
					{
						break;
					}
				}
				if (LastStoreResponse == StoreResponse.CouldntValidate)
				{
					RsStoreMediatorLogger("ResolveResponseViaReceiptValidation:" + bundleID + " - Failed validation, final state: " + m_ResponseAfterFailingToValidate);
					LastStoreResponse = m_ResponseAfterFailingToValidate;
				}
			}
			RsStoreMediatorLogger("ResolveResponseViaReceiptValidation:" + bundleID + " - Process complete, final state: " + LastStoreResponse.ToString());
		}

		private void OnEnable()
		{
			m_DebugPanelSub = new GameEventSubscription(OnDebugPanelGUI, DebugPanelEvent.DrawElementRequested);
		}

		private static void ShowColouredState(string title, bool state)
		{
			float width = 300f;
			GUILayout.BeginHorizontal();
			GUILayout.Label(title, RelentlessGUIStyles.Style_Normal, GUILayout.Width(width));
			GUILayout.Label((!state) ? "NO" : "YES", (!state) ? RelentlessGUIStyles.Style_RsRed : RelentlessGUIStyles.Style_RsGreen, GUILayout.ExpandWidth(true));
			GUILayout.EndHorizontal();
		}

		private void OnDebugPanelGUI(Enum evtType, GameObject gObj, params object[] parameters)
		{
			float num = 300f;
			if (DebugPanel.StartSection("IAP Store Mediator"))
			{
				GUILayout.Space(10f);
				GUILayout.Label("[Application Settings]", RelentlessGUIStyles.Style_Header, GUILayout.Width(num));
				GUILayout.BeginHorizontal();
				GUILayout.Label("Native Network:", RelentlessGUIStyles.Style_Normal, GUILayout.Width(num));
				GUILayout.Label(Application.internetReachability.ToString(), RelentlessGUIStyles.Style_Column, GUILayout.Width(num));
				GUILayout.EndHorizontal();
				if (SingletonInstance<ApplicationSettingsBehaviour>.Exists)
				{
					GUILayout.BeginHorizontal();
					GUILayout.Label("Country Code", RelentlessGUIStyles.Style_Normal, GUILayout.Width(num));
					GUILayout.Label(Singleton<GameDataStoreObject>.Instance.GlobalData.CountryCode, RelentlessGUIStyles.Style_Column, GUILayout.Width(num));
					GUILayout.EndHorizontal();
					GUILayout.BeginHorizontal();
					GUILayout.Label("Bundle ID:", RelentlessGUIStyles.Style_Normal, GUILayout.Width(num));
					GUILayout.Label(SingletonInstance<ApplicationSettingsBehaviour>.Instance.ApplicationSettings.bundleIdentifier.ToString(), RelentlessGUIStyles.Style_Column, GUILayout.Width(num));
					GUILayout.EndHorizontal();
					GUILayout.BeginHorizontal();
					GUILayout.Label("Bundle Version:", RelentlessGUIStyles.Style_Normal, GUILayout.Width(num));
					GUILayout.Label(SingletonInstance<ApplicationSettingsBehaviour>.Instance.ApplicationSettings.bundleVersion.ToString(), RelentlessGUIStyles.Style_Column, GUILayout.Width(num));
					GUILayout.EndHorizontal();
					ShowColouredState("IAP StoreSandbox?: ", SingletonInstance<ApplicationSettingsBehaviour>.Instance.ApplicationSettings.StoreSandboxEnabled);
				}
				ShowMediatorStatus(num);
				ShowBillingSystem(num);
				ShowIAPServer(num);
			}
			DebugPanel.EndSection();
		}

		private void ShowIAPServer(float columnWidth)
		{
			GUILayout.Space(10f);
			GUILayout.Label("[InAppPurchase Server]", RelentlessGUIStyles.Style_Header, GUILayout.Width(columnWidth));
			ShowColouredState("Ready?: ", InAppPurchaseServer.IsReady);
			ShowColouredState("Inventory DL?: ", SingletonInstance<InAppPurchaseServer>.Instance.ProductListDownloaded);
			GUILayout.Space(10f);
			if (DebugPanel.StartSection("Raw JSON Data"))
			{
				GUILayout.Label(m_uniBillJson, RelentlessGUIStyles.Style_NormalWrapped, GUILayout.Width(columnWidth * 2f), GUILayout.ExpandHeight(true));
			}
			GUILayout.Space(10f);
			DebugPanel.EndSection();
			GUILayout.Space(10f);
		}

		private void ShowMediatorStatus(float columnWidth)
		{
			GUILayout.Space(10f);
			GUILayout.Label("[Mediator Status]", RelentlessGUIStyles.Style_Header, GUILayout.Width(columnWidth));
			ShowColouredState("Networking Setup?", SetupNetworking.IsReady);
			ShowColouredState("Networking Available?", SetupNetworking.IsInternetReady);
			ShowColouredState("AppStore Initialized?", SingletonInstance<RsStoreMediator>.Instance.InitializationSequenceComplete);
			ShowColouredState("Init With Success?: ", AmAbleToMediatePurchases());
			GUILayout.BeginHorizontal();
			GUILayout.Label("Full Status: ", RelentlessGUIStyles.Style_Normal, GUILayout.Width(columnWidth));
			GUILayout.Label(Status.ToString(), RelentlessGUIStyles.Style_Column, GUILayout.Width(columnWidth));
			GUILayout.EndHorizontal();
		}

		private void ShowBillingSystem(float columnWidth)
		{
			GUILayout.Space(10f);
			GUILayout.Label("[Billing System]", RelentlessGUIStyles.Style_Header, GUILayout.Width(columnWidth));
			ShowColouredState("Initialized?", SingletonInstance<RsUniBillInterface>.Instance.InitializationComplete);
			ShowColouredState("Functional?:", IsBillingSystemFunctional());
			GUILayout.BeginHorizontal();
			GUILayout.Label("UniBill Status: ", RelentlessGUIStyles.Style_Normal, GUILayout.Width(columnWidth));
			GUILayout.Label("Unibill? more like Unibroke.", RelentlessGUIStyles.Style_Column, GUILayout.Width(columnWidth));
			GUILayout.EndHorizontal();
			if (SingletonInstance<RsUniBillInterface>.Instance.InitializationComplete)
			{
				GUILayout.Space(10f);
				GUILayout.Label("[Inventory]", RelentlessGUIStyles.Style_Header, GUILayout.ExpandWidth(true));
				if (false)
				{
					if (DebugPanel.StartSection("Non-Consumables (0)")) // unibill went kaboom and died in a fire
					{
						// Do nothing! All non-consumables are in a black hole now 🚫🛒
					}
					DebugPanel.EndSection();
				}
				if (false)
				{
					if (DebugPanel.StartSection("Consumables (0)")) // unibill exploded again 💥
					{
						// No items, because Unibiller got banned from this planet
					}
					DebugPanel.EndSection();
				}
				if (false)
				{
					if (DebugPanel.StartSection("Subscriptions (0)")) // unibill meltdown containment zone
					{
						// Nothing to see here... all subscriptions got vaporized
					}

					DebugPanel.EndSection();
				}
				GUILayout.Space(10f);
				GUILayout.Label("[Billing System Controls]", RelentlessGUIStyles.Style_Header, GUILayout.ExpandWidth(true));
				if (GUILayout.Button("Restore Purchases"))
				{
					SingletonInstance<RsUniBillInterface>.Instance.RestorePurchasedItems();
				}
				if (GUILayout.Button("Clear all Transactions"))
				{
					// nothing. you dont get to clear your transacitons :P
				}
			}
			GUILayout.Space(10f);
			if (DebugPanel.StartSection("Errors (0)")) // unibill meltdown containment zone
			{
				// no errors for you unibill
			}

			DebugPanel.EndSection();
		}

		private void ShowPurchasableItemArray(UnityEngine.Purchasing.Product[] purchasableItemArray)
		{
			float width = 150f;
			float num = 275f;
			// Purchasable items display stubbed due to Unibill removal :3
			GUILayout.Label("Purchasable items list is unavailable.", RelentlessGUIStyles.Style_Normal);
		}
	}
}
