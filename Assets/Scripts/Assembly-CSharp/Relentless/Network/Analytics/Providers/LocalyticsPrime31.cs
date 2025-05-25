using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Relentless.Network.Analytics.Providers
{
	public class LocalyticsPrime31 : TelemetryProviderBase
	{
		[SerializeField]
		private string m_developmentApiKey;

		[SerializeField]
		private string m_productionApiKey;

		protected override string ProviderName
		{
			get
			{
				return "LocalyticsPrime31";
			}
		}

		public override void Awake()
		{
			base.ShouldPumpQueueOnCoroutine = true;
			base.Awake();
			Logging.Log(string.Format("LocalyticsPrime31:Awake ProviderType = {0}, ApiKey= {1}", ToString(), m_productionApiKey));
		}

		public override void StartSession()
		{
			#if UNITY_ANDROID
			// hh
			#else
			// Localytics not supported on PC, do nothing or add PC equivalent here
			#endif
		}

		public override void EndSession()
		{
			#if UNITY_ANDROID
			// hh
			#else
			// Localytics not supported on PC, do nothing or add PC equivalent here
			#endif
		}

		public override void TagScreen(string screenName)
		{
			#if UNITY_ANDROID
			// hi
			#else
			// Localytics not supported on PC, do nothing or add PC equivalent here
			#endif
		}

		protected override bool ReallyLogEventToServer(QueuedTelemetryEvent telemetryEvent)
		{
			#if UNITY_ANDROID
			// last this localytics android thing
			Logging.Log(telemetryEvent.Params.Select((KeyValuePair<string, string> x) => string.Format("{0} = {1}", x.Key, x.Value))
			.Aggregate(string.Format("Localytics (Android) tagged event {0}", telemetryEvent.Event), (string x, string y) => x + "\n" + y));
			return true;
			#else
			// Just log locally for PC or skip analytics
			Logging.Log($"Localytics (PC) would tag event {telemetryEvent.Event}");
			return false;
			#endif
		}
	}
}
