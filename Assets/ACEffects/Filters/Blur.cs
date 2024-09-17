using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
[AddComponentMenu("ACEffects/Filters/Blur")]
public class Blur : MonoBehaviour {

	[Range(0.05f, 100.0f)]
	public float glowSize = 1.0f;

	private Material material = null;

	void Start () {
		material = new Material (Shader.Find("ACEffects/Shaders/Blur"));
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
		material.SetFloat ("_GlowSize", glowSize);
		Graphics.Blit (src, dest, material);
	}

}
