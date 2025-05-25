using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.EnhancedTouch;
using Touch = UnityEngine.InputSystem.EnhancedTouch.Touch;

public static class FingerGestures
{
    public enum SwipeDirection
    {
        Up,
        Down,
        Left,
        Right
    }

    #region Scroll Detection Properties and Methods

    // Scroll detection properties
    private static bool _canScrollLeft = false;
    private static bool _canScrollRight = false;

    // Threshold for determining scroll availability
    private static float _scrollThreshold = 100f;

    // Content width and viewport width for scroll calculations
    private static float _contentWidth = 0f;
    private static float _viewportWidth = 0f;
    private static float _currentScrollPosition = 0f;
    private static float _scrollSensitivity = 1.0f;

    // Touch tracking for scroll functionality
    private static Vector2 _lastTouchPosition;
    private static bool _isDragging = false;
    private static bool _touchScrollingInitialized = false;

    // Public properties to check if scrolling is available
    public static bool CanScrollLeft => _canScrollLeft;
    public static bool CanScrollRight => _canScrollRight;

    // Method to initialize scroll parameters
    public static void InitializeScrolling(float contentWidth, float viewportWidth, float initialScrollPosition = 0f, float threshold = 100f, float sensitivity = 1.0f)
    {
        _contentWidth = contentWidth;
        _viewportWidth = viewportWidth;
        _currentScrollPosition = initialScrollPosition;
        _scrollThreshold = threshold;
        _scrollSensitivity = sensitivity;

        // Initialize touch input if not already done
        InitializeTouchInput();

        UpdateScrollAvailability();
    }

    // Initialize touch input support
    private static void InitializeTouchInput()
    {
        if (!_touchScrollingInitialized)
        {
            // Enable enhanced touch support
            if (!EnhancedTouchSupport.enabled)
            {
                EnhancedTouchSupport.Enable();
            }

            // Subscribe to touch events
            Touch.onFingerDown += OnFingerDownForScrolling;
            Touch.onFingerMove += OnFingerMoveForScrolling;
            Touch.onFingerUp += OnFingerUpForScrolling;

            _touchScrollingInitialized = true;
        }
    }

    // Cleanup touch input
    public static void ShutdownTouchInput()
    {
        if (_touchScrollingInitialized)
        {
            // Unsubscribe from touch events
            Touch.onFingerDown -= OnFingerDownForScrolling;
            Touch.onFingerMove -= OnFingerMoveForScrolling;
            Touch.onFingerUp -= OnFingerUpForScrolling;

            _touchScrollingInitialized = false;
        }
    }

    // Touch event handlers for scrolling
    private static void OnFingerDownForScrolling(Finger finger)
    {
        if (finger.index == 0) // Only track the first finger for scrolling
        {
            _lastTouchPosition = finger.screenPosition;
            _isDragging = true;
        }
    }

    private static void OnFingerMoveForScrolling(Finger finger)
    {
        if (!_isDragging || finger.index != 0) return;

        // Calculate delta
        Vector2 currentPosition = finger.screenPosition;
        Vector2 delta = currentPosition - _lastTouchPosition;

        // Update scroll position based on horizontal movement
        _currentScrollPosition -= delta.x * _scrollSensitivity;

        // Clamp scroll position to valid range
        _currentScrollPosition = Mathf.Clamp(_currentScrollPosition, 0, Mathf.Max(0, _contentWidth - _viewportWidth));

        // Update availability after scroll
        UpdateScrollAvailability();

        // Store current position for next frame
        _lastTouchPosition = currentPosition;
    }

    private static void OnFingerUpForScrolling(Finger finger)
    {
        if (finger.index == 0)
        {
            _isDragging = false;
        }
    }

    // Method to update current scroll position
    public static void UpdateScrollPosition(float newPosition)
    {
        _currentScrollPosition = Mathf.Clamp(newPosition, 0, Mathf.Max(0, _contentWidth - _viewportWidth));
        UpdateScrollAvailability();
    }

    // Set scroll dimensions
    public static void SetScrollDimensions(float contentWidth, float viewportWidth)
    {
        _contentWidth = contentWidth;
        _viewportWidth = viewportWidth;

        // Ensure current position is still valid
        _currentScrollPosition = Mathf.Clamp(_currentScrollPosition, 0, Mathf.Max(0, _contentWidth - _viewportWidth));

        UpdateScrollAvailability();
    }

    // Set scroll threshold
    public static void SetScrollThreshold(float threshold)
    {
        _scrollThreshold = threshold;
        UpdateScrollAvailability();
    }

    // Set scroll sensitivity
    public static void SetScrollSensitivity(float sensitivity)
    {
        _scrollSensitivity = sensitivity;
    }

    // Get current scroll position
    public static float GetScrollPosition()
    {
        return _currentScrollPosition;
    }

    // Update scroll availability based on current position
    private static void UpdateScrollAvailability()
    {
        // Can scroll left if we're not at the leftmost position
        _canScrollLeft = _currentScrollPosition > 0f + _scrollThreshold;

        // Can scroll right if we're not at the rightmost position
        float rightEdge = _contentWidth - _viewportWidth;
        _canScrollRight = _currentScrollPosition < (rightEdge - _scrollThreshold);
    }

    #endregion

    #region Gesture Events and Delegates

    public delegate void FingerDownHandler(int fingerIndex, Vector2 fingerPos);
    public static event FingerDownHandler OnFingerDown;

    public delegate void FingerUpHandler(int fingerIndex, Vector2 fingerPos, float timeHeldDown);
    public static event FingerUpHandler OnFingerUp;

    public delegate void SimpleFingerHandler(int fingerIndex, Vector2 fingerPos);
    public static event SimpleFingerHandler OnFingerMoveBegin;
    public static event SimpleFingerHandler OnFingerMove;
    public static event SimpleFingerHandler OnFingerMoveEnd;
    public static event SimpleFingerHandler OnFingerLongPress;
    public static event SimpleFingerHandler OnFingerTap;
    public static event SimpleFingerHandler OnFingerDoubleTap;
    public static event SimpleFingerHandler OnFingerDragEnd;

    public delegate void FingerStationaryHandler(int fingerIndex, Vector2 fingerPos);
    public static event FingerStationaryHandler OnFingerStationaryBegin;
    public static event FingerStationaryHandler OnFingerStationary;

    public delegate void FingerStationaryEndHandler(int fingerIndex, Vector2 fingerPos, float elapsedTime);
    public static event FingerStationaryEndHandler OnFingerStationaryEnd;

    public delegate void FingerSwipeHandler(int fingerIndex, Vector2 startPos, SwipeDirection direction, float velocity);
    public static event FingerSwipeHandler OnFingerSwipe;

    public delegate void FingerDragBeginHandler(int fingerIndex, Vector2 fingerPos, Vector2 startPos);
    public static event FingerDragBeginHandler OnFingerDragBegin;

    public delegate void FingerDragMoveHandler(int fingerIndex, Vector2 fingerPos, Vector2 delta);
    public static event FingerDragMoveHandler OnFingerDragMove;

    public delegate void SimpleVectorHandler(Vector2 pos);
    public static event SimpleVectorHandler OnLongPress;
    public static event SimpleVectorHandler OnTap;
    public static event SimpleVectorHandler OnDoubleTap;
    public static event SimpleVectorHandler OnDragEnd;
    public static event SimpleVectorHandler OnTwoFingerLongPress;
    public static event SimpleVectorHandler OnTwoFingerTap;

    public delegate void SwipeHandler(Vector2 startPos, SwipeDirection direction, float velocity);
    public static event SwipeHandler OnSwipe;
    public static event SwipeHandler OnTwoFingerSwipe;

    public delegate void DragHandler(Vector2 pos, Vector2 startPos);
    public static event DragHandler OnDragBegin;
    public static event DragHandler OnTwoFingerDragBegin;

    public delegate void DragMoveHandler(Vector2 pos, Vector2 delta);
    public static event DragMoveHandler OnDragMove;
    public static event DragMoveHandler OnTwoFingerDragMove;

    public delegate void PinchHandler(Vector2 pos1, Vector2 pos2);
    public static event PinchHandler OnPinchBegin;
    public static event PinchHandler OnPinchEnd;

    public delegate void PinchMoveHandler(Vector2 pos1, Vector2 pos2, float delta);
    public static event PinchMoveHandler OnPinchMove;

    public delegate void RotationBeginHandler(Vector2 pos1, Vector2 pos2);
    public static event RotationBeginHandler OnRotationBegin;

    public delegate void RotationMoveHandler(Vector2 pos1, Vector2 pos2, float angleDelta);
    public static event RotationMoveHandler OnRotationMove;

    public delegate void RotationEndHandler(Vector2 pos1, Vector2 pos2, float totalAngle);
    public static event RotationEndHandler OnRotationEnd;

    public static event DragHandler OnTwoFingerDragEnd;

    #endregion
}

// Helper MonoBehaviour to initialize FingerGestures scroll functionality
public class FingerGesturesInitializer : MonoBehaviour
{
    [SerializeField] private float contentWidth = 1000f;
    [SerializeField] private float viewportWidth = 400f;
    [SerializeField] private float initialScrollPosition = 0f;
    [SerializeField] private float scrollThreshold = 100f;
    [SerializeField] private float scrollSensitivity = 1.0f;

    private void Awake()
    {
        FingerGestures.InitializeScrolling(contentWidth, viewportWidth, initialScrollPosition, scrollThreshold, scrollSensitivity);
    }

    private void OnDestroy()
    {
        FingerGestures.ShutdownTouchInput();
    }
}
