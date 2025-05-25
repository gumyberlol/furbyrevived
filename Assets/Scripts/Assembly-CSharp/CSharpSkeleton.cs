using UnityEngine;

public class CSharpSkeleton : MonoBehaviour
{
	private void OnEnable()
	{
		FingerGestures.OnFingerTap += FingerGestures_OnFingerTap;
		FingerGestures.OnFingerSwipe += FingerGestures_OnFingerSwipe;
		// Add more as needed :3
	}

	private void OnDisable()
	{
		FingerGestures.OnFingerTap -= FingerGestures_OnFingerTap;
		FingerGestures.OnFingerSwipe -= FingerGestures_OnFingerSwipe;
		// Remove more as needed :3
	}

	private void FingerGestures_OnFingerTap(int fingerIndex, Vector2 fingerPos)
	{
		Debug.Log($"Tap with finger {fingerIndex} at {fingerPos} :3");
	}

	private void FingerGestures_OnFingerSwipe(int fingerIndex, Vector2 startPos, FingerGestures.SwipeDirection direction, float velocity)
	{
		Debug.Log($"Swipe! Finger {fingerIndex} from {startPos} dir: {direction} velocity: {velocity} :3");
	}
}
