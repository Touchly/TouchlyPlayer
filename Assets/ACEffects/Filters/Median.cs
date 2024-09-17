using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
[AddComponentMenu("ACEffects/Filters/Median")]
public class Median : MonoBehaviour {

	private Material material = null;

	void Start () {
		material = new Material (Shader.Find("ACEffects/Shaders/Median"));
	}
	
	void OnDisable () {
		if (!material) {
			return;
		}
		DestroyImmediate (material);
	}
	
	void OnRenderImage (RenderTexture src, RenderTexture dest) {
		if (!material) {
			return;
		}
		material.SetFloat ("_TexWidth", src.width);
		material.SetFloat ("_TexHeight", src.height);
		Graphics.Blit (src, dest, material);
	}

}
