using System.Collections;
using System.Collections.Generic;
using Fabric;
using Relentless;
using UnityEngine;

namespace Furby
{
	public class BabyInstance : ModelInstance
	{
		[SerializeField]
		private bool m_baby = true;

		[SerializeField]
		private bool m_hideIfWrongType = true;

		[SerializeField]
		public TribeSpecificPrefab[] m_TribeSpecificPrefabs;

		[SerializeField]
		private bool m_useCurrentBaby = true;

		[SerializeField]
		private TextMesh m_babyTypeLabel;

		[SerializeField]
		private bool m_hideOnStart;

		[SerializeField]
		private bool m_showFlairs = true;

		[SerializeField]
		private FurbyBeakSyncData m_beakSyncData;

		private bool m_hidden;

		private List<GameObject> m_flairObjects = new List<GameObject>();

		private bool m_IsReadyToBeRendered;

		[SerializeField]
		private GameObject m_glowPrefab;

		[SerializeField]
		private Material m_glowMaterial;

		private FurbyBaby m_targetBaby;

		private GameObject GetTribeSpecificPrefab(Tribeset tribe)
		{
			GameObject result = null;
			TribeSpecificPrefab[] tribeSpecificPrefabs = m_TribeSpecificPrefabs;
			foreach (TribeSpecificPrefab tribeSpecificPrefab in tribeSpecificPrefabs)
			{
				if (tribeSpecificPrefab.m_Tribeset == tribe)
				{
					result = tribeSpecificPrefab.m_Prefab;
					break;
				}
			}
			return result;
		}

		public void SetTargetFurbyBaby(FurbyBaby targetFurbling)
		{
			m_useCurrentBaby = false;
			m_targetBaby = targetFurbling;
			Resources.UnloadUnusedAssets();
		}

		public FurbyBaby GetTargetFurbyBaby()
		{
			return m_targetBaby;
		}

		private void ApplyBit(Dictionary<string, GameObject> furbyBits, string bitName, Texture textureToUse, float tilingX, float tilingY, Shader shader)
		{
			if (furbyBits.ContainsKey(bitName))
			{
				GameObject gameObject = furbyBits[bitName];
				Material material = new Material(gameObject.GetComponent<Renderer>().material);
				material.SetTexture("_Texture", textureToUse);
				material.SetTextureScale("_Texture", new Vector2(tilingX, tilingY));
				if (shader != null)
				{
					material.shader = shader;
				}
				gameObject.GetComponent<Renderer>().material = material;
			}
		}

		private IEnumerator Apply()
		{
			Logging.Log("Apply() started!");
			m_IsReadyToBeRendered = false;

			if (m_baby)
			{
				Logging.Log("Disabling baby animations...");
				Animation[] componentsInChildren = GetComponentsInChildren<Animation>(true);
				foreach (Animation anim in componentsInChildren)
				{
					anim.enabled = false;
					foreach (AnimationState aState in anim)
					{
						aState.normalizedTime = 0f;
					}
				}
			}

			if (m_baby)
			{
				Logging.Log("Starting flair instantiation...");
				yield return StartCoroutine(InstantiateFlair());
				Logging.Log("Finished flair instantiation.");
			}

			Logging.Log("Getting baby type info...");
			BabyFurbyLibrary lib = FurbyGlobals.BabyLibrary;
			FurbyBabyTypeInfo babyTypeInfo = lib.GetBabyFurby(m_targetBaby.Type);

			Logging.Log("Setting up furby bit spec...");
			Dictionary<string, GameObject> furbyBits = new Dictionary<string, GameObject>();
			Dictionary<string, string> furbyBitSpec = new Dictionary<string, string>
			{
				{ "furbyBaby_body_main_GEO_fixedFace", "Fur" },
				{ "furbyBaby_ears_GEO", "Ears" },
				{ "furbyBaby_eyeLidL_GEO", "EyeLidL" },
				{ "furbyBaby_eyeLidR_GEO", "EyeLidR" },
				{ "furbyBaby_facia_GEO", "EyeSurround" },
				{ "furbyBaby_Facia_GEO", "EyeSurround" },
				{ "furbyBaby_Feet_GEO", "Feet" },
				{ "CH_furbyBaby_tail_GEO", "Tail" },
				{ "CH_furbyBaby_beakLw_GEO", "BeakLw" },
				{ "CH_furbyBaby_beakUp_GEO", "BeakUp" },
				{ "FurblingEgg_whole_GEO", "Egg" },
				{ "FurblingEgg_top_GEO", "EggTop" },
				{ "FurblingEgg_bottom_GEO", "EggBottom" }
			};
			GetChildGameObjectsWithNames(base.gameObject, furbyBitSpec, furbyBits);

			string assetBundleName = babyTypeInfo.GetColoringAssetBundleName();
			Logging.Log("Loading asset bundle: " + assetBundleName);
			AssetBundleHelpers.AssetBundleLoad colourLoadingObject = new AssetBundleHelpers.AssetBundleLoad();
			yield return StartCoroutine(AssetBundleHelpers.Load(assetBundleName, true, colourLoadingObject, base.gameObject, typeof(FurbyBabyColoring), true));

			FurbyBabyColoring furbyBabyColour = (FurbyBabyColoring)colourLoadingObject.m_object;
			Logging.Log("Finished loading asset bundle.");

			FurbyBaby furbyBaby = GetTargetFurbyBaby();

			if (!m_baby)
			{
				Logging.Log("Applying egg materials...");
				Renderer[] componentsInChildren2 = GetComponentsInChildren<Renderer>(true);
				foreach (Renderer renderer in componentsInChildren2)
				{
					Material newMat = ((furbyBaby.CanBeGifted || !furbyBaby.FixedIncubationTime || !furbyBaby.PreAllocatedPersonality || !(m_glowMaterial != null)) ? new Material(renderer.material) : new Material(m_glowMaterial));
					newMat.SetTexture("_Texture", furbyBabyColour.EggTexture);
					if (m_targetBaby.Type.Tribe.EggShader != null)
					{
						newMat.shader = m_targetBaby.Type.Tribe.EggShader;
					}
					renderer.material = newMat;
				}
			}
			else
			{
				Logging.Log("Applying baby materials...");
				if (furbyBabyColour != null && furbyBabyColour.BitsTexture != null)
				{
					foreach (string partValue in furbyBitSpec.Values)
					{
						if (partValue.Contains("Eye"))
						{
							ApplyBit(furbyBits, partValue, furbyBabyColour.BitsTexture, 1f, 1f, m_targetBaby.Type.Tribe.FaceShader);
						}
						else
						{
							ApplyBit(furbyBits, partValue, furbyBabyColour.BitsTexture, 1f, 1f, m_targetBaby.Type.Tribe.BitsShader);
						}
					}
				}
				ApplyBit(furbyBits, "Fur", furbyBabyColour.FurTexture, furbyBabyColour.tilingX, furbyBabyColour.tilingY, null);
			}

			Logging.Log("Applying cubemaps...");
			Renderer[] componentsInChildren3 = GetComponentsInChildren<Renderer>(true);
			foreach (Renderer renderer2 in componentsInChildren3)
			{
				if (m_targetBaby.Type.Tribe.Cubemap != null)
				{
					renderer2.material.SetTexture("_CubeTex", m_targetBaby.Type.Tribe.Cubemap);
				}
			}

			if (m_babyTypeLabel != null)
			{
				Logging.Log("Updating baby type label...");
				if (m_targetBaby.Personality != FurbyBabyPersonality.None)
				{
					m_babyTypeLabel.text = m_targetBaby.Personality.ToString();
				}
				else
				{
					m_babyTypeLabel.gameObject.SetActive(false);
				}
			}

			if (m_baby)
			{
				Logging.Log("Adding eye + beak animation components...");
				GameObject furbyBabyInstance = base.Instance;
				FurbyEyeUvAnimator eyeAnimator = furbyBabyInstance.AddComponent<FurbyEyeUvAnimator>();
				Transform eyeGEOL = furbyBabyInstance.transform.Find("furbyBaby_eyeL_GEO");
				Transform eyeGEOR = furbyBabyInstance.transform.Find("furbyBaby_eyeR_GEO");
				eyeAnimator.AssignEyeControllers(furbyBabyInstance.transform.Find("eyeLUV"), controllerTransformEyeR: furbyBabyInstance.transform.Find("eyeRUV"), modelEyeL: eyeGEOL.gameObject, modelEyeR: eyeGEOR.gameObject);

				FurbyBeakSync beakSync = furbyBabyInstance.AddComponent<FurbyBeakSync>();
				Transform beakTransformTop = furbyBabyInstance.transform.Find("CHAR_furbyBaby_ROOT/BodyUp_JNT/FaceBone_beakUp_JNT");
				Transform beakTransformLow = furbyBabyInstance.transform.Find("CHAR_furbyBaby_ROOT/BodyUp_JNT/FaceBone_beakLow_JNT");
				beakSync.AssignBeakControllers(beakTransformTop, beakTransformLow, m_beakSyncData, furbyBabyInstance.GetComponent<Animation>());
			}

			if (!m_hidden)
			{
				Logging.Log("Calling Show()");
				Show();
			}

			m_IsReadyToBeRendered = true;
			Logging.Log("Apply() finished successfully!");
		}


		public bool IsReadyToBeRendered()
		{
			return m_IsReadyToBeRendered;
		}

		private static void GetChildGameObjectsWithNames(GameObject rootObject, Dictionary<string, string> namesToMatch, Dictionary<string, GameObject> outMatchedObjects)
		{
			if (rootObject == null)
			{
				return;
			}
			if (namesToMatch.ContainsKey(rootObject.name))
			{
				outMatchedObjects[namesToMatch[rootObject.name]] = rootObject;
			}
			foreach (Transform item in rootObject.transform)
			{
				GetChildGameObjectsWithNames(item.gameObject, namesToMatch, outMatchedObjects);
			}
		}

		protected bool ShouldInstantiate()
		{
			FindTargetBaby();
			if (m_targetBaby == null)
			{
				return false;
			}
			if (m_baby != (m_targetBaby.Progress != FurbyBabyProgresss.E) && m_hideIfWrongType)
			{
				return false;
			}
			return true;
		}

		public void ForceInstantiateObject()
		{
			m_IsReadyToBeRendered = false;
			InternalInstantiateObject();
		}

		public override void InstantiateObject()
		{
			if (!(base.Instance != null))
			{
				InternalInstantiateObject();
			}
		}

		private void InternalInstantiateObject()
		{
			Logging.Log("📦 InternalInstantiateObject() called");

			if (ModelPrefab == null || m_destoryOld)
			{
				Logging.Log("🧱 ModelPrefab is null or marked for destroy, grabbing tribe-specific prefab");
				ModelPrefab = GetTribeSpecificPrefab(m_targetBaby.Tribe.TribeSet);
			}
			else
			{
				Logging.Log("✅ ModelPrefab already assigned: " + ModelPrefab.name);
			}

			Logging.Log("🚀 Instantiating object...");
			base.InstantiateObject();

			Hide();
			m_hidden = m_hideOnStart;

			Animation anim = base.Instance.GetComponent<Animation>();
			if (anim != null)
			{
				anim.cullingType = AnimationCullingType.AlwaysAnimate;
				Logging.Log("🎞️ Animation component found and updated");
			}
			else
			{
				Logging.Log("⚠️ No Animation component found!");
			}

			Logging.Log("📞 Starting Apply() coroutine...");
			StartCoroutine(Apply());
		}


		public void Show()
		{
			m_hidden = false;
			bool flag = false;
			Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>(true);
			foreach (Renderer renderer in componentsInChildren)
			{
				if (!renderer.enabled)
				{
					renderer.enabled = true;
					flag = true;
				}
			}
			if (flag && m_baby)
			{
				Animation[] componentsInChildren2 = GetComponentsInChildren<Animation>(true);
				foreach (Animation animation in componentsInChildren2)
				{
					animation.enabled = true;
					foreach (AnimationState item in animation)
					{
						item.normalizedTime = 0f;
					}
				}
			}
			if (m_showFlairs)
			{
				return;
			}
			foreach (GameObject flairObject in m_flairObjects)
			{
				Renderer[] componentsInChildren3 = flairObject.GetComponentsInChildren<Renderer>(true);
				foreach (Renderer renderer2 in componentsInChildren3)
				{
					renderer2.enabled = false;
				}
			}
		}

		public void ReInstantiateFlairs()
		{
			StartCoroutine(InstantiateFlair());
		}

		public void UnhideFlairs()
		{
			foreach (GameObject flairObject in m_flairObjects)
			{
				Renderer[] componentsInChildren = flairObject.GetComponentsInChildren<Renderer>(true);
				foreach (Renderer renderer in componentsInChildren)
				{
					renderer.enabled = true;
				}
			}
		}

		public void Hide()
		{
			m_hidden = true;
			Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>(true);
			foreach (Renderer renderer in componentsInChildren)
			{
				renderer.enabled = false;
			}
		}

		private IEnumerator InstantiateFlair()
		{
			string[] flairs = m_targetBaby.m_persistantData.flairs;
			foreach (string flair in flairs)
			{
				FlairLibrary.PrefabLoader loader = FurbyGlobals.FlairLibrary.GetPrefabLoader(flair);
				GameObject rootObject = base.gameObject.GetChildGameObject(loader.Flair.AttachNode);
				Logging.Log(loader.Flair.AttachNode);
				GameObject trackObject = new GameObject();
				trackObject.transform.parent = base.transform;
				trackObject.transform.localPosition = Vector3.zero;
				trackObject.transform.localScale = Vector3.one;
				trackObject.transform.localRotation = Quaternion.identity;
				trackObject.transform.parent = rootObject.transform;
				if (!string.IsNullOrEmpty(loader.Flair.VocalSwitch))
				{
					Fabric.Event fabricEvent = new Fabric.Event
					{
						EventAction = EventAction.SetSwitch,
						_eventName = "vocal_switch",
						_parameter = loader.Flair.VocalSwitch
					};
					EventManager.Instance.PostEvent(fabricEvent);
				}
				yield return StartCoroutine(loader.Load(base.gameObject));
				GameObject flairObject = (GameObject)Object.Instantiate(loader.Prefab);
				if (rootObject != null)
				{
					flairObject.transform.parent = trackObject.transform;
					flairObject.SetLayerInChildren(base.gameObject.layer);
					flairObject.transform.localScale = Vector3.one;
					flairObject.transform.localPosition = Vector3.zero;
					flairObject.transform.localRotation = Quaternion.identity;
				}
				m_flairObjects.Add(flairObject);
				Renderer[] componentsInChildren = flairObject.GetComponentsInChildren<Renderer>(true);
				foreach (Renderer renderer in componentsInChildren)
				{
					renderer.enabled = false;
				}
			}
		}

		private IEnumerator WaitUntilReadyThenInstantiate()
		{
			if (ShouldInstantiate())
			{
				InstantiateObject();
			}
			yield break;
		}

		protected new void Start()
		{
			StartCoroutine(WaitUntilReadyThenInstantiate());
		}

		private void FindTargetBaby()
		{
			if (m_useCurrentBaby)
			{
				m_targetBaby = FurbyGlobals.Player.SelectedFurbyBaby;
			}
		}
	}
}
