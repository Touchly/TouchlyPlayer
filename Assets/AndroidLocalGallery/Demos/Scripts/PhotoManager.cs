using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AndroidLocalGalleryPlugin;
using System;

public class PhotoManager : MonoBehaviour {
    
    public Text displayName;
    private RawImage image;
  
    public void SetData(MediaData mediaData)
    {
        if(image == null) {
            image = gameObject.GetComponent<RawImage>();
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
        displayName.text += dateTime.ToString("yyyy/MM/dd")+" "+ dateTime.ToString("HH:mm:ss");
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
        StartCoroutine(LoadRemoteImage(mediaData));
    }


    public IEnumerator LoadRemoteImage(MediaData mediaData)
    {
        string path = "file://" + mediaData.data;

        updateRotation(mediaData);
        WWW www = new WWW (path);
		while(!www.isDone)
			yield return null;

        updateAspectRatio(www.texture.width, www.texture.height);
		image.texture = www.texture;
        Resources.UnloadUnusedAssets();
    }

    private void updateAspectRatio(float width, float height) {

        // Check both of the data to cover irregular problem.
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

    // Reset and close screen.
    public void close() {
        
        DestroyImmediate(image.texture);
        Resources.UnloadUnusedAssets();
        transform.parent.parent.parent.gameObject.SetActive(false);
        image.rectTransform.localScale=new Vector2(1,1);
        displayName.text = "";
    }

}
