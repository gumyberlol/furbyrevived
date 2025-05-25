using System;
using System.Collections;
using System.Linq;
using Fabric;
using Furby;
using Relentless;
using UnityEngine;

public class HardwareSettingsScreenFlow : MonoBehaviour
{
	private const float POLL_WAIT_TIME_SECONDS = 1f;

	private static AndroidJavaClass s_HardwareSettingsJava;

	[SerializeField]
	private HardwareVolumeMeter m_HardwareVolumeMeter;

	[SerializeField]
	private UISlider m_HardwareVolumeSlider;

	[SerializeField]
	private VolumeSlider m_InGameVolumeSlider;

	private float m_InitialHardwareVolume = 1f;

	[SerializeField]
	private float m_HardwareVolumeTolerance = 0.99f;

	[SerializeField]
	private GameObject m_HeadphonesInPanel;

	[SerializeField]
	private GameObject m_VolumeMeterPanel;

	[SerializeField]
	private float m_PanelScaleTime = 0.5f;

	private readonly Vector3 MIN_PANEL_SCALE_VECTOR = new Vector3(0.01f, 0.01f, 0.01f);

	private readonly Vector3 MAX_PANEL_SCALE_VECTOR = new Vector3(1f, 1f, 1f);

	private UICamera[] m_DisabledCameras;

	private static float s_FakeHardwareVolume = 1f;

	private static bool s_FakeHeadphonesIn;

	private bool m_IsTemporarilyDisabled;

	private GameEventSubscription m_DebugPanelSub;

	private bool m_FakeHardwareTriggered;

	public void Disable()
	{
		m_IsTemporarilyDisabled = true;
	}

	public void Enable()
	{
		m_IsTemporarilyDisabled = false;
	}

	private void OnEnable()
	{
		m_DebugPanelSub = new GameEventSubscription(OnDebugPanelGUI, DebugPanelEvent.DrawElementRequested);
	}

	private void OnDestroy()
	{
		m_DebugPanelSub.Dispose();
	}

	private void OnDebugPanelGUI(Enum evtType, GameObject gObj, params object[] parameters)
	{
		if (DebugPanel.StartSection("Hardware Setting Popups"))
		{
			if (m_FakeHardwareTriggered)
			{
				GUILayout.Label("Close the debug menu!");
			}
			else
			{
				GUILayout.Label("Note: Triggered after 2 secs, giving you time to CLOSE the debug panel!");
				if (GUILayout.Button("Simulate Volume Change"))
				{
					m_FakeHardwareTriggered = true;
					Invoke("ActivateFakeVolumeTrigger", 3f);
				}
				if (GUILayout.Button("Simulate Headphones"))
				{
					m_FakeHardwareTriggered = true;
					Invoke("ActivateFakeHeadphones", 3f);
				}
			}
		}
		DebugPanel.EndSection();
	}

	private void ActivateFakeVolumeTrigger()
	{
		s_FakeHardwareVolume = 0.5f;
		m_FakeHardwareTriggered = false;
	}

	private void ActivateFakeHeadphones()
	{
		s_FakeHeadphonesIn = true;
		m_FakeHardwareTriggered = false;
	}

	private float GetHardwareVolume()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			return s_HardwareSettingsJava.CallStatic<float>("_getHardwareVolume", new object[0]);
		}
		return s_FakeHardwareVolume;
	}

	private void SetHardwareVolume(float volume)
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			s_HardwareSettingsJava.CallStatic("_setHardwareVolume", volume);
		}
		else
		{
			s_FakeHardwareVolume = volume;
		}
	}

	private bool AreHeadphonesPluggedIn()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			return s_HardwareSettingsJava.CallStatic<bool>("_areHeadphonesPluggedIn", new object[0]);
		}
		return s_FakeHeadphonesIn;
	}

	private void HidePanelImmediately(GameObject panel)
	{
		panel.transform.localScale = MIN_PANEL_SCALE_VECTOR;
		panel.SetActive(false);
	}

	private void ShowPanelImmediately(GameObject panel)
	{
		panel.SetActive(true);
		panel.transform.localScale = MAX_PANEL_SCALE_VECTOR;
	}

	private void Start()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			s_HardwareSettingsJava = new AndroidJavaClass("generalplus.com.GPLib.HardwareSettings");
			using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer"))
			{
				AndroidJavaObject androidJavaObject = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
				s_HardwareSettingsJava.CallStatic("_setActivity", androidJavaObject);
			}
		}
		m_InitialHardwareVolume = GetHardwareVolume();
		SetIsControllingGlobalInGameVolume(true);
		HidePanelImmediately(m_HeadphonesInPanel);
		HidePanelImmediately(m_VolumeMeterPanel);
		StartCoroutine(PollHeadphoneStatus());
		StartCoroutine(PollHardwareVolume());
		StartCoroutine(WaitForUnacceptableHardwareStatus());
	}

	public void SetIsControllingGlobalInGameVolume(bool isControllingGlobalVolume)
	{
		m_InGameVolumeSlider.SetIsControllingGlobalInGameVolume(isControllingGlobalVolume);
	}

	private IEnumerator PollHeadphoneStatus()
	{
		bool sentHeadphonesPluggedIn = false;
		bool sentHeadphonesNOTPluggedIn = false;
		while (true)
		{
			bool areHeadphonesPluggedIn = AreHeadphonesPluggedIn();
			if (areHeadphonesPluggedIn && !sentHeadphonesPluggedIn)
			{
				GameEventRouter.SendEvent(HardwareSettingsEvents.HeadphonesArePluggedIn);
			}
			else if (!areHeadphonesPluggedIn && !sentHeadphonesNOTPluggedIn)
			{
				GameEventRouter.SendEvent(HardwareSettingsEvents.HeadphonesAreNOTPluggedIn);
			}
			float waitTime = 1f;
			float lastTime = Time.realtimeSinceStartup;
			while (waitTime >= 0f)
			{
				yield return null;
				float newTime = Time.realtimeSinceStartup;
				float deltaTime = newTime - lastTime;
				lastTime = newTime;
				waitTime -= deltaTime;
			}
		}
	}

	private IEnumerator PollHardwareVolume()
	{
		bool sentHardwareVolumeIsTooLow = false;
		bool sentHardwareVolumeIsOK = false;
		while (true)
		{
			float hardwareVolume = GetHardwareVolume();
			if (hardwareVolume < m_HardwareVolumeTolerance && !sentHardwareVolumeIsTooLow)
			{
				GameEventRouter.SendEvent(HardwareSettingsEvents.HardwareVolumeIsTooLow);
			}
			else if (hardwareVolume >= m_HardwareVolumeTolerance && !sentHardwareVolumeIsOK)
			{
				GameEventRouter.SendEvent(HardwareSettingsEvents.HardwareVolumeIsOK);
			}
			float waitTime = 1f;
			float lastTime = Time.realtimeSinceStartup;
			while (waitTime >= 0f)
			{
				yield return null;
				float newTime = Time.realtimeSinceStartup;
				float deltaTime = newTime - lastTime;
				lastTime = newTime;
				waitTime -= deltaTime;
			}
		}
	}

	private void PauseGame()
	{
		Time.timeScale = 0f;
		EventManager.Instance.PostEvent("pause", EventAction.PauseSound);
		m_DisabledCameras = (from camera in Camera.allCameras
			where camera.gameObject.layer != base.gameObject.layer
			let uicamera = camera.GetComponent<UICamera>()
			where uicamera != null
			where uicamera.enabled
			select uicamera).ToArray();
		if (m_DisabledCameras == null)
		{
			return;
		}
		UICamera[] disabledCameras = m_DisabledCameras;
		foreach (UICamera uICamera in disabledCameras)
		{
			if (uICamera != null)
			{
				uICamera.enabled = false;
			}
		}
	}

	private void UnpauseGame()
	{
		if (m_DisabledCameras != null)
		{
			UICamera[] disabledCameras = m_DisabledCameras;
			foreach (UICamera uICamera in disabledCameras)
			{
				if (uICamera != null)
				{
					uICamera.enabled = true;
				}
			}
		}
		Time.timeScale = 1f;
		EventManager.Instance.PostEvent("pause", EventAction.UnpauseSound);
	}

	private bool GameIsAlreadyPaused()
	{
		return Time.timeScale > 0f;
	}

	private bool GameIsLoading()
	{
		return Application.isLoadingLevel || AssetBundleHelpers.IsLoading();
	}

	private IEnumerator WaitForUnacceptableHardwareStatus()
	{
		WaitForGameEvent waiter = new WaitForGameEvent();
		yield return StartCoroutine(waiter.WaitForEvent(HardwareSettingsEvents.HeadphonesArePluggedIn, HardwareSettingsEvents.HardwareVolumeIsTooLow));
		if (!GameIsAlreadyPaused() || GameIsLoading() || m_IsTemporarilyDisabled || MobileMovieTexturePlayer.AnyVideosPlaying())
		{
			StartCoroutine(WaitForUnacceptableHardwareStatus());
			yield break;
		}
		PauseGame();
		switch ((HardwareSettingsEvents)(object)waiter.ReturnedEvent)
		{
		case HardwareSettingsEvents.HeadphonesArePluggedIn:
			StartCoroutine(WaitForAcceptableHeadphoneStatus());
			break;
		case HardwareSettingsEvents.HardwareVolumeIsTooLow:
			StartCoroutine(WaitForAcceptableHardwareVolume());
			break;
		}
	}

	private IEnumerator WaitForAcceptableHeadphoneStatus()
	{
		GameEventRouter.SendEvent(HardwareSettingsEvents.ShowHeadphonesDialog);
		ShowPanelImmediately(m_HeadphonesInPanel);
		WaitForGameEvent waiter = new WaitForGameEvent();
		yield return StartCoroutine(waiter.WaitForEvent(HardwareSettingsEvents.HeadphonesAreNOTPluggedIn));
		GameEventRouter.SendEvent(HardwareSettingsEvents.HideHeadphonesDialog);
		HidePanelImmediately(m_HeadphonesInPanel);
		UnpauseGame();
		StartCoroutine(WaitForUnacceptableHardwareStatus());
	}

	private IEnumerator WaitForAcceptableHardwareVolume()
	{
		GameEventRouter.SendEvent(HardwareSettingsEvents.ShowTheVolumeMeters);
		ShowPanelImmediately(m_VolumeMeterPanel);
		m_HardwareVolumeMeter.SetShouldPoll(true);
		m_InGameVolumeSlider.SyncSliderValueToSavedValue();
		WaitForGameEvent waiter = new WaitForGameEvent();
		yield return StartCoroutine(waiter.WaitForEvent(HardwareSettingsEvents.HardwareVolumeIsOK, HardwareSettingsEvents.HeadphonesArePluggedIn));
		GameEventRouter.SendEvent(HardwareSettingsEvents.HideTheVolumeMeters);
		HidePanelImmediately(m_VolumeMeterPanel);
		m_VolumeMeterPanel.SetActive(false);
		VolumeSlider[] volumeSliders = UnityEngine.Object.FindObjectsOfType(typeof(VolumeSlider)) as VolumeSlider[];
		VolumeSlider[] array = volumeSliders;
		foreach (VolumeSlider volumeSlider in array)
		{
			if (volumeSlider != null)
			{
				volumeSlider.SyncSliderValueToSavedValue();
			}
		}
		switch ((HardwareSettingsEvents)(object)waiter.ReturnedEvent)
		{
		case HardwareSettingsEvents.HeadphonesArePluggedIn:
			StartCoroutine(WaitForAcceptableHeadphoneStatus());
			break;
		case HardwareSettingsEvents.HardwareVolumeIsOK:
			UnpauseGame();
			StartCoroutine(WaitForUnacceptableHardwareStatus());
			break;
		}
	}

	public void UpdateMeterFromHardwareVolume()
	{
		float hardwareVolume = GetHardwareVolume();
		if (hardwareVolume != m_HardwareVolumeSlider.sliderValue)
		{
			m_HardwareVolumeSlider.sliderValue = hardwareVolume;
		}
	}

	public void UpdateHardwareVolumeFromMeter()
	{
		float hardwareVolume = GetHardwareVolume();
		if (hardwareVolume != m_HardwareVolumeSlider.sliderValue)
		{
			SetHardwareVolume(m_HardwareVolumeSlider.sliderValue);
		}
	}
}
