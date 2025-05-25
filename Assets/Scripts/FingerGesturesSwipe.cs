using UnityEngine;
using UnityEngine.InputSystem.EnhancedTouch;

public class FingerGesturesSwipe : MonoBehaviour
{
    // 🎢 These are the attractions! Set them in the Inspector to control scrollable content
    [SerializeField] private float contentWidth = 1000f;       // Total width of scrollable stuff
    [SerializeField] private float viewportWidth = 400f;        // What the user can see at once
    [SerializeField] private float scrollPosition = 0f;         // Starting view location

    private void Awake()
    {
        // 🎟️ Open the theme park by initializing the scroll system!
        FingerGestures.InitializeScrolling(contentWidth, viewportWidth, scrollPosition);
    }

    private void OnDestroy()
    {
        // 🎟️ Close the park when we're done
        FingerGestures.ShutdownTouchInput();
    }

    // 🧭 "Can I scroll left?" — Yes, if you're not already at the far left!
    public bool CanScrollLeft()
    {
        return FingerGestures.CanScrollLeft;
    }

    // 🧭 "Can I scroll right?" — Yes, if you're not already at the far right!
    public bool CanScrollRight()
    {
        return FingerGestures.CanScrollRight;
    }

    // 🔄 Update scroll position from other scripts
    public void UpdateScrollPosition(float newPosition)
    {
        FingerGestures.UpdateScrollPosition(newPosition);
    }

    // 🧾 Get current scroll position
    public float GetScrollPosition()
    {
        return FingerGestures.GetScrollPosition();
    }
}
