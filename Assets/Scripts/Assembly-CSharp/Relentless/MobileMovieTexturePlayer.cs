using System;
using Fabric;
using Furby;
using MMT;
using UnityEngine;

namespace Relentless
{
	public class MobileMovieTexturePlayer : VideoPlayer
	{
		[SerializeField]
		private MobileMovieTexture m_player;

		[SerializeField]
		private GameObject m_displayObject;

		private string m_fabricEvent;

		private void Start()
		{
			GameEventRouter.AddDelegateForEnums(OnRequestStop, VideoPlayerGameEvents.RequestVideoStop);
			base.gameObject.SetLayerInChildren(base.gameObject.layer);
			DisableInputOnLayer[] componentsInChildren = GetComponentsInChildren<DisableInputOnLayer>(true);
			DisableInputOnLayer[] array = componentsInChildren;
			foreach (DisableInputOnLayer disableInputOnLayer in array)
			{
				disableInputOnLayer.ExcludeLayer(base.gameObject.layer);
			}
		}

		private void OnDestroy()
		{
			GameEventRouter.RemoveDelegateForEnums(OnRequestStop, VideoPlayerGameEvents.RequestVideoStop);
		}

		private void OnRequestStop(Enum eventSent, GameObject go, params object[] objectParams)
		{
			StopVideo();
		}

		public override void PlayVideo(string videoPath, string fabricEvent)
		{
			// Simulate immediate "play" and "finish"
			m_displayObject.SetActive(true); // Pretend to show video
			m_fabricEvent = fabricEvent;

			GameEventRouter.SendEvent(VideoPlayerGameEvents.VideoHasStarted);

			if (!string.IsNullOrEmpty(m_fabricEvent))
			{
				EventManager.Instance.PostEvent(m_fabricEvent, EventAction.PlaySound);
			}

			// Simulate a short delay (you can remove this if instant is fine)
			Invoke(nameof(FinishFakeVideo), 0.5f); // Finish after 0.5 sec
		}

		private void FinishFakeVideo()
		{
			StopVideo();
		}
// h

		private void VideoFinishedPlaying(MobileMovieTexture sender)
		{
			StopVideo();
		}

		public override void StopVideo()
		{
			if (m_player.isPlaying)
			{
				m_player.Stop();
			}
			if (!string.IsNullOrEmpty(m_fabricEvent))
			{
				EventManager.Instance.PostEvent(m_fabricEvent, EventAction.StopSound);
			}
			m_player.onFinished -= VideoFinishedPlaying;
			GameEventRouter.SendEvent(VideoPlayerGameEvents.VideoHasFinished);
			m_displayObject.SetActive(false);
		}

		public bool IsVideoPlaying()
		{
			if (m_player == null)
			{
				return false;
			}
			return m_player.isPlaying;
		}

		public static bool AnyVideosPlaying()
		{
			MobileMovieTexturePlayer[] array = GameObjectExtensions.FindObjectsOfType<MobileMovieTexturePlayer>();
			foreach (MobileMovieTexturePlayer mobileMovieTexturePlayer in array)
			{
				if (mobileMovieTexturePlayer.IsVideoPlaying())
				{
					return true;
				}
			}
			return false;
		}

		public static void StopAllVideos()
		{
			MobileMovieTexturePlayer[] array = GameObjectExtensions.FindObjectsOfType<MobileMovieTexturePlayer>();
			foreach (MobileMovieTexturePlayer mobileMovieTexturePlayer in array)
			{
				if (mobileMovieTexturePlayer.IsVideoPlaying())
				{
					mobileMovieTexturePlayer.StopVideo();
				}
			}
		}
	}
}
