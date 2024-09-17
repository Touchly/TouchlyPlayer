using UnityEngine;
using UnityEngine.XR;

[ExecuteInEditMode]
public class MobileBlur : MonoBehaviour
{
    public enum Algorithm
    {
        Box = 1,
        Gaussian = 2
    }
    public Algorithm algorithm = Algorithm.Box;
    [Range(0, 2)]
    public float BlurAmount = 1;
    [Range(2, 3)]
    public int KernelSize = 2;
    public Texture2D maskTexture; 
    private Texture2D previous;
    public Material material = null;

    static readonly string kernelKeyword = "KERNEL";
    static readonly int blurAmountString = Shader.PropertyToID("_BlurAmount");
    static readonly int blurTexString = Shader.PropertyToID("_BlurTex");
    static readonly int maskTexString = Shader.PropertyToID("_MaskTex");
    private int numberOfPasses, pass;
    RenderTextureDescriptor half, quarter, eighths, sixths;

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (BlurAmount == 0)
        {
            Graphics.Blit(source, destination);
            return;
        }

        if (XRSettings.enabled)
        {
            half = XRSettings.eyeTextureDesc;
            half.height /= 2; half.width /= 2;
            quarter = XRSettings.eyeTextureDesc;
            quarter.height /= 4; quarter.width /= 4;
            eighths = XRSettings.eyeTextureDesc;
            eighths.height /= 8; eighths.width /= 8;
            sixths = XRSettings.eyeTextureDesc;
            sixths.height /= XRSettings.stereoRenderingMode == XRSettings.StereoRenderingMode.SinglePass ? 8 : 16; sixths.width /= XRSettings.stereoRenderingMode == XRSettings.StereoRenderingMode.SinglePass ? 8 : 16;
        }
        else
        {
            half = new RenderTextureDescriptor(Screen.width / 2, Screen.height / 2);
            quarter = new RenderTextureDescriptor(Screen.width / 4, Screen.height / 4);
            eighths = new RenderTextureDescriptor(Screen.width / 8, Screen.height / 8);
            sixths = new RenderTextureDescriptor(Screen.width / 16, Screen.height / 16);
        }

        if (KernelSize == 2)
            material.DisableKeyword(kernelKeyword);
        else
            material.EnableKeyword(kernelKeyword);

        pass = algorithm == Algorithm.Box ? 0 : 1;

        if(maskTexture != null || previous != maskTexture)
        {
            previous = maskTexture;
            material.SetTexture(maskTexString, maskTexture);
        }

        RenderTexture blurTex = null;
        numberOfPasses = Mathf.Clamp(Mathf.CeilToInt(BlurAmount * 4), 1, 4);
        material.SetFloat(blurAmountString, numberOfPasses > 1 ? BlurAmount > 1 ? BlurAmount : (BlurAmount * 4 - Mathf.FloorToInt(BlurAmount * 4 - 0.001f)) * 0.5f + 0.5f : BlurAmount * 4);

        if (numberOfPasses == 1)
        {
            blurTex = RenderTexture.GetTemporary(half);
            blurTex.filterMode = FilterMode.Bilinear;
            Graphics.Blit(source, blurTex, material, pass);
        }
        else if (numberOfPasses == 2)
        {
            blurTex = RenderTexture.GetTemporary(half);
            var temp1 = RenderTexture.GetTemporary(quarter);
            blurTex.filterMode = FilterMode.Bilinear;
            temp1.filterMode = FilterMode.Bilinear;
            Graphics.Blit(source, temp1, material, pass);
            Graphics.Blit(temp1, blurTex, material, pass);
            RenderTexture.ReleaseTemporary(temp1);
        }
        else if (numberOfPasses == 3)
        {
            blurTex = RenderTexture.GetTemporary(quarter);
            var temp1 = RenderTexture.GetTemporary(eighths);
            blurTex.filterMode = FilterMode.Bilinear;
            temp1.filterMode = FilterMode.Bilinear;
            Graphics.Blit(source, blurTex, material, pass);
            Graphics.Blit(blurTex, temp1, material, pass);
            Graphics.Blit(temp1, blurTex, material, pass);
            RenderTexture.ReleaseTemporary(temp1);
        }
        else if (numberOfPasses == 4)
        {
            blurTex = RenderTexture.GetTemporary(quarter);
            var temp1 = RenderTexture.GetTemporary(eighths);
            var temp2 = RenderTexture.GetTemporary(sixths);
            blurTex.filterMode = FilterMode.Bilinear;
            temp1.filterMode = FilterMode.Bilinear;
            temp2.filterMode = FilterMode.Bilinear;
            Graphics.Blit(source, blurTex, material, pass);
            Graphics.Blit(blurTex, temp1, material, pass);
            Graphics.Blit(temp1, temp2, material, pass);
            Graphics.Blit(temp2, temp1, material, pass);
            Graphics.Blit(temp1, blurTex, material, pass);
            RenderTexture.ReleaseTemporary(temp1);
            RenderTexture.ReleaseTemporary(temp2);
        }

        material.SetTexture(blurTexString, blurTex);
        RenderTexture.ReleaseTemporary(blurTex);

        Graphics.Blit(source, destination, material, 2);
    }
}