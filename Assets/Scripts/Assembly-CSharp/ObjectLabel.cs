using UnityEngine;
using UnityEngine.UI; // Don't forget to add this namespace for UI.Text

[RequireComponent(typeof(Text))] // This now requires the UI.Text component
public class ObjectLabel : MonoBehaviour
{
	public Transform target;

	public Vector3 offset = Vector3.up;

	public bool clampToScreen;

	public float clampBorderSize = 0.05f;

	public bool useMainCamera = true;

	public Camera cameraToUse;

	private Camera cam;

	private Transform thisTransform;

	private Transform camTransform;

	private Text uiText; // Reference to UI.Text

	private void Start()
	{
		thisTransform = base.transform;
		if (useMainCamera)
		{
			cam = Camera.main;
		}
		else
		{
			cam = cameraToUse;
		}
		camTransform = cam.transform;

		uiText = GetComponent<Text>(); // Get the reference to UI.Text
	}

	private void Update()
	{
		if (clampToScreen)
		{
			Vector3 vector = camTransform.InverseTransformPoint(target.position);
			vector.z = Mathf.Max(vector.z, 1f);
			thisTransform.position = cam.WorldToViewportPoint(camTransform.TransformPoint(vector + offset));
			thisTransform.position = new Vector3(Mathf.Clamp(thisTransform.position.x, clampBorderSize, 1f - clampBorderSize), Mathf.Clamp(thisTransform.position.y, clampBorderSize, 1f - clampBorderSize), thisTransform.position.z);
		}
		else
		{
			thisTransform.position = cam.WorldToViewportPoint(target.position + offset);
		}

		// Optionally, you can update the label text here if needed
		// uiText.text = "Some label text"; // Update the label text
	}
}
