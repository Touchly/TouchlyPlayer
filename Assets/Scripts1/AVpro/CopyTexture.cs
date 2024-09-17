using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using RenderHeads.Media.AVProVideo;
using UnityEngine.Events;

public class CopyTexture : MonoBehaviour
{
    public RenderTexture DepthTex, DepthTexMono, Video; //Video;
    public MediaPlayer mediaPlayer;
    public bool renderFull;
    private bool mono = false;
    private bool preprocessed;
    private int startingX, widthX, sizeX;
    private Texture mediaTex;
    private Vector2 scale, offset, offsetMono, scaleBack, offsetBack;
    //public UnityEvent<Texture> sendTexture;
    public CurrentVideo currentVideo;
    public GeneralSettings generalSettings;
    [SerializeField] Transform depthMesh, display;


    void OnEnable()
    {
        if (currentVideo.format == 0 || !generalSettings.premium){
            #if UNITY_ANDROID && !UNITY_EDITOR
            scale = new Vector2(1f / 3f, -1f);
            offset = new Vector2(2f / 3f, 1f);
            #else
            scale = new Vector2(1f / 3f, 1f);
            offset = new Vector2(2f / 3f, 0f);
            #endif
        } else if (currentVideo.format == 1 || currentVideo.format==3) {
            #if UNITY_ANDROID && !UNITY_EDITOR
            scale = new Vector2(1f, -0.5f);
            offset = new Vector2(0f , 0.5f);
            #else
            scale = new Vector2(1f, 0.5f);
            offset = new Vector2(0f , 0.5f);
            #endif
        } else if (currentVideo.format == 2) {
            #if UNITY_ANDROID && !UNITY_EDITOR
            scale = new Vector2(1f/2f, -1f/2f);
            offset = new Vector2(1f/2f, 1f);
            scaleBack = new Vector2(1f / 2f, -1f/2f);
            offsetBack = new Vector2(1f/2f, 1f/2f);
            #else
            scaleBack = new Vector2(1f / 2f, 1f/2f);
            offsetBack = new Vector2(1f /2f, 1f/2f);
            scale = new Vector2(1f / 2f, 1f/2f);
            offset = new Vector2(1f/2f, 0);
            #endif
        } else if (currentVideo.format==4) {
            #if UNITY_ANDROID && !UNITY_EDITOR
            scale = new Vector2(0.5f, -1f);
            offset = new Vector2(0f , 1f);
            #else
            scale = new Vector2(0.5f, 0f);
            offset = new Vector2(0f , 0f);
            #endif
        }
        
        offsetMono = new Vector2(1f / 3f, 0f);
    }

    public void HandleEvent(MediaPlayer mp, MediaPlayerEvent.EventType eventType, ErrorCode code)
    {
        if(eventType== MediaPlayerEvent.EventType.FirstFrameReady){
            Texture testTex = mp.TextureProducer.GetTexture();

            depthMesh.localScale = new Vector3(depthMesh.localScale.x*testTex.width/testTex.height, depthMesh.localScale.y, 1f);
            display.localScale = new Vector3(display.localScale.x*testTex.width/testTex.height, display.localScale.y, 1f);

            Debug.Log(testTex.width);
            Debug.Log(testTex.height);
        }
    }

    void Update()
    {
        mediaTex = mediaPlayer.TextureProducer.GetTexture();

        if (currentVideo.preprocessed)
        {
            if (currentVideo.format!= 4){
                Graphics.Blit(mediaTex, DepthTex, scale, offset);
            }
            
            if (currentVideo.format==2)
            {
            Graphics.Blit(mediaTex, DepthTexMono, scaleBack , offsetBack);
            }
        }
        
        else
        {
            if (renderFull){
                #if UNITY_ANDROID && !UNITY_EDITOR
                Graphics.Blit(mediaTex,Video);
                #else
                Graphics.Blit(mediaTex, Video, new Vector2(1,-1), new Vector2(0, 1));
                #endif
            }
        }
    }

    public void RenderMono(bool _mono)
    {
        mono = _mono;
    }

}
