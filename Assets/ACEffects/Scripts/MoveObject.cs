using UnityEngine;
using System.Collections;

public class MoveObject : MonoBehaviour {

	public Vector3 startPos;
	public Vector3 endPos;
	[Range(0.01f, 5.0f)]
	public float speed = 0.01f;
	private float timeCurrent = 0.0f;

	// Use this for initialization
	void Start () {
		gameObject.transform.position = startPos;
		timeCurrent = 0.0f;
	}
	
	// Update is called once per frame
	void Update () {
		timeCurrent += Time.deltaTime;
		if (timeCurrent > speed) {
			timeCurrent = 0.0f;
		}
		gameObject.transform.position = startPos + (endPos - startPos) * (timeCurrent / speed);
	}
}
