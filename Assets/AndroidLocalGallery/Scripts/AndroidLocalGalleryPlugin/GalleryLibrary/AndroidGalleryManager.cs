using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Text.RegularExpressions;

namespace AndroidLocalGalleryPlugin {
	
	/// <summary>
	/// This class plays a role to contact with native library through Android Java object.
	/// </summary>
    public class AndroidGalleryManager : MonoBehaviour {

		/// <summary>
		/// <para>Call back the number of maximum count.</para>
		/// <para>Related methods : getImageAndVideoFilesMaxCount, getImageFilesMaxCount, getVideoFilesMaxCount and getAllFoldersMaxCount.</para>
		/// </summary>
        public delegate void onMediaMaxCountCallback(int maxCount);

		/// <summary>
		/// <para>Call back the MediaData[] result.</para>
		/// <para>Related methods : getImageAndVideoFiles, getImageFiles, getVideoFiles and getAllFolders.</para>
		/// </summary>
        public delegate void onMediaCallback(MediaData[] results);

		/// <summary>
		/// <para>Call back the ThumbData[] result.</para>
		/// <para>Related method : getThumbnailPath.</para>
		/// </summary>
        public delegate void onThumbCallback(ThumbData[] results);

		/// <summary>
		/// <para>All Android devices have two file storage areas.</para>
		/// <para>Virtual external storage is common on modern Android phones.</para>
		/// </summary>
		public readonly string STORAGE_EXTERNAL = "external";

		/// <summary>
		/// <para>All Android devices have two file storage areas.</para>
		/// <para>Internal storage is not common on modern Android phones.</para>
		/// <para>We guess that it will never be used in general project.</para>
		/// </summary>
		public readonly string STORAGE_INTERNAL = "internal";

		/// <summary>
		/// The media mex count callback.
		/// </summary>
        private onMediaMaxCountCallback mediaMaxCountCallback;

		/// <summary>
		/// The media callback.
		/// </summary>
        private onMediaCallback mediaCallback;

		/// <summary>
		/// The thumb callback.
		/// </summary>
        private onThumbCallback thumbCallback;

		/// <summary>
		/// The projection.
		/// </summary>
		private string[] projection = { FileColumns._ID, FileColumns.SIZE, FileColumns.DATA, FileColumns.TITLE, FileColumns.DISPLAY_NAME, FileColumns.DATE_ADDED, FileColumns.DATE_MODIFIED, FileColumns.DATE_TAKEN, FileColumns.MIME_TYPE, FileColumns.MEDIA_TYPE, FileColumns.WIDTH, FileColumns.HEIGHT, FileColumns.ORIENTATION };

		/// <summary>
		/// <para>Gets the files max count.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		/// 
		public void getFilesMaxCount(string folderDir, int[] mediaTypes, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			getFilesMaxCount (STORAGE_EXTERNAL, folderDir, mediaTypes, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the files max count.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="mimeTypes">Mime types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		/// 
		public void getFilesMaxCount(string folderDir, int[] mediaTypes, string[] mimeTypes, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			getFilesMaxCount (STORAGE_EXTERNAL, folderDir, mediaTypes, mimeTypes, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the files max count.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getFilesMaxCount(string storage, string folderDir, int[] mediaTypes, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			mediaMaxCountCallback = callback;
			try {
				#if UNITY_ANDROID
				AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
				androidGalleryBridge.CallStatic("getFilesMaxCount", storage, folderDir, mediaTypes); // It will call MediaNativeMaxCountCallback
				#endif
			}catch (Exception ex)
			{
				Debug.LogException(ex);
			}
		}

		/// <summary>
		/// <para>Gets the files max count.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="mimeTypes">Mime types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getFilesMaxCount(string storage, string folderDir, int[] mediaTypes, string[] mimeTypes, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			mediaMaxCountCallback = callback;
			try {
				#if UNITY_ANDROID
				AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
				androidGalleryBridge.CallStatic("getFilesMaxCount", storage, folderDir, mediaTypes, mimeTypes); // It will call MediaNativeMaxCountCallback
				#endif
			}catch (Exception ex)
			{
				Debug.LogException(ex);
			}
		}

		/// <summary>
		/// <para>Gets the files.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getFiles(string folderDir, int[] mediaTypes, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			getFiles (STORAGE_EXTERNAL, folderDir, mediaTypes, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the files.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="mimeTypes">Mime types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getFiles(string folderDir, int[] mediaTypes, string[] mimeTypes, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			getFiles (STORAGE_EXTERNAL, folderDir, mediaTypes, mimeTypes, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the files.</para>
		/// <para>You will get the result through callback.</para>]
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getFiles(string storage, string folderDir, int[] mediaTypes, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			mediaCallback = callback;
			try {
				#if UNITY_ANDROID
				AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
				androidGalleryBridge.CallStatic("getFiles", storage, folderDir, mediaTypes, projection, sortOrder, offset, limit); // It will call MediaNativeCallback
				#endif
			}catch (Exception ex)
			{
				Debug.LogException(ex);
			}
		}

		/// <summary>
		/// <para>Gets the files.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="mimeTypes">Mime types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getFiles(string storage, string folderDir, int[] mediaTypes, string[] mimeTypes, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			mediaCallback = callback;
			try {
				#if UNITY_ANDROID
				AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
				androidGalleryBridge.CallStatic("getFiles", storage, folderDir, mediaTypes, mimeTypes, projection, sortOrder, offset, limit); // It will call MediaNativeCallback
				#endif
			}catch (Exception ex)
			{
				Debug.LogException(ex);
			}
		}

		/// <summary>
		/// <para>Gets the image and video files max count.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getImageAndVideoFilesMaxCount(string folderDir, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			getImageAndVideoFilesMaxCount (STORAGE_EXTERNAL, folderDir, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the image and video files max count.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getImageAndVideoFilesMaxCount(string storage, string folderDir, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
        {
			mediaMaxCountCallback = callback;
            try {
            #if UNITY_ANDROID
                AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
                androidGalleryBridge.CallStatic("getImageAndVideoFilesMaxCount", storage, folderDir); // It will call MediaNativeMaxCountCallback
            #endif
            }catch (Exception ex)
            {
                Debug.LogException(ex);
            }
        }

		/// <summary>
		/// <para>Gets the image and video files.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getImageAndVideoFiles(string folderDir, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			getImageAndVideoFiles (STORAGE_EXTERNAL, folderDir, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the image and video files.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getImageAndVideoFiles(string storage, string folderDir, string sortOrder, int offset, int limit, onMediaCallback callback)
        {
            mediaCallback = callback;
            try {
            #if UNITY_ANDROID
                AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
                androidGalleryBridge.CallStatic("getImageAndVideoFiles", storage, folderDir, projection, sortOrder, offset, limit); // It will call MediaNativeCallback
            #endif
            }catch (Exception ex)
            {
                Debug.LogException(ex);
            }
        }

		/// <summary>
		/// <para>Gets the image files max count.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getImageFilesMaxCount(string folderDir, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			getImageFilesMaxCount (STORAGE_EXTERNAL, folderDir, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the image files max count.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getImageFilesMaxCount(string storage, string folderDir, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
        {
			mediaMaxCountCallback = callback;
            try {
            #if UNITY_ANDROID
                AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
                androidGalleryBridge.CallStatic("getImageFilesMaxCount", storage, folderDir); // It will call MediaNativeMaxCountCallback
            #endif
            }catch (Exception ex)
            {
                Debug.LogException(ex);
            }
        }

		/// <summary>
		/// <para>Gets the image files.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getImageFiles(string folderDir, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			getImageFiles (STORAGE_EXTERNAL, folderDir, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the image files.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getImageFiles(string storage, string folderDir, string sortOrder, int offset, int limit, onMediaCallback callback)
        {
            mediaCallback = callback;
            try {
            #if UNITY_ANDROID
                AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
                androidGalleryBridge.CallStatic("getImageFiles", storage, folderDir, projection, sortOrder, offset, limit); // It will call MediaNativeCallback
            #endif
            }catch (Exception ex)
            {
                Debug.LogException(ex);
            }
        }

		/// <summary>
		/// <para>Gets the video files max count.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getVideoFilesMaxCount(string folderDir, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			getVideoFilesMaxCount (STORAGE_EXTERNAL, folderDir, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the video files max count.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getVideoFilesMaxCount(string storage, string folderDir, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
        {
			mediaMaxCountCallback = callback;
            try {
            #if UNITY_ANDROID
                AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
                androidGalleryBridge.CallStatic("getVideoFilesMaxCount", storage, folderDir); // It will call MediaNativeMaxCountCallback
            #endif
            }catch (Exception ex)
            {
                Debug.LogException(ex);
            }
        }

		/// <summary>
		/// <para>Gets the video files.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getVideoFiles(string folderDir, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			getVideoFiles (STORAGE_EXTERNAL, folderDir, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets the video files.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getVideoFiles(string storage, string folderDir, string sortOrder, int offset, int limit, onMediaCallback callback)
        {
            mediaCallback = callback;
            try {
            #if UNITY_ANDROID
                AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
                androidGalleryBridge.CallStatic("getVideoFiles", storage, folderDir, projection, sortOrder, offset, limit); // It will call MediaNativeCallback
            #endif
            }catch (Exception ex)
            {
                Debug.LogException(ex);
            }
        }

		/// <summary>
		/// <para>Gets all folders max count.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFoldersMaxCount(string folderDir, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			getAllFoldersMaxCount (STORAGE_EXTERNAL, folderDir, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets all folders max count.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFoldersMaxCount(string folderDir, int[] mediaTypes, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			getAllFoldersMaxCount (STORAGE_EXTERNAL, folderDir, mediaTypes, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets all folders max count.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="mimeTypes">Mime types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFoldersMaxCount(string folderDir, int[] mediaTypes, string[] mimeTypes, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			getAllFoldersMaxCount (STORAGE_EXTERNAL, folderDir, mediaTypes, mimeTypes, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets all folders max count.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFoldersMaxCount(string storage, string folderDir, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
        {
			getAllFoldersMaxCount(storage, folderDir, new int[]{FileColumns.MEDIA_TYPE_IMAGE,FileColumns.MEDIA_TYPE_VIDEO}, sortOrder, offset, limit, callback);
        }

		/// <summary>
		/// <para>Gets all folders max count.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFoldersMaxCount(string storage, string folderDir, int[] mediaTypes, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			mediaMaxCountCallback = callback;
			try {
				#if UNITY_ANDROID
				AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
				androidGalleryBridge.CallStatic("getAllFoldersMaxCount", storage, folderDir, mediaTypes); // It will call MediaNativeMaxCountCallback
				#endif
			}catch (Exception ex)
			{
				Debug.LogException(ex);
			}
		}

		/// <summary>
		/// <para>Gets all folders max count.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="mimeTypes">Mime types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFoldersMaxCount(string storage, string folderDir, int[] mediaTypes, string[] mimeTypes, string sortOrder, int offset, int limit, onMediaMaxCountCallback callback)
		{
			mediaMaxCountCallback = callback;
			try {
				#if UNITY_ANDROID
				AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
				androidGalleryBridge.CallStatic("getAllFoldersMaxCount", storage, folderDir, mediaTypes, mimeTypes); // It will call MediaNativeMaxCountCallback
				#endif
			}catch (Exception ex)
			{
				Debug.LogException(ex);
			}
		}

		/// <summary>
		/// <para>Gets all folders.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFolders(string folderDir, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			getAllFolders (STORAGE_EXTERNAL, folderDir, new int[]{FileColumns.MEDIA_TYPE_IMAGE,FileColumns.MEDIA_TYPE_VIDEO}, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets all folders.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFolders(string folderDir, int[] mediaTypes, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			getAllFolders (STORAGE_EXTERNAL, folderDir, mediaTypes, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets all folders.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFolders(string storage, string folderDir, string sortOrder, int offset, int limit, onMediaCallback callback)
        {
			getAllFolders(storage, folderDir, new int[]{FileColumns.MEDIA_TYPE_IMAGE,FileColumns.MEDIA_TYPE_VIDEO}, sortOrder, offset, limit, callback);
        }

		/// <summary>
		/// <para>Gets all folders.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFolders(string folderDir, int[] mediaTypes, string[] mimeTypes, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			getAllFolders (STORAGE_EXTERNAL, folderDir, mediaTypes, mimeTypes, sortOrder, offset, limit, callback);
		}

		/// <summary>
		/// <para>Gets all folders.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFolders(string storage, string folderDir, int[] mediaTypes, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			mediaCallback = callback;
			try {
				#if UNITY_ANDROID
				AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
				string[] folderProjection = new String[]{" DISTINCT "+FileColumns.PARENT};
				androidGalleryBridge.CallStatic("getAllFolders", storage, folderDir, mediaTypes, folderProjection, sortOrder, offset, limit); // It will call MediaNativeCallback
				#endif
			}catch (Exception ex)
			{
				Debug.LogException(ex);
			}
		}

		/// <summary>
		/// <para>Gets all folders.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// <para>You will get the result through callback.</para>
		/// <para>Added in v1.1.0</para>
		/// </summary>
		/// <param name="storage">Storage.</param>
		/// <param name="folderDir">Folder dir.</param>
		/// <param name="mediaTypes">Media types.</param>
		/// <param name="mimeTypes">Mime types.</param>
		/// <param name="sortOrder">Sort order.</param>
		/// <param name="offset">Offset.</param>
		/// <param name="limit">Limit.</param>
		/// <param name="callback">Callback.</param>
		public void getAllFolders(string storage, string folderDir, int[] mediaTypes, string[] mimeTypes, string sortOrder, int offset, int limit, onMediaCallback callback)
		{
			mediaCallback = callback;
			try {
				#if UNITY_ANDROID
				AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
				string[] folderProjection = new String[]{" DISTINCT "+FileColumns.PARENT};
				androidGalleryBridge.CallStatic("getAllFolders", storage, folderDir, mediaTypes, mimeTypes, folderProjection, sortOrder, offset, limit); // It will call MediaNativeCallback
				#endif
			}catch (Exception ex)
			{
				Debug.LogException(ex);
			}
		}

		/// <summary>
		/// <para>Gets the file rotation.</para>
		/// <para>This method automatically add STORAGE_EXTERNAL to get.</para>
		/// </summary>
		/// <returns>The file rotation in int.</returns>
		/// <param name="id">Identifier.</param>
		/// <param name="path">Path.</param>
		/// <param name="mediaType">Media type.</param>
		public int getFileRotation(int id, string path, int mediaType)
		{
			return getFileRotation (STORAGE_EXTERNAL, id, path, mediaType);
		}

		/// <summary>
		/// <para>Gets the file rotation.</para>
		/// </summary>
		/// <returns>The file rotation.</returns>
		/// <param name="storage">Storage.</param>
		/// <param name="id">Identifier.</param>
		/// <param name="path">Path.</param>
		/// <param name="mediaType">Media type.</param>
		public int getFileRotation(string storage, int id, string path, int mediaType)
        {
            int rotation = 0;
            try {
            #if UNITY_ANDROID
                AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
                rotation = androidGalleryBridge.CallStatic<int>("getFileRotation", storage, id, path, mediaType);
            #endif
            }catch (Exception ex)
            {
                Debug.LogException(ex);
            }
            return rotation;
        }

		/// <summary>
		/// <para>Gets the thumbnail path.</para>
		/// <para>You don't need to specify the storage because thumbnail is stored in the external storage.</para>
		/// </summary>
		/// <param name="position">Position.</param>
		/// <param name="id">Identifier.</param>
		/// <param name="mediaType">Media type.</param>
		/// <param name="thumbSize">Thumb size.</param>
		/// <param name="callback">Callback.</param>
		public void getThumbnailPath(int position, int id, int mediaType, int thumbSize, onThumbCallback callback) {
			thumbCallback = callback;
			AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
			androidGalleryBridge.CallStatic("getThumbnailPath", position, id, mediaType, thumbSize);
		}

		/// <summary>
		/// <para>Gets the thumbnail path array.</para>
		/// <para>You don't need to specify the storage because thumbnail is stored in the external storage.</para>
		/// </summary>
		/// <param name="positions">Position.</param>
		/// <param name="ids">Identifier.</param>
		/// <param name="mediaTypes">Media type.</param>
		/// <param name="thumbSize">Thumb size.</param>
		/// <param name="callback">Callback.</param>
		public void getThumbnailPath(int[] positions, int[] ids, int[] mediaTypes, int thumbSize, onThumbCallback callback) {
			thumbCallback = callback;
			AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
			androidGalleryBridge.CallStatic("getThumbnailPath", positions, ids, mediaTypes, thumbSize);

		}

		/// <summary>
		/// <para>Gets the thumbnail data as the byte array.</para>
		/// <c>ByteBuffer byteBuffer = ByteBuffer.allocate(bitmap.getByteCount());</c>
		/// <c>bitmap.copyPixelsToBuffer(byteBuffer);</c>
		/// <c>return byteBuffer.array();</c>
		/// </summary>
		/// <returns>The thumbnail.</returns>
		/// <param name="id">Identifier.</param>
		/// <param name="mediaType">Media type.</param>
		/// <param name="thumbSize">Thumb size.</param>
		public byte[] getThumbnail(int id, int mediaType, int thumbSize) {
			AndroidJavaObject androidGalleryBridge = new AndroidJavaObject("jp.co.taosoftware.android.androidgallerylibrary.AndroidGalleryBridge");
			byte[] data = androidGalleryBridge.CallStatic<byte[]>("getThumbnail", id, mediaType, thumbSize);
			return data;
		}

		/// <summary>
		/// Will be called by Android Gallery native library.
		/// </summary>
		/// <param name="result">Result in string.</param>
		private void MediaNativeMaxCountCallback(string result) {
			int maxCount = 0;
			try
			{

				maxCount = Int32.Parse(result);
			}
			catch (Exception ex)
			{
				Debug.LogException(ex);
			}
			mediaMaxCountCallback(maxCount);
		}

		/// <summary>
		/// Will be called by Android Gallery native library.
		/// </summary>
		/// <param name="result">Result in string.</param>
		private void MediaNativeCallback(string result)
		{
			MediaData[] mediaDataArray = null;
			if(!string.IsNullOrEmpty(result)) {
				string[] results = Regex.Split(result, "&arr.;");
				try
				{
					int len = results.Length;
					mediaDataArray = new MediaData[len];
					for (int i = 0; i < len; i++)
					{
						string input = results[i];
						string[] array = Regex.Split(input, "&sep.;");
						MediaData mediaData = new MediaData();
						mediaData.updateDataWithArrayString(array);
						mediaDataArray[i] = mediaData;
					}
				}
				catch (Exception ex)
				{
					Debug.LogException(ex);
				}
			}
			else {
				mediaDataArray = new MediaData[0];
			}
			mediaCallback(mediaDataArray);
		}

		/// <summary>
		/// Will be called by Android Gallery native library.
		/// </summary>
		/// <param name="result">Result in string.</param>
        private void ThumbNativeCallback(string result)
        {
            ThumbData[] thumbDataArray = null;
            if(!string.IsNullOrEmpty(result)) {
                string[] results = null;
                results = Regex.Split(result, "&arr.;");
   
                try
                {
                    int len = results.Length;
                    thumbDataArray = new ThumbData[len];
                    for (int i = 0; i < len; i++)
                    {
                        string input = results[i];
                        string[] array = Regex.Split(input, "&sep.;");
                        ThumbData thumbData = new ThumbData();
                        thumbData.updateDataWithArrayString(array);
                        thumbDataArray[i] = thumbData;
                    }
                }
                catch (Exception ex)
                {
                    Debug.LogException(ex);
                }
            }
            else {
                 thumbDataArray = new ThumbData[0];
            }
       
            thumbCallback(thumbDataArray);
        }

    }
}