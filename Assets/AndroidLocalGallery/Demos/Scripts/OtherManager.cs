using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.UI;
using AndroidLocalGalleryPlugin;
using System;
using System.IO;
public class OtherManager : MonoBehaviour {

    public Text displayName;
	
    public void Playback(MediaData mediaData) {
		string path = "file://" + mediaData.data;
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
    }

	// Reset and close screen.
	public void close() {
		transform.parent.parent.parent.gameObject.SetActive(false);
		displayName.text = "";
	}

}