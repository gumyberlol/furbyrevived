using System.Collections.Generic;
using Relentless;
using UnityEngine;

namespace Furby
{
	public class VideoEventToVideoFile : RelentlessMonoBehaviour
	{
		public Dictionary<TutorialVideoEvents, string> m_Dictionary = new Dictionary<TutorialVideoEvents, string>();

		public Dictionary<TutorialVideoEvents, string> Dictionary
		{
			get { return m_Dictionary; }
		}

		private void Start()
		{
			PopulateDictionary();
		}

		private void PopulateDictionary()
		{
			string basePath = System.IO.Path.Combine(Application.streamingAssetsPath, "Video");

			m_Dictionary.Clear();
			m_Dictionary.Add(TutorialVideoEvents.BlenderVideo, System.IO.Path.Combine(basePath, "Video_Blender.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.FurballVideo, System.IO.Path.Combine(basePath, "Video_Furball.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.HideAndSeekVideo, System.IO.Path.Combine(basePath, "Video_HideAndSeek.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.HoseVideo, System.IO.Path.Combine(basePath, "Video_Hose.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.HatchingVideo, System.IO.Path.Combine(basePath, "Video_Incubator.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.WinningTheGameVideo, System.IO.Path.Combine(basePath, "Video_Intro.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.PantryVideo, System.IO.Path.Combine(basePath, "Video_Pantry.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.PlayroomDecoratingVideo, System.IO.Path.Combine(basePath, "Video_PlayroomCustomisation.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.PlayroomInteraction, System.IO.Path.Combine(basePath, "Video_PlayroomInteraction.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.PoopStationVideo, System.IO.Path.Combine(basePath, "Video_PoopStation.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.SpaVideo, System.IO.Path.Combine(basePath, "Video_Salon.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.SickbayVideo, System.IO.Path.Combine(basePath, "Video_Sickbay.ogg"));
			m_Dictionary.Add(TutorialVideoEvents.SingAlongVideo, System.IO.Path.Combine(basePath, "Video_Singalong.ogg"));
		}

		public string GetVideoName(TutorialVideoEvents evt)
		{
			if (Dictionary.TryGetValue(evt, out string value))
			{
				return value;
			}
			return string.Empty;
		}
	}
}
