using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace AndroidLocalGalleryPlugin {
	
	/// <summary>
	/// Common fields for most MediaProvider tables.
	/// </summary>
    public class FileColumns : MonoBehaviour {

		/// <summary>
		/// <para>Index position.</para>
		/// <para>This position is a value which is managed by the Controller Script of Unity to find certain childItem to attach thumbnail.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
		public static readonly string POSITION = "position";

		/// <summary>
		/// <para>The unique ID for a row.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
        public readonly static string _ID = "_id";

		/// <summary>
		/// <para>Path to the file on disk.</para>
		/// <para>Note that apps may not have filesystem permissions to directly access this path.</para>
		/// <para>You need to check runtime permission if you want to access this path</para>
		/// <para>Type: TEXT</para>
		/// </summary>
        public static readonly string DATA = "_data";

		/// <summary>
		/// <para>The size of the file in bytes.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
        public static readonly string SIZE = "_size";

		/// <summary>
		/// <para>The display name of the file.</para>
		/// <para>Type: TEXT</para>
		/// </summary>
        public static readonly string DISPLAY_NAME = "_display_name";

		/// <summary>
		/// <para>The title of the content.</para>
		/// <para>Type: TEXT</para>
		/// </summary>
        public static readonly string TITLE = "title";

		/// <summary>
		/// <para>The time the file was added to the media provider.</para>
		/// <para>Units are seconds since 1970.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
        public static readonly string DATE_ADDED = "date_added";

		/// <summary>
		/// <para>The time the file was last modified.</para>
		/// <para>Units are seconds since 1970.</para>
		/// <para>NOTE: This is for internal use by the media scanner.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
        public static readonly string DATE_MODIFIED = "date_modified";

		/// <summary>
		/// <para>The MIME type of the file.</para>
		/// <para>Type: TEXT</para>
		/// </summary>
        public static readonly string MIME_TYPE = "mime_type";

		/// <summary>
		/// <para>The width of the image/video in pixels.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly string WIDTH = "width";

		/// <summary>
		/// <para>The height of the image/video in pixels.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly string HEIGHT = "height";

		/// <summary>
		/// <para>The index of the parent directory of the file.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly string PARENT = "parent";

		/// <summary>
		/// <para>The media type (audio, video, image or playlist) of the file, or 0 for not a media file</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly string MEDIA_TYPE = "media_type";

		/// <summary>
		/// <para>Constant for the {@link #MEDIA_TYPE} column indicating that file is not an audio, image, video or playlist file.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly int MEDIA_TYPE_NONE = 0;

		/// <summary>
		/// <para>Constant for the {@link #MEDIA_TYPE} column indicating that file is an image file.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly int MEDIA_TYPE_IMAGE = 1;

		/// <summary>
		/// <para>Constant for the {@link #MEDIA_TYPE} column indicating that file is an audio file.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly int MEDIA_TYPE_AUDIO = 2;

		/// <summary>
		/// <para>Constant for the {@link #MEDIA_TYPE} column indicating that file is a video file.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly int MEDIA_TYPE_VIDEO = 3;

		/// <summary>
		/// <para>Constant for the {@link #MEDIA_TYPE} column indicating that file is a playlist file.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly int MEDIA_TYPE_PLAYLIST = 4;

		/// <summary>
		/// <para>The original image for the thumbnal.</para>
		/// <para>Type: INTEGER (ID from Image table)</para>
		/// </summary>
        public static readonly string IMAGE_ID = "image_id";

		/// <summary>
		/// <para>The original image for the thumbnal.</para>
		/// <para>Type: INTEGER (ID from Video table)</para>
		/// </summary>
        public static readonly string VIDEO_ID = "video_id";

		/// <summary>
		/// <para>The kind of the thumbnail.</para>
		/// <para>Type: INTEGER (One of the values below)</para>
		/// </summary>
        public static readonly string KIND = "kind";

		/// <summary>
		/// One of the kinds of thumbnail.
		/// </summary>
		public static readonly int MINI_KIND = 1;

		/// <summary>
		/// One of the kinds of thumbnail. This kind is not recommended to use.
		/// </summary>
		public static readonly int FULL_SCREEN_KIND = 2;

		/// <summary>
		/// One of the kinds of thumbnail. This kind is not recommended to use.
		/// </summary>
		public static readonly int MICRO_KIND = 3;

		/// <summary>
		/// <para>The description of the image.</para>
		/// <para>Type: TEXT</para>
		/// </summary>
        public static readonly string DESCRIPTION = "description";

		/// <summary>
		/// <para>Whether the video should be published as public or private.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly string IS_PRIVATE = "isprivate";

		/// <summary>
		/// <para>The latitude where the image was captured.</para>
		/// <para>Type: DOUBLE</para>
		/// </summary>
        public static readonly string LATITUDE = "latitude";

		/// <summary>
		/// <para>The longitude where the image was captured.</para>
		/// <para>Type: DOUBLE</para>
		/// </summary>
        public static readonly string LONGITUDE = "longitude";

		/// <summary>
		/// <para>The date and time that the image was taken in units of milliseconds since jan 1, 1970.</para>
		/// <para>Type: INTEGER (long)</para>
		/// </summary>
        public static readonly string DATE_TAKEN = "datetaken";

		/// <summary>
		/// <para>The orientation for the image expressed as degrees.</para>
		/// <para>Only degrees 0, 90, 180, 270 will work.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly string ORIENTATION = "orientation";

		/// <summary>
		/// <para>The mini thumb id.</para>
		/// <para>Type: INTEGER</para>
		/// </summary>
        public static readonly string MINI_THUMB_MAGIC = "mini_thumb_magic";

		/// <summary>
		/// <para>The flag indicates whether data(path) is a directory or file.</para>
		/// <para>Type: BOOL</para>
		/// </summary>
		public static readonly string IS_DIRECTORY = "is_directory";
    }
}
