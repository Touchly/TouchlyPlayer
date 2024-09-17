using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AndroidLocalGalleryPlugin;

/// <summary>
/// This class contacts AndroidGalleryMamager through delegate.
/// This class manages media data and thumbnail data to view gui.
/// </summary>
public class GalleryController : MonoBehaviour, IRecyclableGridScrollContentDataProvider, IGalleryCallback
{
    //public RecyclableGridScrollContent scrollContent; // The script which recycles items. Sometimes, GalleryController needs to ask. ex:Initialize recycling items to change category.
    public MediaDataGui itemPrefab; // Prefab which has gui components like a RawImage.
    public AndroidGalleryManager androidGalleryManager; // The bridge between GalleryController and Android Native Library.
    public string folderDir = ""; // The folder directory which is used to filter a query. It' used when you tap the item of CATEGORY_FOLDER.
    public int itemOffset = 0, itemCount = 100; // You can query with spacific offset and limit.
   // public Text countText; // Show count and maxcount like a [Count: 100/400].

    private readonly int CATEGORY_ALL = 0;
    private readonly int CATEGORY_PHOTO = 1;
    private readonly int CATEGORY_VIDEO = 2;
    private readonly int CATEGORY_FOLDER = 3;
    private int category = 2; // selected category

    private readonly string SORT_DESC_MODIFIED_DATE = FileColumns.DATE_MODIFIED + " DESC";
    private readonly string SORT_ASC_MODIFIED_DATE = FileColumns.DATE_MODIFIED + " ASC";
    private string sortOrder = "";
    private int count = 0; // Stored count of mediadata which the app queried through AndroidGalleryManager. 
    private int maxCount = 0; // Stored count of all mediadata which the app queried through AndroidGalleryManager.
    List<MediaData> mediaList = new List<MediaData>(); // Stored mediadata.

    // Use this for initialization
	void Start () {
        sortOrder = SORT_DESC_MODIFIED_DATE;
        category = CATEGORY_ALL;
    }

    /*********** Callback Area Start ***********/

    /// <summary> Get callback from androidGalleryManager.getImageAndVideoFilesMaxCount, getImageFilesMaxCount, getVideoFilesMaxCount, getImageFilesMaxCount. /// </summary>
    public void onMediaMaxCountCallback(int maxCount) {
        // Update max count for paging.
        this.maxCount = maxCount;
        // Update count information.
        updateCountText();

        searchMediaFiles(0);
    }

    /// <summary> Get callback from androidGalleryManager.getImageAndVideoFiles, getImageFiles, getVideoFiles, getImageFiles. /// </summary>
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
            indexs[i] = i;
            ids[i] = result.id;
            mediaTypes[i] = result.media_type;

        }
        // Update count information.
        count = mediaList.Count;
        updateCountText();
        // Initialize the recyclable list contents.
        bool initPosition = (itemOffset == 0);
        //scrollContent.Initialize(this, initPosition);
    }

    // The callback which will be called when you call androidGalleryManager.getThumbnailPath
    public void onThumbCallback(ThumbData[] results)
    {
    }

    /*********** Callback Area End ***********/

    // Check current category and call a suitable search method.
    public void searchMediaFiles(int offset)
    {
        itemOffset = offset;
        if (CATEGORY_ALL == category)
        {
            androidGalleryManager.getImageAndVideoFiles(folderDir, sortOrder, itemOffset, itemCount, onMediaCallback);
        }
        else if (CATEGORY_PHOTO == category)
        {
            androidGalleryManager.getImageFiles(folderDir, sortOrder, itemOffset, itemCount, onMediaCallback);
        }
        else if (CATEGORY_VIDEO == category)
        {
            androidGalleryManager.getVideoFiles(folderDir, sortOrder, itemOffset, itemCount, onMediaCallback);
        }
        else if (CATEGORY_FOLDER == category)
        {
            androidGalleryManager.getAllFolders(folderDir, sortOrder, itemOffset, itemCount, onMediaCallback);
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
        else if (CATEGORY_FOLDER == category)
        {
             searchFoldersMaxCount();
        }
    }

    // It's used for paging.
    public void searchMoreMediaFiles(int offset)
    {
        itemOffset = offset;
        if (CATEGORY_ALL == category)
        {
            androidGalleryManager.getImageAndVideoFiles(folderDir, sortOrder, itemOffset, itemCount, onMediaCallback);
        }
        else if (CATEGORY_PHOTO == category)
        {
            androidGalleryManager.getImageFiles(folderDir, sortOrder, itemOffset, itemCount, onMediaCallback);
        }
        else if (CATEGORY_VIDEO == category)
        {
            androidGalleryManager.getVideoFiles(folderDir, sortOrder, itemOffset, itemCount, onMediaCallback);
        }
        else if (CATEGORY_FOLDER == category)
        {
            androidGalleryManager.getImageAndVideoFiles(folderDir, sortOrder, itemOffset, itemCount, onMediaCallback);
        }
    }

    // Change sort type.
    // It's called from toggle gui.
    // 0 == desc, 1 == asc
    public void OnSortValueChanged(int result)
	{
	    sortOrder = (result == 0 ? SORT_DESC_MODIFIED_DATE :SORT_ASC_MODIFIED_DATE);
        searchMediaFilesMaxCount();
	}

    // Change dirction type.
    // It's called from toggle gui.
    // 0 == vertical, 1 == horizontal
    public void OnDirectionValueChanged(int result)
	{

        //scrollContent.InitPosition();
        //if(result == 0) {
       //     scrollContent.direction = RecyclableGridScrollContent.Direction.Vertical;
       // }
       // else {
       //     scrollContent.direction = RecyclableGridScrollContent.Direction.Horizontal;
       // }
      //  scrollContent.initScrollInfo();
        searchMediaFilesMaxCount();
	}
  
    public void searchImageAndVideoFilesMaxCount() {
        // To get image and video files.
        mediaList.Clear();
        folderDir = "";
        itemOffset = 0;
        category = CATEGORY_ALL;
        androidGalleryManager.getImageAndVideoFilesMaxCount(folderDir, sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
    }

    public void searchImageFilesMaxCount() {
        // To get image files.
        mediaList.Clear();
        folderDir = "";
        itemOffset = 0;
        category = CATEGORY_PHOTO;
        androidGalleryManager.getImageFilesMaxCount(folderDir, sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
    }

    public void searchVideoFilesMaxCount() {
        // To get video files.
        mediaList.Clear();
        folderDir = "";
        itemOffset = 0;
        category = CATEGORY_VIDEO;
        androidGalleryManager.getVideoFilesMaxCount(folderDir, sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
    }

    public void searchFoldersMaxCount() {
        // To get all folders.
        mediaList.Clear();
        folderDir = "";
        itemOffset = 0;
        category = CATEGORY_FOLDER;
        androidGalleryManager.getAllFoldersMaxCount(folderDir, sortOrder, itemOffset, itemCount, onMediaMaxCountCallback);
    }

    // Update count information.
    private void updateCountText() {
        //countText.text = "Count: "+count+"/"+maxCount;
        Debug.Log("changed count");
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
        // Get thumbnail image if it's media type is an image of video.
        if (FileColumns.MEDIA_TYPE_IMAGE == mediaData.media_type || FileColumns.MEDIA_TYPE_VIDEO == mediaData.media_type)
        {
            // Need to clear 
            gui.ClearImage();
            gui.title.text = mediaData.data;
            gui.title.enabled = true;
        }
        else {
            gui.FolderImage();
            gui.title.text = mediaData.title;
            gui.title.enabled = true;
        }
        //gui.title.text = "Col:" + colRow[0] + " Row:" + colRow[1];
       
        gui.video.enabled = FileColumns.MEDIA_TYPE_VIDEO == mediaData.media_type;

        // Query next page if next page is remaining.
        // We recommend that MoreQuery starts whether index position reaches middle of count;
        if(index+1 == (count/2) && count < maxCount) {
              StartCoroutine(StartMoreQuery(count));
        }
        return recyclableItem;
    }

    private IEnumerator StartMoreQuery(int offset)
	{
        searchMoreMediaFiles(offset);
        yield return null;
    }
    
}
