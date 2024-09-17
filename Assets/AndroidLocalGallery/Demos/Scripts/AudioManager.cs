using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.UI;
using AndroidLocalGalleryPlugin;
using System;

public class AudioManager : MonoBehaviour {

    public Text displayName;
    private AudioSource audioSource;
	
    public void Playback(MediaData mediaData) {

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
        StartCoroutine(playbackAudio(mediaData));
    }

    IEnumerator playbackAudio(MediaData mediaData)
    {
        string url = "file://" + mediaData.data;

		var www = new WWW (url);

		AudioClip audioClip= www.GetAudioClip();
		while (!audioClip.isReadyToPlay)
			yield return www;

		audioSource.clip = audioClip;

        //Play Sound
        audioSource.Play();

		while (audioSource.isPlaying)
        {
			// Debug.LogWarning("Audio Time: " + Mathf.FloorToInt((float)audioSource.time));
            yield return null;
        }
    }

    public void Play() {
        //Play Sound
        audioSource.Play();
    }

    public void Pause() {
        //Pause Sound
        audioSource.Pause();
    }

    // Stop, reset and close screen.
    public void Stop() {

		//Stop Sound
		audioSource.Stop();
		DestroyImmediate(audioSource.clip);
		Resources.UnloadUnusedAssets();
		audioSource.clip = null;
        transform.parent.parent.parent.gameObject.SetActive(false);
        displayName.text = "";
    }
}