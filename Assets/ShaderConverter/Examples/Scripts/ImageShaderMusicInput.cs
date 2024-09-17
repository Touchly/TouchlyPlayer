using UnityEngine;

namespace ReformSim
{
    public class ImageShaderMusicInput : MonoBehaviour
    {
        public AudioSource m_audioSource;

        [Tooltip("Number of values (the length of the samples array provided) must be a power of 2. (ie 128/256/512 etc).")]
        [Range(64, 8192)]
        public int m_sampleNum = 512;

        [Tooltip("Use window to reduce leakage between frequency bins/bands. Note, the more complex window type, the better the quality, but reduced speed.")]
        public FFTWindow m_fftWindow = FFTWindow.BlackmanHarris;

        public enum TextureNameType
        {
            MainTex,
            SecondTex,
            ThirdTex,
            FourthTex,
        }

        public TextureNameType m_textureNameType = TextureNameType.MainTex;
        protected string m_textureName;

        public float m_iSampleRate = 44100;

        public float m_frequencyMultiplier = 100f;
        public float m_amplitudeMultiplier = 1.0f;

        protected float[] m_spectrumData;
        protected Color[] m_spectrumColorArray;
        protected float[] m_amplitudeData;
        protected Color[] m_amplitudeColorArray;

        public Texture2D m_audioDataTex;
        public FilterMode m_texFilterMode;

        public Material m_material = null;

        protected void Start()
        {
            if (m_audioSource == null)
            {
                m_audioSource = GetComponent<AudioSource>();
            }

            if (m_audioSource == null)
            {
                Debug.LogError("Error: Please assign a AudioSource component first!", this);
                return;
            }

            if (m_audioSource.clip == null)
            {
                Debug.LogError("Error: Please assign a clip to the AudioSource component first!", this);
                return;
            }

            m_iSampleRate = m_audioSource.clip.frequency;

            m_spectrumData = new float[m_sampleNum];
            m_spectrumColorArray = new Color[m_sampleNum];
            m_amplitudeData = new float[m_sampleNum];
            m_amplitudeColorArray = new Color[m_sampleNum];

            m_audioDataTex = new Texture2D(m_sampleNum, 2, TextureFormat.R16, false, true);
            m_audioDataTex.filterMode = m_texFilterMode;

            if (m_material == null)
            {
                Renderer render = GetComponent<Renderer>();
                m_material = render.material;
            }

            m_textureName = "_" + m_textureNameType.ToString();
            m_material.SetTexture(m_textureName, m_audioDataTex);
        }

        protected void Update()
        {
            if (m_audioSource == null || m_audioSource.clip == null)
            {
                return;
            }

            if (m_material.HasProperty("_iSampleRate"))
            {
                m_material.SetFloat("_iSampleRate", m_iSampleRate);
            }

            if (m_material.HasProperty("_iChannelTime"))
            {
                float[] channelTimeArray = new float[] { m_audioSource.time, m_audioSource.time, m_audioSource.time, m_audioSource.time };
                m_material.SetFloatArray("_iChannelTime", channelTimeArray);
            }

            m_audioSource.GetSpectrumData(m_spectrumData, 0, m_fftWindow);
            m_audioSource.GetOutputData(m_amplitudeData, 0);

            for (int i = 0; i < m_spectrumData.Length; i++)
            {
                Color c = new Color(m_spectrumData[i] * m_frequencyMultiplier, 0, 0);
                //m_audioDataTex.SetPixel(i, 0, c);
                m_spectrumColorArray[i] = c;
            }
            m_audioDataTex.SetPixels(0, 0, m_sampleNum, 1, m_spectrumColorArray, 0);

            for (int i = 0; i < m_amplitudeData.Length; i++)
            {
                Color c = new Color(m_amplitudeData[i] * m_amplitudeMultiplier, 0, 0);
                //m_audioDataTex.SetPixel(i, 1, c);
                m_amplitudeColorArray[i] = c;
            }
            m_audioDataTex.SetPixels(0, 1, m_sampleNum, 1, m_amplitudeColorArray, 0);
            
            m_audioDataTex.Apply();
        }

#if UNITY_EDITOR
        public bool m_debugShowRenderTextures = false;

        protected void OnGUI()
        {
            ShowRenderTextures(m_debugShowRenderTextures);
        }
#endif

        public void ShowRenderTextures(bool showRenderTexture)
        {
            if (showRenderTexture)
            {
                if (m_audioDataTex != null)
                {
                    GUI.DrawTexture(new Rect(0, 100, m_audioDataTex.width*2, m_audioDataTex.height*100), m_audioDataTex, ScaleMode.ScaleAndCrop, false);
                }
            }
        }

        protected void OnDestroy()
        {
            Destroy(m_audioDataTex);
        }
    }
}