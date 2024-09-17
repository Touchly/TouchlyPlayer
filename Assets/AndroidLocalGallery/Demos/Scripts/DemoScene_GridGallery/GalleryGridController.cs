using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AndroidLocalGalleryPlugin;

/**
* This class contacts AndroidGalleryMamager through delegate.
* This class manages media data and thumbnail data to view gui.
*
**/
public class GalleryGridController : MonoBehaviour, IRecyclableGridScrollContentDataProvider, IGalleryCallback
{
    public RecyclableGridScrollContent scrollContent; // The script which recycles items. Sometimes, GalleryController needs to ask. ex:Initialize recycling items to change category.
    public MediaDataGui itemPrefab; // Prefab which has gui components like a RawImage.
    public AndroidGalleryManager androidGalleryManager; // The bridge between GalleryController and Android Native Library.
	public GameObject VideoCanvas, PhotoCanvas, AudioCanvas, OtherCanvas; // The parent of the photo and video screen. Gallery controller uses it for visibility controll.
    public VideoManager videoManager; // Video Playback Manager
    public PhotoManager photoManager; // Picture View Manager
	public AudioManager audioManager; // audio View Manager
	public OtherManager otherManager; // other View Manager
	public Toggle toggleFolder; // Toggle Folder
    public string folderDir = ""; // The folder directory which is used to filter a query. It' used when you tap the item of CATEGORY_FOLDER.
    public int itemOffset = 0, itemCount = 100; // You can query with spacific offset and limit.
    public Text countText; // Show count and maxcount like a [Count: 100/400].

    private readonly int CATEGORY_ALL = 0;
    private readonly int CATEGORY_PHOTO = 1;
    private readonly int CATEGORY_VIDEO = 2;
	private readonly int CATEGORY_AUDIO = 3;
	private readonly int CATEGORY_OTHER = 4;
    private int category = 0; // selected category
	private bool isFolder = false; // search folders contained selected mediaTypes and mimeTypes if it's true.

    private readonly string SORT_DESC_MODIFIED_DATE = FileColumns.DATE_MODIFIED + " DESC";
    private readonly string SORT_ASC_MODIFIED_DATE = FileColumns.DATE_MODIFIED + " ASC";
	private readonly static string NONE = "mimeType:none";
    private string sortOrder = "";
    private int count = 0; // Stored count of mediadata which the app queried through AndroidGalleryManager. 
    private int maxCount = 0; // Stored count of all mediadata which the app queried through AndroidGalleryManager.
	private string[] mimeTypes = new string[]{NONE};
    List<MediaData> mediaList = new List<MediaData>(); // Stored mediadata.
    List<ThumbData> thumbList = new List<ThumbData>(); // Stored thumbdata.

    // Use this for initialization
	void Start () {
        sortOrder = SORT_DESC_MODIFIED_DATE;
        category = CATEGORY_ALL;
    }

    /*********** Callback Area Start ***********/

    // Get callback from androidGalleryManager.getFilesMaxCount, getImageAndVideoFilesMaxCount, getImageFilesMaxCount, getVideoFilesMaxCount, getImageFilesMaxCount
    public void onMediaMaxCountCallback(int maxCount) {
        // Update max count for paging.
        this.maxCount = maxCount;
        // Update count information.
        updateCountText();

        searchMediaFiles(0);
    }

    // Get callback from androidGalleryManager.getFiles, getImageAndVideoFiles, getImageFiles, getVideoFiles, getImageFiles
    public void onMediaCallback(MediaData[] results)
    {
        int length = results.Length;
        int[] indexs = new int[length];
        int[] ids = new int[length];
        int[] mediaTypes = new int[length];
        // Add media data
        for (var i = 0; i < length; i++)
        {
            MediaData result = results[i];
            mediaList.Add(result);
            ThumbData thumbData = new ThumbData();
            thumbData.position = i;
            thumbList.Add(thumbData);
            indexs[i] = i;
            ids[i] = result.id;
            mediaTypes[i] = result.media_type;

        }
        // Update count information.
        count = mediaList.Count;
        updateCountText();
        // Initialize the recyclable list contents.
        bool initPosition = (itemOffset == 0);
        scrollContent.Initialize(this, initPosition);
    }

    // The callback which will be called when you call androidGalleryManager.getThumbnailPath
    public void onThumbCallback(ThumbData[] results)
    {
        StartCoroutine(LoadChildrenItemThumb(results));
    }

    /*********** Callback Area End ***********/

    // Check current category and call a suitable search method.
    public void searchMediaFiles(int offset)
    {
        itemOffset = offset;
		if (NONE.Equals (mimeTypes[0])) {
			if (isFolder) {
				androidGalleryManager.getAllFolders (folderDir, getMediaTypeForCategory(), sortOrder, itemOffset, itemCount, onMediaCallback);
			} else {
				androidGalleryManager.getFiles (folderDir, getMediaTypeForCategory(), sortOrder, itemOffset, itemCount, onMediaCallback);
			} 
		} else {
			if (isFolder) {
				androidGalleryManager.getAllFolders (folderDir, getMediaTypeForCategory(), mimeTypes, sortOrder, itemOffset, itemCount, onMediaCallback);
			} else {
				androidGalleryManager.getFiles (folderDir, getMediaTypeForCategory(), mimeTypes, sortOrder, itemOffset, itemCount, onMediaCallback);
			} 
		}
    }

    public void searchMediaFilesMaxCount()
    {
        if (CATEGORY_ALL == category)
        {
            searchImageAndVideoFilesMaxCount();
        }
        else if (CATEGORY_PHOTO == category)
        {
             searchImageFilesMaxCount();
        }
        else if (CATEGORY_VIDEO == category)
        {
             searchVideoFilesMaxCount();
        }
		else if (CATEGORY_AUDIO == category)
		{
			searchAudioFilesMaxCount();
		}
		else if (CATEGORY_OTHER == category)
		{
			searchOtherFilesMaxCount();
		}
    }

    // It's used for paging.
    public void searchMoreMediaFiles(int offset)
    {
        itemOffset = offset;
		if (NONE.Equals (mimeTypes[0])) {
			if (isFolder) {
				androidGalleryManager.getAllFolders (folderDir, getMediaTypeForCategory(), sortOrder, itemOffset, itemCount, onMediaCallback);
			} else {
				androidGalleryManager.getFiles (folderDir, getMediaTypeForCategory(), sortOrder, itemOffset, itemCount, onMediaCallback);
			} 
		} else {
			if (isFolder) {
				androidGalleryManager.getAllFolders (folderDir, getMediaTypeForCategory(), mimeTypes, sortOrder, itemOffset, itemCount, onMediaCallback);
			} else {
				androidGalleryManager.getFiles (folderDir, getMediaTypeForCategory(), mimeTypes, sortOrder, itemOffset, itemCount, onMediaCallback);
			} 
		}
    }

	private int[] getMediaTypeForCategory(){
		if (CATEGORY_ALL == category) {
			return new int[]{ FileColumns.MEDIA_TYPE_IMAGE, FileColumns.MEDIA_TYPE_VIDEO };
		} else if (CATEGORY_PHOTO == category) {
			return new int[]{ FileColumns.MEDIA_TYPE_IMAGE };
		} else if (CATEGORY_VIDEO == category) {
			return new int[]{ FileColumns.MEDIA_TYPE_VIDEO };
		} else if (CATEGORY_AUDIO == category) {
			return new int[]{ FileColumns.MEDIA_TYPE_AUDIO };
		} else if (CATEGORY_OTHER == category) {
			return new int[]{ FileColumns.MEDIA_TYPE_NONE };
		}
		return new int[]{ FileColumns.MEDIA_TYPE_IMAGE, FileColumns.MEDIA_TYPE_VIDEO };
	}

    // Change sort type.
    // It's called from toggle gui.
    // 0 == desc, 1 == asc
    public void OnSortValueChanged(int result)
	{
	    sortOrder = (result == 0 ? SORT_DESC_MODIFIED_DATE : SORT_ASC_MODIFIED_DATE);
        searchMediaFilesMaxCount();
	}

	public void OnFolderChanged(Toggle result){
		isFolder = result.isOn;
		searchMediaFilesMaxCount();
	}

	public void OnMimeTypeChanged(Dropdown result){
		mimeTypes = new string[]{result.options[result.value].text};
		searchMediaFilesMaxCount();
	}

    // Change dirction type.
    // It's called from toggle gui.
    // 0 == vertical, 1 == horizontal
    public void OnDirectionValueChanged(int result)
	{

        scrollContent.InitPosition();
        if(result == 0) {
            scrollContent.direction = RecyclableGridScrollContent.Direction.Vertical;
        }
        else {
            scrollContent.direction = RecyclableGridScrollContent.Direction.Horizontal;
        }
        scrollContent.initScrollInfo();
        searchMediaFilesMaxCount();
	}
  
    public void searchImageAndVideoFilesMaxCount() {
        // To get image and video files.
        category = CATEGORY_ALL;
		searchFilesMaxCount ();
    }

    public void searchImageFilesMaxCount() {
        // To get image files.
        category = CATEGORY_PHOTO;
		searchFilesMaxCount ();

    }

    public void searchVideoFilesMaxCount() {
        // To get video files.
        category = CATEGORY_VIDEO;
		searchFilesMaxCount();
    }

	public void searchAudioFilesMaxCount() {
		// To get audio files.
		category = CATEGORY_AUDIO;
		searchFilesMaxCount();
	}

	public void searchOtherFilesMaxCount() {
		// To get audio files.
		category = CATEGORY_OTHER;
		searchFilesMaxCount();
	}

	public void searchFilesMaxCount(){
		// Init array
		mediaList.Clear();
		thumbList.Clear();
		isFolder = toggleFolder.isOn;
		folderDir = "";
		itemOffset = 0;
		if (NONE.Equals (mimeTypes[0])) {
			if (isFolder) {
				androidGalleryManager.getAllFoldersMaxCount(folderDir, getMediaTypeForCategory(), sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
			} else {
				androidGalleryManager.getFilesMaxCount(folderDir, getMediaTypeForCategory(), sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
			}
		} else {
			if (isFolder) {
				androidGalleryManager.getAllFoldersMaxCount (folderDir, getMediaTypeForCategory(), mimeTypes, sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
			} else {
				androidGalleryManager.getFilesMaxCount (folderDir, getMediaTypeForCategory(), mimeTypes, sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
			}
		}
	}

    // Update count information.
    private void updateCountText() {
        countText.text = "Count: "+count+"/"+maxCount;
    }

    private IEnumerator LoadChildrenItemThumb(ThumbData[] results)
    {
        int length = results.Length;
        // Add thumb data
        for (var i = 0; i < length; i++) {
            ThumbData thumbData = results[i];
            thumbList[thumbData.position].updateDataWithThumbData(thumbData);
            MediaDataGui gui = scrollContent.getMediaDataGuiIfExist(thumbData.position);
            if (gui != null)
            {
                gui.SetData(thumbData);
                yield return null;
            }
        }
    }

    private IEnumerator LoadChildItemThumb(MediaDataGui gui, ThumbData thumbData)
    {
        gui.SetData(thumbData);
        yield return null;
    }

    public int DataCount { get { return mediaList.Count; } }

    public float GetItemHeight(int index)
    {
        // Return cell height.
        return itemPrefab.GetComponent<RectTransform>().sizeDelta.y;
    }

    public float GetItemWidth(int index)
    {
        // Return cell width.
        return itemPrefab.GetComponent<RectTransform>().sizeDelta.x;
    }

    public RectTransform GetItem(int index, RectTransform recyclableItem)
    {
        // Load recyclableItem of the index.
        if (null == recyclableItem)
        {
            // Make a recyclableItem it will come to here when RecyclableItemsScrollContent.initialize(this, true) is called.
            // It will never come to here because cell item is recycled.
            recyclableItem = Instantiate(itemPrefab).GetComponent<RectTransform>();
        }

        // Overwrite recyclableItem's information.
        MediaDataGui gui = recyclableItem.GetComponent<MediaDataGui>();
        MediaData mediaData = mediaList[index];
        ThumbData thumbData = thumbList[index];
        // Get thumbnail image if it's media type is an image of video.
		if (FileColumns.MEDIA_TYPE_IMAGE == mediaData.media_type || FileColumns.MEDIA_TYPE_VIDEO == mediaData.media_type)
        {
            if (!string.IsNullOrEmpty(thumbData.data)) {
                // Load thumbnail image if thumbData already has thumbnail url.
                StartCoroutine(LoadChildItemThumb(gui,thumbData));
            }
            else {
                // Need to clear 
                gui.ClearImage();
                // Query thumbnail.
                androidGalleryManager.getThumbnailPath(index, mediaData.id, mediaData.media_type, FileColumns.MINI_KIND, onThumbCallback);
            }
            gui.title.enabled = false;
        }
		else if(FileColumns.MEDIA_TYPE_AUDIO == mediaData.media_type)
		{
			gui.AudioImage();
			gui.title.enabled = true;
		}
		else if(FileColumns.MEDIA_TYPE_NONE == mediaData.media_type && !mediaData.is_directory && !isFolder)
		{
			gui.OtherImage();
			gui.title.enabled = true;
		}
        else {
            gui.FolderImage();
            gui.title.enabled = true;
        }
		//gui.title.text = "Col:" + colRow[0] + " Row:" + colRow[1];+"bytes"
        gui.title.text = mediaData.title;
        gui.video.enabled = FileColumns.MEDIA_TYPE_VIDEO == mediaData.media_type;
        gui.clickButton.onClick.RemoveAllListeners();
        gui.clickButton.onClick.AddListener (() => OnClickDelegate(mediaData, thumbData));

        // Query next page if next page is remaining.
        // We recommend that MoreQuery starts whether index position reaches middle of count;
        if(index+1 == (count/2) && count < maxCount) {
              StartCoroutine(StartMoreQuery(count));
        }
        return recyclableItem;
    }

    // Check media type and do action.
    public void OnClickDelegate( MediaData mediaData, ThumbData thumbData )
	{
		if (FileColumns.MEDIA_TYPE_IMAGE == mediaData.media_type && !isFolder) {
            mediaData.orientation = androidGalleryManager.getFileRotation(mediaData.id, mediaData.data, mediaData.media_type);
            StartCoroutine(StartPhotoViewing(mediaData, thumbData));
		}else if(FileColumns.MEDIA_TYPE_VIDEO == mediaData.media_type && !isFolder) {
             mediaData.orientation = androidGalleryManager.getFileRotation(mediaData.id, mediaData.data, mediaData.media_type);
            StartCoroutine(StartVideoPlayback(mediaData, thumbData));
		}else if(FileColumns.MEDIA_TYPE_AUDIO == mediaData.media_type && !isFolder) {
			StartCoroutine(StartAudioPlayback(mediaData, thumbData));
		}else if(FileColumns.MEDIA_TYPE_NONE == mediaData.media_type && !isFolder) {
			StartCoroutine(StartOtherPlayback(mediaData, thumbData));
        }else {
             // Search selectd media type with folderDir filter when tapped folder.
            folderDir = System.IO.Path.GetDirectoryName(mediaData.data)+"/";
            mediaList.Clear();
            thumbList.Clear();
            itemOffset = 0;
			isFolder = false;
			if (NONE.Equals (mimeTypes[0])) {
				androidGalleryManager.getFilesMaxCount(folderDir, getMediaTypeForCategory(), sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
			} else {
				androidGalleryManager.getFilesMaxCount (folderDir, getMediaTypeForCategory(), mimeTypes, sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
			}
        }
    }

    private IEnumerator StartVideoPlayback(MediaData mediaData, ThumbData thumbData) {
        VideoCanvas.SetActive(true);
        // Need to wait for preparation.
        yield return new WaitForSeconds(0.75f);
        videoManager.Playback(mediaData);
    }
    
    private IEnumerator StartPhotoViewing(MediaData mediaData, ThumbData thumbData) {
        PhotoCanvas.SetActive(true);
        yield return new WaitForSeconds(0.1f);
        photoManager.SetData(mediaData);
    }

	private IEnumerator StartAudioPlayback(MediaData mediaData, ThumbData thumbData) {
		AudioCanvas.SetActive(true);
		// Need to wait for preparation.
		yield return new WaitForSeconds(0.75f);
		audioManager.Playback(mediaData);
	}

	private IEnumerator StartOtherPlayback(MediaData mediaData, ThumbData thumbData) {
		OtherCanvas.SetActive(true);
		// Need to wait for preparation.
		yield return new WaitForSeconds(0.75f);
		otherManager.Playback(mediaData);
	}

    private IEnumerator StartMoreQuery(int offset)
	{
        searchMoreMediaFiles(offset);
        yield return null;
    }
    
}
