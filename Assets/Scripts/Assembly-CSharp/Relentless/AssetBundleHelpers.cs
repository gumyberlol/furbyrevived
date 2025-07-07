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
			#if UNITY_EDITOR
			// In the Editor, load directly from Assets/AssetBundles/
			return Application.dataPath + "/AssetBundles/";
			#else
			// In build, load directly from StreamingAssets/
			return Application.streamingAssetsPath + "/";
			#endif
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
				Logging.LogError("❌ Trying to load asset bundle with a space in its path: " + path);
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
						Logging.Log("🔁 Waiting for asset bundle to load (shared use): " + path);
						while (loadedAssetBundle.bundle == null)
						{
							yield return null;
						}
					}
				}
				else
				{
					shouldLoadNew = false;
					Logging.Log("✅ Reusing already-loaded asset bundle: " + path);
				}
			}

			if (shouldLoadNew)
			{
				string streamingPath = GetStreamingAssetsPath();
				Logging.Log("📁 Streaming path: " + streamingPath);

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
				string assetPath = streamingPath + path + ".unity3d";

				if (forceLowerCase)
				{
					assetPath = LowerCaseAfterFinalSlash(assetPath);
				}

				Logging.Log("📦 Attempting to load asset bundle at: " + assetPath);

				if (compressed || containsFileColonSlashSlash)
				{
					if (!containsFileColonSlashSlash)
					{
						assetPath = "file://" + assetPath;
					}

					using (WWW compressedLoader = new WWW(assetPath))
					{
						yield return compressedLoader;

						if (!string.IsNullOrEmpty(compressedLoader.error))
						{
							Logging.LogError("❌ Failed to load compressed AssetBundle at: " + assetPath);
							Logging.LogError("🧨 Reason: " + compressedLoader.error);
						}

						loadedAssetBundle.bundle = compressedLoader.assetBundle;
					}
				}
				else
				{
					loadedAssetBundle.bundle = AssetBundle.LoadFromFile(assetPath);

					if (loadedAssetBundle.bundle == null)
					{
						Logging.LogError("❌ Failed to load AssetBundle from file: " + assetPath);
					}
					else
					{
						Logging.Log("✅ Successfully loaded AssetBundle from file: " + assetPath);
					}
				}
			}
			else
			{
				loadedAssetBundle.users.Add(activeObject);
			}

			if (loadedAssetBundle.bundle == null)
			{
				Logging.LogError("🚨 Critical: AssetBundle is still null after attempted load: " + path);
				yield break;
			}

			Logging.Log("📥 Loading asset from bundle: " + path);
			AssetBundleRequest request = loadedAssetBundle.bundle.LoadAssetAsync(loadedAssetBundle.bundle.mainAsset.name, expectedType);
			yield return request;

			if (request.asset == null)
			{
				Logging.LogError("⚠️ Loaded asset is null! Asset name: " + loadedAssetBundle.bundle.mainAsset.name + " | Expected Type: " + expectedType);
			}
			else
			{
				Logging.Log("🎉 Loaded asset: " + request.asset.name + " from bundle: " + path);
			}

			prefabResult.m_object = request.asset;
			prefabResult.isLoaded = true;

			while (loadedAssetBundle.users.Contains(null))
			{
				loadedAssetBundle.users.Remove(null);
			}

			loadedAssetBundle.users.Remove(activeObject);

			if (loadedAssetBundle.users.Count == 0)
			{
				Logging.Log("📦 Unloading asset bundle (no more users): " + path);
				loadedAssetBundle.bundle.Unload(false);
				m_concurrentlyLoadedAssetBundles.Remove(path);
			}
		}

	}
}
