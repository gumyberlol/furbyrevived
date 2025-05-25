using UnityEngine;

namespace Furby
{
	public class FurbyGUISection : MonoBehaviour
	{
		private GameObject m_gameHUDScreen;

		private GameObject m_pauseButton;

		private GameObject m_furbucks;

		private GameObject m_backScreen;

		private GameObject m_endGame;

		private GameObject m_pauseMenuScreen;

		public static GameObject GameHUDScreen
		{
			get
			{
				return FurbyGlobals.Overlay.guiSection.m_gameHUDScreen;
			}
		}

		public static GameObject PauseButton
		{
			get
			{
				return FurbyGlobals.Overlay.guiSection.m_pauseButton;
			}
		}

		public static GameObject Furbucks
		{
			get
			{
				return FurbyGlobals.Overlay.guiSection.m_furbucks;
			}
		}

		public static GameObject BackScreen
		{
			get
			{
				return FurbyGlobals.Overlay.guiSection.m_backScreen;
			}
		}

		public static GameObject PauseMenuScreen
		{
			get
			{
				return FurbyGlobals.Overlay.guiSection.m_pauseMenuScreen;
			}
		}

		public static GameObject EndGameScreen
		{
			get
			{
				return FurbyGlobals.Overlay.guiSection.m_endGame;
			}
		}

		public void initGUI()
		{
			m_gameHUDScreen = base.transform.Find("GameHUDScreen").gameObject;
			m_pauseButton = base.transform.Find("PauseButtonScreen").gameObject;
			m_furbucks = base.transform.Find("FurbucksScreen").gameObject;
			m_backScreen = base.transform.Find("BackScreen").gameObject;
			m_pauseMenuScreen = base.transform.Find("PauseMenuScreen").gameObject;
			m_endGame = base.transform.Find("EndGameScreen").gameObject;
		}
	}
}
