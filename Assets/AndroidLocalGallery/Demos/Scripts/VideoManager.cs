using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.UI;
using AndroidLocalGalleryPlugin;
using System;

public class VideoManager : MonoBehaviour {

    public Text displayName;
    private RawImage image;
    private VideoPlayer videoPlayer;
    private AudioSource audioSource;
	
    public void Playback(MediaData mediaData) {

        if(image == null) {
            image = gameObject.GetComponent<RawImage>();
        }
        //Get VideoPlayer from the GameObject
        if(videoPlayer == null) {
            videoPlayer = gameObject.GetComponent<VideoPlayer>();
        }
        //Get AudioSource
        if(audioSource == null) {
            audioSource = gameObject.GetComponent<AudioSource>();
        }

		displayName.text = "name:"+mediaData.display_name;
		displayName.text += "\n";
		displayName.text += "mimeType:"+mediaData.mime_type;
		displayName.text += "\n";
		displayName.text += "is_directory:"+mediaData.is_directory;
		displayName.text += "\n";
		displayName.text += mediaData.size+"bytes";
        displayName.text += "\n";
        displayName.text += "date_taken:";
        displayName.text += "\n";
        DateTime dateTime = UnixTime.GetDateTime(mediaData.date_taken);
        displayName.text += dateTime.ToString("yyyy/MM/dd") + " " + dateTime.ToString("HH:mm:ss");
        displayName.text += "\n";
        displayName.text += "date_added:";
        displayName.text += "\n";
        dateTime = UnixTime.GetDateTime(mediaData.date_added);
        displayName.text += dateTime.ToString("yyyy/MM/dd") + " " + dateTime.ToString("HH:mm:ss");
        displayName.text += "\n";
        displayName.text += "date_modified:";
        displayName.text += "\n";
        dateTime = UnixTime.GetDateTime(mediaData.date_modified);
        displayName.text += dateTime.ToString("yyyy/MM/dd") + " " + dateTime.ToString("HH:mm:ss");
        StartCoroutine(playbackVideo(mediaData));
    }

    IEnumerator playbackVideo(MediaData mediaData)
    {
        string url = "file://" + mediaData.data;

        updateRotation(mediaData);

        //Disable Play on Awake for both Video and Audio
        videoPlayer.playOnAwake = false;
        audioSource.playOnAwake = false;
        audioSource.Pause();

        // Vide clip from Url
        videoPlayer.url = url;
        //videoPlayer.aspectRatio = VideoPlayer.fit

        //Set Audio Output to AudioSource
        videoPlayer.audioOutputMode = VideoAudioOutputMode.AudioSource;

        //Assign the Audio from Video to AudioSource to be played
        videoPlayer.EnableAudioTrack(0, true);
        videoPlayer.SetTargetAudioSource(0, audioSource);

        //prepare Audio to prevent Buffering
        videoPlayer.Prepare();

        //Wait until video is prepared
        WaitForSeconds waitTime = new WaitForSeconds(1);
        while (!videoPlayer.isPrepared)
        {
            //Prepare/Wait for 5 sceonds only
            yield return waitTime;
            //Break out of the while loop after 5 seconds wait
            break;
        }

        //Assign the Texture from Video to RawImage to be displayed
        updateAspectRatio(videoPlayer.texture.width, videoPlayer.texture.height);
        image.texture = videoPlayer.texture;

        //Play Video
        videoPlayer.Play();

        //Play Sound
        audioSource.Play();

        while (videoPlayer.isPlaying)
        {
            //Debug.LogWarning("Video Time: " + Mathf.FloorToInt((float)videoPlayer.time));
            yield return null;
        }
    }

    private void updateAspectRatio(float width, float height) {

        if(0 < width && 0 < height) {
            // Change aspect ratio if width and height values contain.
            if(width < height) {
                // Vertically longer
                image.rectTransform.localScale=new Vector2(1, height/width);
            }else {
                // Horizontally longer
                image.rectTransform.localScale=new Vector2(width/height, 1);
            }
            
        }else {
            image.rectTransform.localScale=new Vector2(1,1);
        }
    }

    private void updateRotation(MediaData mediaData) {
        image.rectTransform.localRotation = Quaternion.Euler(0, 0, -mediaData.orientation);
    }

    public void Play() {
        
        if(videoPlayer.isPrepared) {
            //Play Video
            videoPlayer.Play();
            //Play Sound
            audioSource.Play();
        }
    }

    public void Pause() {

        if(videoPlayer.isPrepared) {
            //Pause Video
            videoPlayer.Pause();
            //Pause Sound
            audioSource.Pause();
        }
    }

    // Stop, reset and close screen.
    public void Stop() {

        if(videoPlayer.isPrepared) {
            //Stop Video
            videoPlayer.Stop();
            //Stop Sound
            audioSource.Stop();
        }
        transform.parent.parent.parent.gameObject.SetActive(false);
        image.rectTransform.localScale=new Vector2(1,1);
        displayName.text = "";
    }
}