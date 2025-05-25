using UnityEngine;

public class SplineGravitySimulator : MonoBehaviour
{
	public Spline spline;

	public float gravityConstant = 9.81f;

	public int iterations = 5;

	private void Start()
	{
		base.GetComponent<Rigidbody>().useGravity = false;
	}

	private void FixedUpdate()
	{
		if (!(base.GetComponent<Rigidbody>() == null) && !(spline == null))
		{
			Vector3 positionOnSpline = spline.GetPositionOnSpline(spline.GetClosestPointParam(base.GetComponent<Rigidbody>().position, iterations));
			Vector3 vector = positionOnSpline - base.GetComponent<Rigidbody>().position;
			Vector3 force = vector * Mathf.Pow(vector.magnitude, -3f) * gravityConstant * base.GetComponent<Rigidbody>().mass;
			base.GetComponent<Rigidbody>().AddForce(force);
		}
	}
}
