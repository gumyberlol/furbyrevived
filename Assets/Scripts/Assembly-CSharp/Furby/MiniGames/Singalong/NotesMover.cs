using Relentless;
using UnityEngine;

namespace Furby.MiniGames.Singalong
{
	public class NotesMover : MonoBehaviour
	{
		private MusicGameSongData.NoteInfo m_songNote;

		[SerializeField]
		private float m_hitTime;

		private bool m_isValid = true;

		private float m_timeUntilCorrection;

		public void Setup(MusicGameSongData.NoteInfo songNote, float currentTime)
		{
			m_songNote = songNote;
			base.GetComponent<Animation>()[base.GetComponent<Animation>().clip.name].time = Mathf.Max(m_hitTime + (currentTime - m_songNote.GetTimeAfterStart()), 0f);
			m_isValid = true;
		}

		public MusicGameSongData.NoteInfo GetNote()
		{
			return m_songNote;
		}

		private void Start()
		{
			base.GetComponent<Animation>().Play();
			base.GetComponent<Animation>()[base.GetComponent<Animation>().clip.name].wrapMode = WrapMode.Once;
		}

		public void UpdateNote(float currentTime, float hitWindow)
		{
			if (currentTime > 0f)
			{
				m_timeUntilCorrection -= Time.deltaTime;
				float num = Mathf.Max(m_hitTime + (currentTime - m_songNote.GetTimeAfterStart()), 0f);
				if (m_timeUntilCorrection < 0f)
				{
					m_timeUntilCorrection = 0.05f;
					float num2 = (num + base.GetComponent<Animation>()[base.GetComponent<Animation>().clip.name].time) / 2f;
					if (num2 >= base.GetComponent<Animation>()[base.GetComponent<Animation>().clip.name].time - 1f)
					{
						base.GetComponent<Animation>()[base.GetComponent<Animation>().clip.name].time = num2;
					}
					base.GetComponent<Animation>().Play();
				}
				if (m_isValid && currentTime - m_songNote.GetTimeAfterStart() > hitWindow)
				{
					m_isValid = false;
					GameEventRouter.SendEvent(MusicGameEvent.NoteMissed, null, 0f - hitWindow);
					GameEventRouter.SendEvent(MusicGameEvent.NoteMissedExpired, null, 0f - hitWindow);
				}
				if (num >= base.GetComponent<Animation>()[base.GetComponent<Animation>().clip.name].length)
				{
					Object.Destroy(base.gameObject);
				}
			}
			else
			{
				Object.Destroy(base.gameObject);
			}
		}
	}
}
