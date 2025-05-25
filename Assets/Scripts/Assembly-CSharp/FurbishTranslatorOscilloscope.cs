using UnityEngine;

public class FurbishTranslatorOscilloscope : MonoBehaviour
{
	public enum MicrophoneMode
	{
		DisableComAirAndAccessMicrophoneDirectly = 0,
		WorkWithComAirViaIOSSpecificPlugin = 1
	}

	public LineRenderer m_lineRenderer;

	private int m_numSamples = 128;
	private float[] m_samples;
	private int m_micPosition;
	public int m_numLineRendererPositions = 32;
	public float m_volumeMultiplier = 40f;
	private AudioClip m_audioClip;
	private float m_volume = 1f;
	private float m_smoothVolume;
	private float m_currentVolume;
	private float m_currentVolumeVelocity;
	public float m_volumeSmoothTime = 0.25f;
	public AnimationCurve m_waveCurve;
	private float m_maxHeight;
	private float m_widthInterval;

	public Transform m_startPosTransform;
	public Transform m_endPosTransform;
	public Transform m_maxHeightTransform;

	private int m_FrequencyMinimum;
	private int m_FrequencyMaximum;

	public string m_CachedDeviceName = string.Empty;

	public MicrophoneMode m_MicrophoneMode = MicrophoneMode.DisableComAirAndAccessMicrophoneDirectly; // ← Default mode changed to avoid errors

	private void Start()
	{
		InitializeMicrophoneSampler();
		InitializeMicrophoneListener();
	}

	private void OnDestroy()
	{
		// Removed MicrophoneMeter.Shutdown();
	}

	private void InitializeMicrophoneListener()
	{
		if (m_MicrophoneMode == MicrophoneMode.DisableComAirAndAccessMicrophoneDirectly)
		{
			StartRecordingMicrophoneClip();
		}
		else
		{
			Debug.LogWarning("MicrophoneMeter plugin missing! Defaulting to Unity mic.");
			m_MicrophoneMode = MicrophoneMode.DisableComAirAndAccessMicrophoneDirectly;
			StartRecordingMicrophoneClip();
		}
	}

	private void Update()
	{
		if (m_MicrophoneMode == MicrophoneMode.DisableComAirAndAccessMicrophoneDirectly)
		{
			if (Microphone.IsRecording(m_CachedDeviceName))
			{
				m_volume = GetRawVolume();
			}
			else
			{
				StartRecordingMicrophoneClip();
				m_volume = 0f;
			}
		}
		UpdateOscilloscope();
	}

	private void StartRecordingMicrophoneClip()
	{
		Microphone.GetDeviceCaps(null, out m_FrequencyMinimum, out m_FrequencyMaximum);
		if (m_FrequencyMinimum == 0 && m_FrequencyMaximum == 0)
			m_FrequencyMaximum = 44100;

		m_audioClip = Microphone.Start(null, true, 1, m_FrequencyMaximum);
	}

	private void InitializeMicrophoneSampler()
	{
		m_samples = new float[m_numSamples];
		m_widthInterval = Vector3.Distance(m_startPosTransform.localPosition, m_endPosTransform.localPosition) / (float)m_numLineRendererPositions;
		m_maxHeight = Mathf.Abs(m_maxHeightTransform.localPosition.y);
	}

	private float GetRawVolume()
	{
		if (m_audioClip != null)
		{
			m_micPosition = Microphone.GetPosition(m_CachedDeviceName);
			if (m_micPosition >= 0)
			{
				m_audioClip.GetData(m_samples, Mathf.Clamp(m_micPosition - m_samples.Length, 0, 44100));
				float max = 0f;
				for (int i = 0; i < m_numSamples; i++)
				{
					if (m_samples[i] > max)
						max = m_samples[i];
				}
				m_volume = Mathf.Clamp(max * m_volumeMultiplier, 0f, 1f);
			}
		}
		else
		{
			m_volume = 0f;
		}
		return m_volume;
	}

	private void UpdateOscilloscope()
	{
		SmoothAndDampenVolume();
		SetLineRendererPositions();
	}

	private void SmoothAndDampenVolume()
	{
		m_smoothVolume = Mathf.SmoothDamp(m_currentVolume, m_volume, ref m_currentVolumeVelocity, m_volumeSmoothTime);
		m_currentVolume = m_smoothVolume;
	}

	private void SetLineRendererPositions()
	{
		for (int i = 0; i < m_numLineRendererPositions; i++)
		{
			float x = (-m_widthInterval) * (m_numLineRendererPositions / 2f) + (m_widthInterval * i);
			float y = Random.Range(-m_maxHeight, m_maxHeight) * m_smoothVolume * m_waveCurve.Evaluate((float)i / m_numLineRendererPositions);
			m_lineRenderer.SetPosition(i, new Vector3(x, y, 0f));
		}
	}
}
