using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace MMT
{
	public class MobileMovieTexture : MonoBehaviour
	{
		public delegate void OnFinished(MobileMovieTexture sender);

		private const int CHANNELS = 3;

		private const string PLATFORM_DLL = "theorawrapper";

		[SerializeField]
		private string m_path;

		[SerializeField]
		private bool m_absolutePath;

		[SerializeField]
		private Material[] m_movieMaterials;

		[SerializeField]
		private bool m_playAutomatically = true;

		[SerializeField]
		private bool m_advance = true;

		[SerializeField]
		private int m_loopCount = -1;

		[SerializeField]
		private float m_playSpeed = 1f;

		[SerializeField]
		private bool m_scanDuration = true;

		[SerializeField]
		private bool m_seekKeyFrame;

		private IntPtr m_nativeContext = IntPtr.Zero;

		private IntPtr m_nativeTextureContext = IntPtr.Zero;

		private int m_picWidth;

		private int m_picHeight;

		private int m_picX;

		private int m_picY;

		private int m_yStride;

		private int m_yHeight;

		private int m_uvStride;

		private int m_uvHeight;

		private Vector2 m_uvYScale;

		private Vector2 m_uvYOffset;

		private Vector2 m_uvCrCbScale;

		private Vector2 m_uvCrCbOffset;

		private Texture2D[] m_ChannelTextures = new Texture2D[3];

		private double m_elapsedTime;

		private bool m_hasFinished = true;

		public string Path
		{
			get
			{
				return m_path;
			}
			set
			{
				m_path = value;
			}
		}

		public bool AbsolutePath
		{
			get
			{
				return m_absolutePath;
			}
			set
			{
				m_absolutePath = value;
			}
		}

		public Material[] MovieMaterial
		{
			get
			{
				return m_movieMaterials;
			}
		}

		public bool PlayAutomatically
		{
			set
			{
				m_playAutomatically = value;
			}
		}

		public int LoopCount
		{
			get
			{
				return m_loopCount;
			}
			set
			{
				m_loopCount = value;
			}
		}

		public float PlaySpeed
		{
			get
			{
				return m_playSpeed;
			}
			set
			{
				m_playSpeed = value;
			}
		}

		public bool ScanDuration
		{
			get
			{
				return m_scanDuration;
			}
			set
			{
				m_scanDuration = value;
			}
		}

		public bool SeekKeyFrame
		{
			get
			{
				return m_seekKeyFrame;
			}
			set
			{
				m_seekKeyFrame = value;
			}
		}

		public int Width
		{
			get
			{
				return m_picWidth;
			}
		}

		public int Height
		{
			get
			{
				return m_picHeight;
			}
		}

		public float AspectRatio
		{
			get
			{
				if (m_nativeContext != IntPtr.Zero)
				{
					return GetAspectRatio(m_nativeContext);
				}
				return 1f;
			}
		}

		public double FPS
		{
			get
			{
				if (m_nativeContext != IntPtr.Zero)
				{
					return GetVideoFPS(m_nativeContext);
				}
				return 1.0;
			}
		}

		public bool isPlaying
		{
			get
			{
				return m_nativeContext != IntPtr.Zero && !m_hasFinished && m_advance;
			}
		}

		public bool pause
		{
			get
			{
				return !m_advance;
			}
			set
			{
				m_advance = !value;
			}
		}

		public double playPosition
		{
			get
			{
				return m_elapsedTime;
			}
			set
			{
				if (m_nativeContext != IntPtr.Zero)
				{
					m_elapsedTime = Seek(m_nativeContext, value, m_seekKeyFrame);
				}
			}
		}

		public double duration
		{
			get
			{
				return (!(m_nativeContext != IntPtr.Zero)) ? 0.0 : GetDuration(m_nativeContext);
			}
		}

		public event OnFinished onFinished;

		[DllImport("theorawrapper")]
		private static extern IntPtr CreateContext();

		[DllImport("theorawrapper")]
		private static extern void DestroyContext(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern bool OpenStream(IntPtr context, string path, int offset, int size, bool pot, bool scanDuration, int maxSkipFrames);

		[DllImport("theorawrapper")]
		private static extern void CloseStream(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern int GetPicWidth(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern int GetPicHeight(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern int GetPicX(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern int GetPicY(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern int GetYStride(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern int GetYHeight(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern int GetUVStride(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern int GetUVHeight(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern bool HasFinished(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern double GetDecodedFrameTime(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern double GetUploadedFrameTime(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern double GetTargetDecodeFrameTime(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern void SetTargetDisplayDecodeTime(IntPtr context, double targetTime);

		[DllImport("theorawrapper")]
		private static extern double GetVideoFPS(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern float GetAspectRatio(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern double Seek(IntPtr context, double seconds, bool waitKeyFrame);

		[DllImport("theorawrapper")]
		private static extern double GetDuration(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern IntPtr GetNativeYHandle(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern IntPtr GetNativeCrHandle(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern IntPtr GetNativeCbHandle(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern IntPtr GetNativeTextureContext(IntPtr context);

		[DllImport("theorawrapper")]
		private static extern void SetPostProcessingLevel(IntPtr context, int level);

		private void Awake()
		{
			m_nativeContext = CreateContext();
			if (m_nativeContext == IntPtr.Zero)
			{
				Debug.LogError("Unable to create Mobile Movie Texture native context");
			}
			else if (m_playAutomatically)
			{
				Play();
			}
		}

		private void OnDestroy()
		{
			DestroyTextures();
			DestroyContext(m_nativeContext);
		}

		private void Update()
		{
			if (!(m_nativeContext != IntPtr.Zero) || m_hasFinished)
			{
				return;
			}
			IntPtr nativeTextureContext = GetNativeTextureContext(m_nativeContext);
			if (nativeTextureContext != m_nativeTextureContext)
			{
				DestroyTextures();
				AllocateTexures();
				nativeTextureContext = m_nativeTextureContext;
			}
			m_hasFinished = HasFinished(m_nativeContext);
			if (!m_hasFinished)
			{
				if (m_advance)
				{
					m_elapsedTime += Time.deltaTime * Mathf.Max(m_playSpeed, 0f);
				}
			}
			else if (m_loopCount - 1 > 0 || m_loopCount == -1)
			{
				if (m_loopCount != -1)
				{
					m_loopCount--;
				}
				m_elapsedTime %= GetDecodedFrameTime(m_nativeContext);
				Seek(m_nativeContext, 0.0, false);
				m_hasFinished = false;
			}
			else if (this.onFinished != null)
			{
				m_elapsedTime = GetDecodedFrameTime(m_nativeContext);
				this.onFinished(this);
			}
			SetTargetDisplayDecodeTime(m_nativeContext, m_elapsedTime);
		}

		[ContextMenu("Play")]
		public void Play()
		{
			m_elapsedTime = 0.0;
			Open();
			m_hasFinished = false;
			if (MobileMovieManager.Instance == null)
			{
				base.gameObject.AddComponent<MobileMovieManager>();
			}
		}

		[ContextMenu("Stop")]
		public void Stop()
		{
			CloseStream(m_nativeContext);
			m_hasFinished = true;
		}

		private void Open()
		{
			string path = m_path;
			long offset = 0L;
			long length = 0L;
			if (!m_absolutePath)
			{
				RuntimePlatform platform = Application.platform;
				if (platform == RuntimePlatform.Android)
				{
					path = Application.dataPath;
					if (!AssetStream.GetZipFileOffsetLength(Application.dataPath, m_path, out offset, out length))
					{
						throw new Exception("problem opening movie #1");
					}
				}
				else
				{
					path = Application.streamingAssetsPath + "/" + m_path;
				}
			}
			if (m_nativeContext != IntPtr.Zero)
			{
				if (OpenStream(m_nativeContext, path, (int)offset, (int)length, false, m_scanDuration, 16))
				{
					m_picWidth = GetPicWidth(m_nativeContext);
					m_picHeight = GetPicHeight(m_nativeContext);
					m_picX = GetPicX(m_nativeContext);
					m_picY = GetPicY(m_nativeContext);
					int yStride = GetYStride(m_nativeContext);
					int yHeight = GetYHeight(m_nativeContext);
					int uVStride = GetUVStride(m_nativeContext);
					int uVHeight = GetUVHeight(m_nativeContext);
					m_yStride = yStride;
					m_yHeight = yHeight;
					m_uvStride = uVStride;
					m_uvHeight = uVHeight;
					CalculateUVScaleOffset();
					return;
				}
				throw new Exception("problem opening movie #2 - couldn't open stream");
			}
			throw new Exception("problem opening movie #3 - no context");
		}

		private void AllocateTexures()
		{
			m_ChannelTextures[0] = Texture2D.CreateExternalTexture(m_yStride, m_yHeight, TextureFormat.BGRA32, false, false, GetNativeYHandle(m_nativeContext));
			m_ChannelTextures[1] = Texture2D.CreateExternalTexture(m_uvStride, m_uvHeight, TextureFormat.RGBA32, false, false, GetNativeCrHandle(m_nativeContext));
			m_ChannelTextures[2] = Texture2D.CreateExternalTexture(m_uvStride, m_uvHeight, TextureFormat.RGBA32, false, false, GetNativeCbHandle(m_nativeContext));
			if (m_movieMaterials == null)
			{
				return;
			}
			for (int i = 0; i < m_movieMaterials.Length; i++)
			{
				Material material = m_movieMaterials[i];
				if (material != null)
				{
					SetTextures(material);
				}
			}
		}

		public void SetTextures(Material material)
		{
			material.SetTexture("_YTex", m_ChannelTextures[0]);
			material.SetTexture("_CrTex", m_ChannelTextures[1]);
			material.SetTexture("_CbTex", m_ChannelTextures[2]);
			material.SetTextureScale("_YTex", m_uvYScale);
			material.SetTextureOffset("_YTex", m_uvYOffset);
			material.SetTextureScale("_CbTex", m_uvCrCbScale);
			material.SetTextureOffset("_CbTex", m_uvCrCbOffset);
		}

		public void RemoveTextures(Material material)
		{
			material.SetTexture("_YTex", null);
			material.SetTexture("_CrTex", null);
			material.SetTexture("_CbTex", null);
		}

		private void CalculateUVScaleOffset()
		{
			m_uvYScale = new Vector2((float)m_picWidth / (float)m_yStride, 0f - (float)m_picHeight / (float)m_yHeight);
			m_uvYOffset = new Vector2((float)m_picX / (float)m_yStride, ((float)m_picHeight + (float)m_picY) / (float)m_yHeight);
			m_uvCrCbScale = default(Vector2);
			m_uvCrCbOffset = default(Vector2);
			if (m_uvStride == m_yStride)
			{
				m_uvCrCbScale.x = m_uvYScale.x;
			}
			else
			{
				m_uvCrCbScale.x = (float)m_picWidth / 2f / (float)m_uvStride;
			}
			if (m_uvHeight == m_yHeight)
			{
				m_uvCrCbScale.y = m_uvYScale.y;
				m_uvCrCbOffset = m_uvYOffset;
			}
			else
			{
				m_uvCrCbScale.y = 0f - (float)m_picHeight / 2f / (float)m_uvHeight;
				m_uvCrCbOffset = new Vector2((float)m_picX / 2f / (float)m_uvStride, ((float)m_picHeight + (float)m_picY) / 2f / (float)m_uvHeight);
			}
		}

		private void DestroyTextures()
		{
			if (m_movieMaterials != null)
			{
				for (int i = 0; i < m_movieMaterials.Length; i++)
				{
					Material material = m_movieMaterials[i];
					if (material != null)
					{
						RemoveTextures(material);
					}
				}
			}
			for (int j = 0; j < 3; j++)
			{
				if (m_ChannelTextures[j] != null)
				{
					UnityEngine.Object.Destroy(m_ChannelTextures[j]);
					m_ChannelTextures[j] = null;
				}
			}
		}
	}
}
