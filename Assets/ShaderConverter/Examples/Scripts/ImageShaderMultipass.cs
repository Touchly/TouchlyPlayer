using System;
using UnityEngine;

namespace ReformSim
{
    public class ImageShaderMultipass : ImageShaderInput
    {
        public Material m_bufferAMaterial;
        public Material m_bufferBMaterial;
        public Material m_bufferCMaterial;
        public Material m_bufferDMaterial;

        public RenderTexture m_bufferA;
        public RenderTexture m_bufferB;
        public RenderTexture m_bufferC;
        public RenderTexture m_bufferD;

        protected bool m_isBufferASelfAccumulated = true;
        protected bool m_isBufferBSelfAccumulated = true;
        protected bool m_isBufferCSelfAccumulated = true;
        protected bool m_isBufferDSelfAccumulated = true;

        protected RenderTexture m_tempBufferA;
        protected RenderTexture m_tempBufferB;
        protected RenderTexture m_tempBufferC;
        protected RenderTexture m_tempBufferD;

        protected override void Start()
        {
            if (m_bufferA == null)
            {
                m_bufferA = new RenderTexture(Screen.width, Screen.height, 0, RenderTextureFormat.ARGBFloat, 0);
                m_bufferA.Create();
            }
            if (m_bufferB == null)
            {
                m_bufferB = new RenderTexture(Screen.width, Screen.height, 0, RenderTextureFormat.ARGBFloat, 0);
                m_bufferB.Create();
            }
            if (m_bufferC == null)
            {
                m_bufferC = new RenderTexture(Screen.width, Screen.height, 0, RenderTextureFormat.ARGBFloat, 0);
                m_bufferC.Create();
            }
            if (m_bufferD == null)
            {
                m_bufferD = new RenderTexture(Screen.width, Screen.height, 0, RenderTextureFormat.ARGBFloat, 0);
                m_bufferD.Create();
            }

            Graphics.Blit(Texture2D.blackTexture, m_bufferA);
            Graphics.Blit(Texture2D.blackTexture, m_bufferB);
            Graphics.Blit(Texture2D.blackTexture, m_bufferC);
            Graphics.Blit(Texture2D.blackTexture, m_bufferD);

            if (m_isBufferASelfAccumulated && m_bufferA != null)
            {
                m_tempBufferA = new RenderTexture(m_bufferA);
                //m_tempRenderTexture.enableRandomWrite = true;
                m_tempBufferA.Create();
            }

            if (m_isBufferBSelfAccumulated && m_bufferB != null)
            {
                m_tempBufferB = new RenderTexture(m_bufferB);
                m_tempBufferB.Create();
            }

            if (m_isBufferCSelfAccumulated && m_bufferC != null)
            {
                m_tempBufferC = new RenderTexture(m_bufferC);
                m_tempBufferC.Create();
            }

            if (m_isBufferDSelfAccumulated && m_bufferD != null)
            {
                m_tempBufferD = new RenderTexture(m_bufferD);
                m_tempBufferD.Create();
            }
        }

        protected override void Update()
        {
            base.Update();

            UpdateMateialProperties(m_bufferAMaterial);
            if (m_bufferAMaterial != null && m_bufferA != null)
            {
                //m_bufferAMaterial.SetTexture("_MainTex", m_bufferA);
                Graphics.Blit(m_bufferA, m_tempBufferA, m_bufferAMaterial);
                //m_bufferAMaterial.SetTexture("_MainTex", m_tempBufferA);
                Graphics.Blit(m_tempBufferA, m_bufferA);
            }

            UpdateMateialProperties(m_bufferBMaterial);
            if (m_bufferBMaterial != null && m_bufferB != null)
            {
                //m_bufferBMaterial.SetTexture("_MainTex", Texture2D.blackTexture);
                //m_bufferBMaterial.SetTexture("_SecondTex", m_bufferB);
                Graphics.Blit(m_bufferB, m_tempBufferB, m_bufferBMaterial);
                Graphics.Blit(m_tempBufferB, m_bufferB);
            }

            UpdateMateialProperties(m_bufferCMaterial);
            if (m_bufferCMaterial != null && m_bufferC != null)
            {
                Graphics.Blit(m_bufferC, m_tempBufferC, m_bufferCMaterial);
                Graphics.Blit(m_tempBufferC, m_bufferC);
            }

            UpdateMateialProperties(m_bufferDMaterial);
            if (m_bufferDMaterial != null && m_bufferD != null)
            {
                Graphics.Blit(m_bufferD, m_tempBufferD, m_bufferDMaterial);
                Graphics.Blit(m_tempBufferD, m_bufferD);
            }
        }

//#if UNITY_EDITOR
//        public bool m_debugShowRenderTextures = false;

//        protected void OnGUI()
//        {
//            ShowRenderTextures(m_debugShowRenderTextures);
//        }
//#endif

        public void ShowRenderTextures(bool showRenderTexture)
        {
            if (showRenderTexture)
            {
                if (m_bufferA != null)
                {
                    GUI.DrawTexture(new Rect(0, 0, m_bufferA.width / 4.0f, m_bufferA.height / 4.0f), m_bufferA, ScaleMode.ScaleAndCrop, false);
                }
                if (m_bufferB != null)
                {
                    GUI.DrawTexture(new Rect(0, m_bufferB.height / 4.0f + 1, m_bufferB.width / 4.0f, m_bufferB.height / 4.0f), m_bufferB, ScaleMode.ScaleAndCrop, false);
                }
                if (m_bufferC != null)
                {
                    GUI.DrawTexture(new Rect(0, m_bufferC.height / 2.0f + 2, m_bufferC.width / 4.0f, m_bufferC.height / 4.0f), m_bufferC, ScaleMode.ScaleAndCrop, false);
                }
                if (m_bufferD != null)
                {
                    GUI.DrawTexture(new Rect(0, m_bufferD.height / 2.0f + 2, m_bufferD.width / 4.0f, m_bufferD.height / 4.0f), m_bufferD, ScaleMode.ScaleAndCrop, false);
                }
            }
        }

        protected void OnDestroy()
        {
            if (m_tempBufferA)
            {
                m_tempBufferA.Release();
                m_tempBufferA = null;
            }
            if (m_tempBufferB)
            {
                m_tempBufferB.Release();
                m_tempBufferB = null;
            }
            if (m_tempBufferC)
            {
                m_tempBufferC.Release();
                m_tempBufferC = null;
            }
            if (m_tempBufferD)
            {
                m_tempBufferD.Release();
                m_tempBufferD = null;
            }
        }
    }
}