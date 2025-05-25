using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Relentless
{
	public static class AssetBundleHelpers
	{
		public class AssetBundleLoad
		{
			public bool isLoaded;

			public UnityEngine.Object m_object;
		}

		private class ConcurrentlyLoadedAssetBundle
		{
			public AssetBundle bundle;

			public List<GameObject> users = new List<GameObject>();
		}

		private static Dictionary<string, ConcurrentlyLoadedAssetBundle> m_concurrentlyLoadedAssetBundles = new Dictionary<string, ConcurrentlyLoadedAssetBundle>();

		public static string GetStreamingAssetsPath()
		{
			string text;
			switch (Application.platform)
			{
			case RuntimePlatform.IPhonePlayer:
				text = "/Generated/iPhone/";
				break;
			case RuntimePlatform.Android:
				text = "/Generated/Android/";
				break;
			case RuntimePlatform.WindowsPlayer:
			case RuntimePlatform.WindowsEditor:
				text = "/Generated/StandaloneWindows/";
				break;
			case RuntimePlatform.OSXEditor:
			case RuntimePlatform.OSXPlayer:
				text = "/Generated/StandaloneWindows/";
				break;
			default:
				text = "/Generated/WebPlayer/";
				break;
			}
			return Application.streamingAssetsPath + text;
		}

		public static bool IsLoading()
		{
			return m_concurrentlyLoadedAssetBundles.Count != 0;
		}

		public static string LowerCaseAfterFinalSlash(string inputString)
		{
			int num = inputString.LastIndexOf("/");
			if (num >= 0)
			{
				return inputString.Substring(0, num) + inputString.Substring(num).ToLower();
			}
			return inputString.ToLower();
		}

		public static IEnumerator Load(string path, bool compressed, AssetBundleLoad prefabResult, GameObject activeObject, Type expectedType, bool forceLowerCase)
		{
			if (path.Contains(" "))
			{
				Logging.LogError("Trying to load asset bundle with a space in its path - this will not work on iPhone/iPad");
			}
			ConcurrentlyLoadedAssetBundle loadedAssetBundle = null;
			bool shouldLoadNew = true;
			if (m_concurrentlyLoadedAssetBundles.TryGetValue(path, out loadedAssetBundle))
			{
				while (loadedAssetBundle.users.Contains(null))
				{
					loadedAssetBundle.users.Remove(null);
				}
				if (loadedAssetBundle.bundle == null)
				{
					if (loadedAssetBundle.users.Count == 0)
					{
						shouldLoadNew = true;
					}
					else
					{
						shouldLoadNew = false;
						while (loadedAssetBundle.bundle == null)
						{
							yield return null;
						}
					}
				}
				else
				{
					shouldLoadNew = false;
				}
			}
			if (shouldLoadNew)
			{
				string streamingPath = GetStreamingAssetsPath();
				if (loadedAssetBundle == null)
				{
					loadedAssetBundle = new ConcurrentlyLoadedAssetBundle();
				}
				loadedAssetBundle.users.Add(activeObject);
				if (!m_concurrentlyLoadedAssetBundles.ContainsKey(path))
				{
					m_concurrentlyLoadedAssetBundles.Add(path, loadedAssetBundle);
				}
				bool containsFileColonSlashSlash = streamingPath.Contains("://");
				if (compressed || containsFileColonSlashSlash)
				{
					string assetPath = streamingPath + path + ".unity3d";
					if (!containsFileColonSlashSlash)
					{
						assetPath = "file://" + assetPath;
					}
					if (forceLowerCase)
					{
						assetPath = LowerCaseAfterFinalSlash(assetPath);
					}
					Logging.Log("Loading Asset bundle via WWW from : " + assetPath);
					using (WWW compressedLoader = new WWW(assetPath))
					{
						yield return compressedLoader;
						loadedAssetBundle.bundle = compressedLoader.assetBundle;
					}
				}
				else
				{
					string assetPath2 = streamingPath + path + ".unity3d";
					Logging.Log("Loading Asset bundle via WWW from : " + assetPath2);
					if (forceLowerCase)
					{
						assetPath2 = LowerCaseAfterFinalSlash(assetPath2);
					}
					loadedAssetBundle.bundle = AssetBundle.LoadFromFile(assetPath2);
				}
			}
			else
			{
				loadedAssetBundle.users.Add(activeObject);
			}
			Logging.Log("Loaded asset bundle: " + path);
			AssetBundleRequest request = loadedAssetBundle.bundle.LoadAssetAsync(loadedAssetBundle.bundle.mainAsset.name, expectedType);
			yield return request;
			prefabResult.m_object = request.asset;
			prefabResult.isLoaded = true;
			while (loadedAssetBundle.users.Contains(null))
			{
				loadedAssetBundle.users.Remove(null);
			}
			loadedAssetBundle.users.Remove(activeObject);
			if (loadedAssetBundle.users.Count == 0)
			{
				loadedAssetBundle.bundle.Unload(false);
				m_concurrentlyLoadedAssetBundles.Remove(path);
			}
		}
	}
}
