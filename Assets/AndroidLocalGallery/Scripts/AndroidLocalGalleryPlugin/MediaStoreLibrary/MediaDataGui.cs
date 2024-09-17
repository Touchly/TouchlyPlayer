using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.IO;
using System;

namespace AndroidLocalGalleryPlugin {

	/// <summary>
	/// uGui components which is attached recyclable item prefab.
	/// </summary>
    public class MediaDataGui : MonoBehaviour {

		/// <summary>
		/// The zero quaternion which is used to reset.
		/// </summary>
        private Quaternion zeroQuaternion = Quaternion.Euler(0, 0, 0);

		/// <summary>
		/// The title.
		/// </summary>
        public Text title;

		/// <summary>
		/// The thumbnail.
		/// </summary>
        public RawImage thumbnail;

		/// <summary>
		/// The no image which is used to clear the thumbnail.
		/// </summary>
        public Texture2D noImage;

		/// <summary>
		/// The folder image which is used when the media data is folder.
		/// </summary>
        public Texture2D folderImage;

		/// <summary>
		/// The photo image which is used when the media data is photo type.
		/// </summary>
		public Texture2D photoImage;

		/// <summary>
		/// The video image which is used when the media data is video type.
		/// </summary>
		public Texture2D videoImage;

		/// <summary>
		/// The audio image which is used when the media data is audio type.
		/// </summary>
		public Texture2D audioImage;

		/// <summary>
		/// The other image which is used when the media data is none type.
		/// </summary>
		public Texture2D otherImage;

		/// <summary>
		/// Video icon
		/// </summary>
        public RawImage video;

		/// <summary>
		/// The click button.
		/// </summary>
        public Button clickButton;

		/// <summary>
		/// The default sprite.
		/// </summary>
        public Sprite defaultSprite;

		/// <summary>
		/// The index.
		/// </summary>
        public int index = 0;

		/// <summary>
		/// Sets the data(path) to load thumbnail.
		/// </summary>
		/// <param name="thumbData">Thumb data.</param>
        public void SetData(ThumbData thumbData)
        {
            StartCoroutine(LoadRemoteImage(thumbData));
        }

		/// <summary>
		/// Loads the remote image.
		/// </summary>
		/// <returns>IEnumerator</returns>
		/// <param name="thumbData">Thumb path.</param>
        public IEnumerator LoadRemoteImage(ThumbData thumbData)
        {
            string path = "file://" + thumbData.data;

            // Need to rotate an image which has orientaion info.
            updateRotation(thumbData);
            WWW www = new WWW (path);
            //while(!www.isDone)
            //	yield return null;

            yield return www;

            thumbnail.texture = www.texture;
            // Small heap with fast and frequent garbage collection
            Resources.UnloadUnusedAssets();
        }

		public void SetData(ThumbData thumbData, byte[] data){
			Texture2D texture = new Texture2D(200, 200, TextureFormat.BGRA32, false);
			texture.LoadRawTextureData(data);
			texture.Apply();
			thumbnail.texture = texture;
			// Small heap with fast and frequent garbage collection
			Resources.UnloadUnusedAssets();
		}

		/// <summary>
		/// Clears the image with noImage(Texture2D).
		/// </summary>
        public void ClearImage()
        {
			LoadLocalImage(noImage);
        }

		/// <summary>
		/// Replace the thumbnail to the folderImage(Texture2D).
		/// </summary>
        public void FolderImage()
        {
			LoadLocalImage(folderImage);
        }

		/// <summary>
		/// Replace the thumbnail to the audioImage(Texture2D).
		/// </summary>
		public void AudioImage()
		{
			LoadLocalImage(audioImage);
		}

		/// <summary>
		/// Replace the thumbnail to the otherImage(Texture2D).
		/// </summary>
		public void OtherImage()
		{
			LoadLocalImage(otherImage);
		}

		public void LoadLocalImage(Texture2D texture)
		{
			thumbnail.rectTransform.localRotation = zeroQuaternion;
			thumbnail.texture = texture;
		}

		/// <summary>
		/// Updates the aspect ratio.
		/// </summary>
		/// <param name="width">Width.</param>
		/// <param name="height">Height.</param>
        private void updateAspectRatio(float width, float height) {
            if(0 < width && 0 < height) {
                // Change aspect ratio if width and height values contain.
                if(width < height) {
                    // Vertically longer
                    thumbnail.rectTransform.localScale=new Vector2(1, height/width);
                }else {
                    // Horizontally longer
                    thumbnail.rectTransform.localScale=new Vector2(width/height, 1);
                }
            }else {
                thumbnail.rectTransform.localScale=new Vector2(1,1);
            }
        }

		/// <summary>
		/// Updates the rotation if ThumbData has rotation.
		/// </summary>
		/// <param name="thumbData">Thumb data.</param>
        private void updateRotation(ThumbData thumbData) {
              thumbnail.rectTransform.localRotation = Quaternion.Euler(0, 0, -thumbData.orientation);
        }

    }
}
