using System.Collections;
using UnityEngine;

public class HardwareVolumeMeter : MonoBehaviour
{
	[SerializeField]
	private HardwareSettingsScreenFlow m_HardwareSettingsScreenFlow;

	private bool m_IsPressed;

	private IEnumerator PollToUpdateMeter()
	{
		while (true)
		{
			if (m_IsPressed)
			{
				m_HardwareSettingsScreenFlow.UpdateHardwareVolumeFromMeter();
			}
			else
			{
				m_HardwareSettingsScreenFlow.UpdateMeterFromHardwareVolume();
			}
			yield return null;
		}
	}

	public void SetShouldPoll(bool shouldPoll)
	{
		StopAllCoroutines();
		if (shouldPoll)
		{
			m_IsPressed = false;
			StartCoroutine(PollToUpdateMeter());
		}
	}

	private void OnPress(bool pressed)
	{
		m_IsPressed = pressed;
		if (!pressed)
		{
			m_HardwareSettingsScreenFlow.UpdateHardwareVolumeFromMeter();
		}
	}
}
