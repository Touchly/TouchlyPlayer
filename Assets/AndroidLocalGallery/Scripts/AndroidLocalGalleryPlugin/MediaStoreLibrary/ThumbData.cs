using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Text.RegularExpressions;
using System.Text;

namespace AndroidLocalGalleryPlugin {

	/// <summary>
	/// <para>ThumbData provides read access to the result set returned by the AndroidGalleryManager.</para>
	/// <para>Related method : getThumbnailPath.</para>
	/// </summary>
    public class ThumbData : MonoBehaviour {

		/// <summary>
		/// <para>Index position.</para>
		/// <para>This position is a value which is managed by the Controller Script of Unity to find certain childItem to attach thumbnail.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public int position = 0;

		/// <summary>
		/// <para>The unique ID for a row.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
        public int id = 0;

		/// <summary>
		/// <para>The count of rows in a directory.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
		public int count = 0;

		/// <summary>
		/// <para>Path to the thumbnail file on disk.</para>
		/// <para>Note that apps may not have filesystem permissions to directly access this path.</para>
		/// <para>You need to check runtime permission if you want to access this path</para>
		/// <para>Type: TEXT Base64UTF8String</para>
		/// </summary>
		public string data = null;

		/// <summary>
		/// <para>The original image for the thumbnal.</para>
		/// <para>Type: INTEGER (ID from Image table)</para>
		/// </summary>
        public int image_id = 0;

		/// <summary>
		/// <para>The original image for the thumbnal.</para>
		/// <para>Type: INTEGER (ID from Video table)</para>
		/// </summary>
        public int video_id = 0;

		/// <summary>
		/// <para>The kind of the thumbnail.</para>
		/// <para>Type: INTEGER (One of the values below)</para>
		/// </summary>
        public int kind = 1;

		/// <summary>
		/// <para>The width of the thumbnal.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public int width = 0;

		/// <summary>
		/// <para>The height of the thumbnail.</para>
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
		/// Initializes a new instance of the <see cref="AndroidLocalGalleryPlugin.ThumbData"/> class.
		/// </summary>
        public ThumbData() {
        }

		/// <summary>
		/// Convert from string[] to ThumbData. 
		/// </summary>
		/// <returns>ThumbData</returns>
		/// <param name="array">String result array.</param>
        public ThumbData updateDataWithArrayString(string[] array)
        {

            int len = array.Length;
            for (int i = 0; i < len; i++)
            {
                string[] array2 = Regex.Split(array[i], "&div.;");
				if (FileColumns.POSITION == array2[0])
				{
					position = int.Parse(array2[1]);
				}
				else if (FileColumns._ID == array2[0])
                {
					id = int.Parse(array2[1]);
                }
				else if (FileColumns.DATA == array2[0])
				{
					data = encodeBase64ToString(array2[1]);
				}
                else if (FileColumns.IMAGE_ID == array2[0])
                {
					image_id = int.Parse(array2[1]);
                }
                else if (FileColumns.VIDEO_ID == array2[0])
                {
					video_id = int.Parse(array2[1]);
                }
                else if (FileColumns.KIND == array2[0])
                {
					kind = int.Parse(array2[1]);
                }
                else if (FileColumns.WIDTH == array2[0])
                {
					width = int.Parse(array2[1]);
                }
                else if (FileColumns.HEIGHT == array2[0])
                {
					height = int.Parse(array2[1]);
                }
                else if (FileColumns.ORIENTATION == array2[0])
                {
					orientation = int.Parse(array2[1]);
                }
            }

            return this;
        }

		/// <summary>
		/// Updates the this.thumbData with thumbData.
		/// </summary>
		/// <param name="thumbData">ThumbData</param>
        public void updateDataWithThumbData(ThumbData thumbData) {
       
			position = thumbData.position;
            id = thumbData.id;
            count = thumbData.count;
			data = thumbData.data;
            image_id = thumbData.image_id;
            video_id = thumbData.video_id;
            kind = thumbData.kind;
            width = thumbData.width;
            height = thumbData.height;
            orientation = thumbData.orientation;
        }

        private string encodeBase64ToString(string encodedText) {
            byte[] decodedBytes = Convert.FromBase64String (encodedText);
            return Encoding.UTF8.GetString (decodedBytes);
        }
    }
}