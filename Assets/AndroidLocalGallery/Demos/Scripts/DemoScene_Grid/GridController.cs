using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AndroidLocalGalleryPlugin;

/// <summary>
/// GridController is a sample script which writes simple flow.
/// </summary>
public class GridController : MonoBehaviour, IRecyclableGridScrollContentDataProvider {

	/// <summary>
    /// The content of the scroll.
    /// </summary>
    public RecyclableGridScrollContent scrollContent; // The script which recycles items. 
    /// <summary>
    /// The item prefab.
    /// </summary>
    public GameObject itemPrefab; // itemPrefab
    /// <summary>
    /// The mock item count.
    /// </summary>
    public int mockItemCount = 1000; // mock
   
    private List<int> items = new List<int>();

    // Use this for initialization
    void Start () {
        for(int i = 0; i < mockItemCount; i++) {
            items.Add(i);
        }
        scrollContent.Initialize(this, true);
	}

    /// <summary>
    /// RecyclableGridScrollContent will use it to calculate recyclable item count
    /// </summary>
    /// <returns>Number of attached children</returns>
    public int DataCount { get { return items.Count; } }

    /// <summary>
    /// Return the child height at the given index
    /// </summary>
    /// <param name="index">Index of child to return</param>
    /// <returns>Height in float</returns>
    public float GetItemHeight(int index)
    {
        // Return item height. RecyclableGridScrollContent will use it to calculate grid layout.
        return itemPrefab.GetComponent<RectTransform>().sizeDelta.y;
    }

    /// <summary>
    /// Return the child width at the given index
    /// </summary>
    /// <param name="index">Index of child to return</param>
    /// <returns>Width in float</returns>
    public float GetItemWidth(int index)
    {
        // Return item width. RecyclableGridScrollContent will use it to calculate grid layout.
        return itemPrefab.GetComponent<RectTransform>().sizeDelta.x;
    }

    /// <summary>
    /// Gets the item.
    /// </summary>
    /// <returns>The item.</returns>
    /// <param name="index">Index.</param>
    /// <param name="recyclableItem">Recyclable item.</param>
    public RectTransform GetItem(int index, RectTransform recyclableItem)
    {
        // Load recyclableItem of the index.
        if (null == recyclableItem)
        {
            // Make a recyclableItem it will come to here when RecyclableItemsScrollContent.initialize(this, true) is called.
            // It will never come to here because cell item is already recycled.
            recyclableItem = Instantiate(itemPrefab).GetComponent<RectTransform>();
        }

        // Update index number.
        Text text = recyclableItem.GetComponentInChildren<Text>();
        text.text = ""+index;
        return recyclableItem;
    }

    /**
     * Change dirction type.
     * It's called from toggle gui.
     * 0 == vertical, 1 == horizontal
    **/
    /// <summary>
	/// Change dirction type.
	/// It's called from toggle gui.
    /// </summary>
	/// <param name="direction">0 == vertical, 1 == horizontal</param>
	public void OnDirectionValueChanged(int direction)
	{
        // Init Position.
        scrollContent.InitPosition();
		if(direction == 0) {
            scrollContent.direction = RecyclableGridScrollContent.Direction.Vertical;
        }
        else {
            scrollContent.direction = RecyclableGridScrollContent.Direction.Horizontal;
        }
        scrollContent.initScrollInfo();
        scrollContent.Initialize(this, true);
	}
}
