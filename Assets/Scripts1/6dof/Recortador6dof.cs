using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Recortador6dof : MonoBehaviour
{
    public RenderTexture _inputX2, _inputX3, _output, rightTex;
    private RenderTexture _input;
    private int startingX, widthX, sizeX;
    private bool preprocessed;
    private bool mono=true;
    private bool left = false;
    // Start is called before the first frame update

    void OnEnable()
    {
        //Take variable preprocessed
        int _preprocessed = PlayerPrefs.GetInt("preprocessed");

        if (_preprocessed == 1)
        {
           preprocessed = true;
        } else
        {
            preprocessed = false;
        }

        Debug.Log(_preprocessed);
        //Set points, where to cut the texture
        SetPoints();

    }

    void Update()
    {
        //Temp textute.
        RenderTexture tempTex;
        tempTex = RenderTexture.GetTemporary(sizeX, _input.height, 0, _input.graphicsFormat);
        tempTex.vrUsage = VRTextureUsage.TwoEyes;
        //Copy Depth Map panel in the video.
        Graphics.CopyTexture(_input, 0, 0, startingX, 0, sizeX, _input.height, tempTex, 0, 0, 0, 0);
        Graphics.Blit(tempTex, _output);
        RenderTexture.ReleaseTemporary(tempTex);
        _output.Create();

        //Copy to input X2, stereo image.
        if (preprocessed && !mono)
        {
            Graphics.CopyTexture(_input, 0, 0, 0, 0, sizeX*2, _input.height, _inputX2, 0, 0, 0, 0);
        }

        //Copy left image to mono texture
        if (mono)
        {
            if (left)
            {
                Graphics.CopyTexture(_input, 0, 0, 0, 0, sizeX, _input.height, rightTex, 0, 0, 0, 0);
            } else
            {
                Graphics.CopyTexture(_input, 0, 0, sizeX, 0, sizeX, _input.height, rightTex, 0, 0, 0, 0);
            }
            
        }
    }

    //Set "cutting points" of the texture.
    private void SetPoints()
    {
        //Preprocesado: El ultimo panel (Depth ya calculado)
        if (preprocessed)
        {
            _input = _inputX3;
            startingX = 2 * (_inputX3.width) / 3;
            sizeX = _inputX3.width / 3;
        }
        //En tiempo real: Primer panel, imagen de color (Depth por calcular)
        else
        {
            _input = _inputX2;
            startingX = 0;
            sizeX = _inputX2.width / 2;
        }
    }

    public void RenderMono(bool _mono)
    {
        mono = _mono;
    }
}
