using System;
using UnityEngine;

namespace ReformSim
{
    /// <summary>
    /// Shadertoy Inputs:
    /// vec3  iResolution   image/buffer        The viewport resolution(z is pixel aspect ratio, usually 1.0)
    /// float iTime         image/sound/buffer  Current time in seconds
    /// float iTimeDelta    image/buffer        Time it takes to render a frame, in seconds
    /// int   iFrame        image/buffer        Current frame
    /// float iFrameRate    image/buffer        Number of frames rendered per second
    /// float iChannelTime[4] image/buffer      Time for channel(if video or sound), in seconds
    /// vec3  iChannelResolution[4] image/buffer/sound Input texture resolution for each channel
    /// vec4  iMouse        image/buffer        xy = current pixel coords(if LMB is down). zw = click pixel
    /// sampler2D iChannel{i} image/buffer/sound Sampler for input textures i
    /// vec4  iDate         image/buffer/sound  Year, month, day, time in seconds in .xyzw
    /// float iSampleRate   image/buffer/sound  The sound sample rate(typically 44100)
    /// </summary>
    public class ImageShaderInput : MonoBehaviour
    {
        public int m_iFrame = 0;
        public float m_iFrameRate = 0;
        protected float m_framesTime;

        public Vector4 m_iDate;

        public float m_iSampleRate = 44100;

        public Material m_material = null;

        protected virtual void Start()
        {
            if (m_material == null)
            {
                Renderer render = GetComponent<Renderer>();
                m_material = render.material;
            }
            
            if (m_material.HasProperty("_iSampleRate"))
            {
                m_material.SetFloat("_iSampleRate", m_iSampleRate);
            }
        }

        protected virtual void Update()
        {
            m_iFrame++;

            m_framesTime += Time.unscaledDeltaTime;
            m_iFrameRate = m_iFrame / m_framesTime;
            
            m_iDate = new Vector4(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, (float)DateTime.Now.TimeOfDay.TotalSeconds);

            UpdateMateialProperties(m_material);
        }

        public void UpdateMateialProperties(Material mat)
        {
            if (mat == null)
            {
                return;
            }

            if (mat.HasProperty("_iFrame"))
            {
                mat.SetInt("_iFrame", m_iFrame);
            }

            if (mat.HasProperty("_iFrameRate"))
            {
                mat.SetFloat("_iFrameRate", m_iFrameRate);
            }

            if (mat.HasProperty("_iMouse"))
            {
                if (Input.GetMouseButton(0))
                {
                    Vector4 mousePosition = new Vector4(Input.mousePosition.x, Input.mousePosition.y, 1.0f, 0.0f);
                    mat.SetVector("_iMouse", mousePosition);
                }
                else if (Input.GetMouseButton(1))
                {
                    Vector4 mousePosition = new Vector4(Input.mousePosition.x, Input.mousePosition.y, 0.0f, 1.0f);
                    mat.SetVector("_iMouse", mousePosition);
                }
            }

            if (mat.HasProperty("_iDate"))
            {
                mat.SetVector("_iDate", m_iDate);
            }
        }
    }
}