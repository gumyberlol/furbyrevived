using UnityEngine;

public class GestureStateTracker : MonoBehaviour
{
    private Vector2 startTouchPosition;
    private Vector2 endTouchPosition;
    private float swipeThreshold = 100f; // Minimum swipe distance for detection

    private void Update()
    {
        // If there is a touch input (for mobile) or mouse input (for testing)
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);

            // Detect swipe start
            if (touch.phase == TouchPhase.Began)
            {
                startTouchPosition = touch.position;
            }

            // Detect swipe end
            if (touch.phase == TouchPhase.Ended)
            {
                endTouchPosition = touch.position;

                // Check if the swipe distance exceeds the threshold
                Vector2 swipeDirection = endTouchPosition - startTouchPosition;
                if (swipeDirection.magnitude > swipeThreshold)
                {
                    // Swipe detected, you can handle swipe direction here
                    Debug.Log("Swipe detected: " + swipeDirection);
                }
            }
        }
        else if (Input.GetMouseButtonDown(0)) // For desktop, detect mouse click
        {
            startTouchPosition = Input.mousePosition;
        }
        else if (Input.GetMouseButtonUp(0)) // For desktop, detect mouse release
        {
            endTouchPosition = Input.mousePosition;

            // Check if the mouse movement exceeds the threshold
            Vector2 swipeDirection = endTouchPosition - startTouchPosition;
            if (swipeDirection.magnitude > swipeThreshold)
            {
                // Mouse swipe detected
                Debug.Log("Mouse swipe detected: " + swipeDirection);
            }
        }
    }
}
