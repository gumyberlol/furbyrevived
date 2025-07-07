using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;
using UnityEngine;
using System.IO;

public class CopyBundlesToStreamingAssets : IPreprocessBuildWithReport
{
    public int callbackOrder => 0;

    public void OnPreprocessBuild(BuildReport report)
    {
        string sourcePath = "Assets/AssetBundles";
        string destPath = Application.streamingAssetsPath;

        if (!Directory.Exists(sourcePath))
        {
            Debug.LogWarning("AssetBundles folder not found at " + sourcePath);
            return;
        }

        if (!Directory.Exists(destPath))
            Directory.CreateDirectory(destPath);

        foreach (string file in Directory.GetFiles(sourcePath, "*", SearchOption.AllDirectories))
        {
            if (file.EndsWith(".meta")) continue;

            string relativePath = file.Substring(sourcePath.Length + 1);
            string targetPath = Path.Combine(destPath, relativePath);

            string targetDir = Path.GetDirectoryName(targetPath);
            if (!Directory.Exists(targetDir))
                Directory.CreateDirectory(targetDir);

            File.Copy(file, targetPath, true);
            Debug.Log($"Copied: {relativePath} → StreamingAssets/");
        }

        Debug.Log("✅ AssetBundles copied to StreamingAssets! :3");
    }
}
