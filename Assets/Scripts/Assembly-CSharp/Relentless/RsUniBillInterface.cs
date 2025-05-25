using System;
using UnityEngine;
using UnityEngine.Purchasing;
using System.Collections;

namespace Relentless
{
	public class RsUniBillInterface : SingletonInstance<RsUniBillInterface>, IStoreListener
	{
		public enum PurchaseState
		{
			PurchaseInactive = 0,
			PurchaseInProgress = 1,
			PurchaseCompleted = 2,
			PurchaseCancelled = 3,
			PurchaseFailed = 4
		}

		public delegate void RsUniBillPurchaseCompleteDelegate(string userId, string itemID, string receipt);
		public delegate void RsUniBillPurchaseDelegate_Items(string itemID);
		public delegate void RsUniBillPurchaseDelegate_State(bool state);

		private string m_lastReceipt = string.Empty;
		private bool m_InitializationComplete;
		private IStoreController m_StoreController;
		private IExtensionProvider m_StoreExtensionProvider;

		public bool InitializationComplete => m_InitializationComplete;

		public event RsUniBillPurchaseCompleteDelegate OnPurchaseComplete_WithReceipt;
		public event RsUniBillPurchaseCompleteDelegate OnPurchaseComplete_NoReceipt;
		public event RsUniBillPurchaseDelegate_Items OnPurchaseCancelled;
		public event RsUniBillPurchaseDelegate_State OnTransactionsRestored;

		public override void Awake()
		{
			base.Awake();
			InitializeIAP();
		}

		private void InitializeIAP()
		{
			var builder = ConfigurationBuilder.Instance(StandardPurchasingModule.Instance());
			builder.AddProduct("your_product_id", ProductType.Consumable);
			UnityPurchasing.Initialize(this, builder);
		}

		public IEnumerator Initialize()
		{
			Logging.Log("RsUniBillInterface:: Initialization started...");
			while (!SetupNetworking.IsReady)
			{
				yield return new WaitForEndOfFrame();
			}
			m_InitializationComplete = true;
			Logging.Log("RsUniBillInterface:: ...Initialization complete.");
		}

		public bool AbleToProcessPurchases()
		{
			return m_InitializationComplete;
		}

		public void RestorePurchasedItems()
		{
			if (AbleToProcessPurchases())
			{
				// dont restore purchases cuz there is none anymore
			}
		}

		public void ConductPurchase(string purchaseID)
		{
			if (AbleToProcessPurchases())
			{
				m_StoreController.InitiatePurchase(purchaseID);
			}
		}

		public int GetPurchaseCount(string purchaseID)
		{
			var product = m_StoreController.products.WithID(purchaseID);
			return product != null ? product.availableToPurchase ? 1 : 0 : 0;
		}

		public bool HasItemBeenPurchased(string purchaseID)
		{
			return GetPurchaseCount(purchaseID) > 0;
		}

		public string GetLocalizedPriceString(string purchaseID)
		{
			var product = m_StoreController.products.WithID(purchaseID);
			return product != null ? product.metadata.localizedPriceString : string.Empty;
		}

		// IStoreListener methods - Implementing required methods with empty functionality
		public void OnInitializeFailed(InitializationFailureReason error)
		{
			Debug.LogError("IStoreListener:: OnInitializeFailed called with error: " + error.ToString());
		}

		public void OnInitializeFailed(InitializationFailureReason error, string message)
		{
			Debug.LogError("IStoreListener:: OnInitializeFailed called with error: " + error.ToString() + " and message: " + message);
		}

		public void OnPurchaseFailed(Product product, PurchaseFailureReason failureReason)
		{
			Debug.LogError($"Purchase failed for product {product.definition.id}. Reason: {failureReason.ToString()}");
		}

		public PurchaseProcessingResult ProcessPurchase(PurchaseEventArgs args)
		{
			// Process the purchase and return the result
			if (args.purchasedProduct.definition.id == "your_product_id")
			{
				Debug.Log($"Purchase successful: {args.purchasedProduct.definition.id}");
				OnPurchaseComplete_WithReceipt?.Invoke("userId", args.purchasedProduct.definition.id, args.purchasedProduct.receipt);
				return PurchaseProcessingResult.Complete; // Indicate that the purchase was processed successfully
			}

			// If the purchase is not recognized, return a failed result
			return PurchaseProcessingResult.Pending;
		}

		public void OnInitialized(IStoreController controller, IExtensionProvider extensions)
		{
			m_StoreController = controller;
			m_StoreExtensionProvider = extensions;
			Debug.Log("Unity IAP Initialized successfully!");
		}
	}
}
