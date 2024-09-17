using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Text.RegularExpressions;
using UnityEngine.UI;
using System.Text;

namespace AndroidLocalGalleryPlugin {

	/// <summary>
	/// <para>MediaData provides read access to the result set returned by the AndroidGalleryManager.</para>
	/// <para>Related methods : getFiles, getImageAndVideoFiles, getImageFiles, getVideoFiles and getAllFolders.</para>
	/// </summary>
    public class MediaData : MonoBehaviour {

		/// <summary>
		/// <para>The unique ID for a row.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
		public int id = 0;

		/// <summary>
		/// <para>Path to the file on disk.</para>
		/// <para>Note that apps may not have filesystem permissions to directly access this path.</para>
		/// <para>You need to check runtime permission if you want to access this path</para>
		/// <para>Type: TEXT Base64UTF8String</para>
		/// </summary>
        public string data = "_data";

		/// <summary>
		/// <para>The size of the file in bytes.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
		public int size = 0;

		/// <summary>
		/// <para>The display name of the file.</para>
		/// <para>Type: TEXT Base64UTF8String</para>
		/// </summary>
        public string display_name = "";

		/// <summary>
		/// <para>The title of the content.</para>
		/// <para>Type: TEXT Base64UTF8String</para>
		/// </summary>
        public string title = "title";

		/// <summary>
		/// <para>The time the file was added to the media provider.</para>
		/// <para>Units are seconds since 1970.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
		public long date_added = 0;

		/// <summary>
		/// <para>The time the file was last modified.</para>
		/// <para>Units are seconds since 1970.</para>
		/// <para>NOTE: This is for internal use by the media scanner.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
		public long date_modified = 0;

		/// <summary>
		/// <para>The MIME type of the file.</para>
		/// <para>Type: TEXT</para>
		/// </summary>
        public string mime_type = "mime_type";

		/// <summary>
		/// <para>The media type (audio, video, image or playlist) of the file, or 0 for not a media file</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
		public int media_type = 0;

		/// <summary>
		/// <para>The width of the image/video in pixels.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public int width = 0;

		/// <summary>
		/// <para>The height of the image/video in pixels.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public int height = 0;

		/// <summary>
		/// <para>The orientation for the image expressed as degrees.</para>
		/// <para>Only degrees 0, 90, 180, 270 will work.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public int  orientation = 0;

		/// <summary>
		/// <para>The date and time that the image was taken in units of milliseconds since jan 1, 1970.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
		public long date_taken = 0;

		/// <summary>
		/// <para>The flag is true if data(path) is a directory.</para>
		/// <para>If the flag is false, it's a file.</para>
		/// <para>Checked by native library whether the file denoted by this abstract data is a directory.</para>
		/// <para>Type: BOOL</para>
		/// </summary>
		public bool is_directory = false;

		/// <summary>
		/// Initializes a new instance of the <see cref="AndroidLocalGalleryPlugin.MediaData"/> class.
		/// </summary>
        public MediaData() {
        }

		/// <summary>
		/// Convert from string[] to MediaData. 
		/// </summary>
		/// <returns>MediaData</returns>
		/// <param name="array">String result array.</param>
        public MediaData updateDataWithArrayString(string[] array) {
       
            int len = array.Length;
            for(int i = 0; i < len; i++) {
                string[] array2 = Regex.Split(array[i], "&div.;");
				if (FileColumns._ID == array2 [0]) {
					id = int.Parse (array2 [1]);
				} else if (FileColumns.DATA == array2 [0]) {
					data = encodeBase64ToString (array2 [1]);
				} else if (FileColumns.SIZE == array2 [0]) {
					size = int.Parse (array2 [1]);
				} else if (FileColumns.DISPLAY_NAME == array2 [0]) {
					display_name = encodeBase64ToString (array2 [1]);
				} else if (FileColumns.TITLE == array2 [0]) {
					title = encodeBase64ToString (array2 [1]);
				} else if (FileColumns.DATE_ADDED == array2 [0]) {
					date_added = long.Parse (array2 [1]);
				} else if (FileColumns.DATE_MODIFIED == array2 [0]) {
					date_modified = long.Parse (array2 [1]);
				} else if (FileColumns.MIME_TYPE == array2 [0]) {
					mime_type = array2 [1];
				} else if (FileColumns.MEDIA_TYPE == array2 [0]) {
					media_type = int.Parse (array2 [1]);
				} else if (FileColumns.WIDTH == array2 [0]) {
					try { 
						width = int.Parse (array2 [1]);
					} catch (Exception e) {
						width = 0;
						//Debug.LogException (e);
					}
				} else if (FileColumns.HEIGHT == array2 [0]) {
					try { 
						height = int.Parse (array2 [1]);
					} catch (Exception e) {
						height = 0;
						//Debug.LogException (e);
					}
				} else if (FileColumns.ORIENTATION == array2 [0]) {
					orientation = int.Parse (array2 [1]);
				} else if (FileColumns.DATE_TAKEN == array2 [0]) {
					date_taken = long.Parse (array2 [1]);
				} else if (FileColumns.IS_DIRECTORY == array2 [0]) {
					try { 
						is_directory = bool.Parse (array2 [1]);
					} catch (Exception e) {
						is_directory = false;
						//Debug.LogException (e);
					}
				}
            }

            return this;
        }

		/// <summary>
		/// Updates the this.mediaData with mediaData.
		/// </summary>
		/// <param name="mediaData">MediaData</param>
        public void updateDataWithMediaData(MediaData mediaData) {
       
            id = mediaData.id;
            data = mediaData.data;
            size = mediaData.size;
            display_name = mediaData.display_name;
            title = mediaData.title;
			date_added = mediaData.date_added;
			date_modified = mediaData.date_modified;
			mime_type = mediaData.mime_type;
			width = mediaData.width;
			height = mediaData.height;
            media_type = mediaData.media_type;
			orientation = mediaData.orientation;
			date_taken = mediaData.date_taken;
        }

        private string encodeBase64ToString(string encodedText) {
            byte[] decodedBytes = Convert.FromBase64String (encodedText);
            return Encoding.UTF8.GetString (decodedBytes);
        }
    }

}