using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using System.Linq;
using UnityEngine.EventSystems;
using System;

namespace AndroidLocalGalleryPlugin {

    /// <summary>
    /// RecyclableGridScrollContent manages scroll content layout.
    /// </summary>
	[RequireComponent(typeof (RectTransform))]
	public class RecyclableGridScrollContent : UIBehaviour
    {
		/// <summary>
		/// The padding.
		/// </summary>
        public Padding padding;

		/// <summary>
		/// The spacing.
		/// </summary>
        public int spacing = 20;

		/// <summary>
		/// The direction.
		/// </summary>
        public Direction direction;

		/// <summary>
		/// <para>The instantate item count.</para>
		/// <para>You need to set suitable count.</para>
		/// </summary>
        [SerializeField, Range(0, 60)]
        public int instantateItemCount = 30;

		/// <summary>
		/// The fixed column count.
		/// </summary>
        [SerializeField, Range(1, 20)]
        public int fixedColumnCount = 3;

        private List<RectTransform> items = new List<RectTransform>();
		private List<int> indexItems = new List<int>();
		private float diffPreFramePosition = 0f;
		private int currentItemNo = 0;
		private List<float> positionCachesX = new List<float>();
		private List<float> positionCachesY = new List<float>();
		private IRecyclableGridScrollContentDataProvider dataProvider;

		/// <summary>
		/// Direction(Vertical, Horizontal).
		/// </summary>
        public enum Direction
        {
			/// <summary>
			/// The vertical.
			/// </summary>
            Vertical,
			/// <summary>
			/// The horizontal.
			/// </summary>
            Horizontal,
        }

		/// <summary>
		/// Padding.
		/// </summary>
        [System.Serializable]
        public class Padding
        {
			/// <summary>
			/// The top.
			/// </summary>
            public int top = 20;
			/// <summary>
			/// The right.
			/// </summary>
            public int right = 20;
			/// <summary>
			/// The bottom.
			/// </summary>
            public int bottom = 20;
			/// <summary>
			/// The left.
			/// </summary>
            public int left = 20;
        }


        private RectTransform rectTransform;

		/// <summary>
		/// The rect transform of this.
		/// </summary>
        protected RectTransform RectTransform
        {
            get
            {
                if (rectTransform == null)
                {
                    rectTransform = GetComponent<RectTransform>();
                }
                return rectTransform;
            }
        }

		/// <summary>
		/// Gets the anchored position.
		/// </summary>
		/// <value>The anchored position.</value>
        float AnchoredPosition
        {
            get
            {
                float anchorPosition = direction == Direction.Vertical ? 
                    -RectTransform.anchoredPosition.y :
                    RectTransform.anchoredPosition.x;

                return anchorPosition;
            }
        }

        /// <summary>
        /// Start this instance.
        /// </summary>
        protected override void Start()
        {

            if (rectTransform == null)
            {
                rectTransform = GetComponent<RectTransform>();
            }
            // Change anchor forcibly.
            rectTransform.anchorMin = Vector2.up;
            rectTransform.anchorMax = Vector2.up;
            initScrollInfo();
        }

        /// <summary>
        /// Initialize ScrollRect Direction and RectTransform.
        /// </summary>
        public void initScrollInfo() {

            // Get scroll information from ScrollRect.
            var scrollRect = GetComponentInParent<ScrollRect>();
            // Set Scroll Direction
            scrollRect.horizontal = direction == Direction.Horizontal;
            scrollRect.vertical = direction == Direction.Vertical;
            scrollRect.content = RectTransform;
        }

        void Update()
        {
            if (null == dataProvider)
            {
                return;
            }

            if (direction == Direction.Vertical)
            {
                UpdateRecyclableItemsPosotionVertical();
            }
            else
            {
                UpdateRecyclableItemsPosotionHorizontal();
            }
        }

        /// <summary>
        /// Update recyclable items position vertically.
        /// </summary>
        void UpdateRecyclableItemsPosotionVertical() {
             while (true)
            {
                float itemHeight = GetItemHeight(currentItemNo);
                if (itemHeight <= 0 || AnchoredPosition - diffPreFramePosition >= -(itemHeight + spacing) * 2)
                {
                    break;
                }

                var item = items[0];
                items.RemoveAt(0);
                indexItems.RemoveAt(0);
                int[] prevColRow = GetColRowPostion(currentItemNo);
                int[] colRow = GetColRowPostion(currentItemNo+1);
                if(prevColRow[1] != colRow[1]) {
                     diffPreFramePosition -= itemHeight + spacing;
                }
                indexItems.Add(currentItemNo + instantateItemCount);
                items.Add(GetItem(currentItemNo + instantateItemCount, item));
         
                currentItemNo++;
            }

            while (true)
            {
                float itemHeight = GetItemHeight(currentItemNo + instantateItemCount - 1);
    
                if (itemHeight <= 0 || AnchoredPosition - diffPreFramePosition <= -(itemHeight + spacing) * 1)
                {
                    break;
                }

                var item = items[items.Count - 1];
                items.RemoveAt(items.Count - 1);
                indexItems.RemoveAt(indexItems.Count - 1);
                currentItemNo--;

                int[] prevColRow = GetColRowPostion(currentItemNo+1);
                int[] colRow = GetColRowPostion(currentItemNo);
                if(prevColRow[1] != colRow[1]) {
                    diffPreFramePosition += GetItemHeight(currentItemNo) + spacing;
                }
            
                items.Insert(0, GetItem(currentItemNo, item));
                indexItems.Insert(0, currentItemNo);
            }
        }

        /// <summary>
        /// Update recyclable items position horizontally.
        /// </summary>
        void UpdateRecyclableItemsPosotionHorizontal() {

             while (true)
            {
                float itemWidth = GetItemWidth(currentItemNo);
                if (itemWidth <= 0 || AnchoredPosition - diffPreFramePosition >= -(itemWidth + spacing) * 2)
                {
                    break;
                }

                var item = items[0];
                items.RemoveAt(0);
                indexItems.RemoveAt(0);
                int[] prevColRow = GetColRowPostion(currentItemNo);
                int[] colRow = GetColRowPostion(currentItemNo+1);
                if(prevColRow[0] != colRow[0]) {
                     diffPreFramePosition -= itemWidth + spacing;
                }
                indexItems.Add(currentItemNo + instantateItemCount);
                items.Add(GetItem(currentItemNo + instantateItemCount, item));
         
                currentItemNo++;
            }

            while (true)
            {
                float itemWidth = GetItemWidth(currentItemNo + instantateItemCount - 1);
    
                if (itemWidth <= 0 || AnchoredPosition - diffPreFramePosition <= -(itemWidth + spacing) * 1)
                {
                    break;
                }

                var item = items[items.Count - 1];
                items.RemoveAt(items.Count - 1);
                indexItems.RemoveAt(indexItems.Count - 1);
                currentItemNo--;

                int[] prevColRow = GetColRowPostion(currentItemNo+1);
                int[] colRow = GetColRowPostion(currentItemNo);
                if(prevColRow[0] != colRow[0]) {
                    diffPreFramePosition += GetItemWidth(currentItemNo) + spacing;
                }
            
                items.Insert(0, GetItem(currentItemNo, item));
                indexItems.Insert(0, currentItemNo);
            }
        }

        /// <summary>
        /// Return recycled position from index.
        /// If index items is not existing, it retuens null;
        /// </summary>
        /// <param name="index">Index of child to return the recycled position</param>
        /// <returns>int? position of the recycled item. It will return null if it's not existed.</returns>
        public int? getRecycledPosition(int index) {
            string result = "";
            int count = indexItems.Count;
            for(int i = 0; i < count; i++) {
                result += indexItems[i];
                result += ",";
            }
            if(indexItems.Contains(index)) {
                return indexItems.IndexOf(index);
            }else {
                return null;
            }
        }

        /// <summary>
        /// Return MediaDataGui from index.
        /// </summary>
        /// <param name="index">Index of child to return.</param>
        /// <returns>MediaDataGui which is attached recyclableItem. It will return null if it's not existed.</returns>
        public MediaDataGui getMediaDataGuiIfExist(int index) {
      
            int? position = getRecycledPosition(index);
            if(null != position) {
                return items[position.Value].GetComponent<MediaDataGui>();
            }else {
                // Index items is not existed.
                return null;
            }
        }

		/// <summary>
		/// Refresh the recyclable items.
		/// </summary>
		public void Reflesh()
		{
			Initialize(dataProvider, true);
		}

        /// <summary>
        /// This method makes or resets the recyclable items.
        /// </summary>
        /// <param name="dataProvider">Get informations like a DataCount from Controller Script which inherits IRecyclableGridScrollContentDataProvider.</param>
        /// <param name="initPosition">Scrolled position is initialized if it's true. False may be used when you want to support paging feature.</param>
        public void Initialize(IRecyclableGridScrollContentDataProvider dataProvider, bool initPosition)
        {
            this.dataProvider = dataProvider;
            if(initPosition) {

                // Init position
                InitPosition();
            
                if (items.Count == 0)
                {
                    for (var i = 0; i < instantateItemCount; i++)
                    {
                        items.Add(GetItem(i, null));
                        indexItems.Add(i);
                    }
                }
                else
                {
                    positionCachesX.Clear();
                    positionCachesY.Clear();
                    for (var i = 0; i < instantateItemCount; i++)
                    {
                        var item = items[0];
                        items.RemoveAt(0);
                        items.Add(GetItem(currentItemNo + i, item));
                        indexItems.RemoveAt(0);
                        indexItems.Add(currentItemNo + i);
                    }
                }
            }
   
            // Update scroll content size.
            var rectTransform = GetComponent<RectTransform>();
            var delta = rectTransform.sizeDelta;
            if (direction == Direction.Vertical)
            {
                delta.y = padding.top + padding.bottom;
                int[] colRow = GetColRowPostion(dataProvider.DataCount - 1);
                delta.y += (GetItemHeight(0) * (colRow[1]+1)) + (spacing * colRow[1]);
            }
            else
            {
                delta.x = padding.left + padding.right;
                int[] colRow = GetColRowPostion(dataProvider.DataCount - 1);
                delta.x += (GetItemWidth(0) * (colRow[0]+1)) + (spacing * colRow[0]);
            }
            rectTransform.sizeDelta = delta;
        }

         /// <summary>
		/// Scroll to the top of the position.
        /// </summary>
        public void InitPosition() {
            // Init position
            var scrollRect = GetComponentInParent<ScrollRect>();
            if (direction == Direction.Vertical)
            {
                scrollRect.verticalNormalizedPosition= 1;
            }
            else
            {
                scrollRect.horizontalNormalizedPosition= 0;
            }
        }

        /// <summary>
        /// Return the child height at the given index
        /// </summary>
        /// <param name="index">Index of child to return</param>
        /// <returns>Height in float</returns>
        float GetItemHeight(int index)
        {
            if (null == dataProvider || dataProvider.DataCount == 0)
            {
                return 0;
            }
            return dataProvider.GetItemHeight(Math.Max(0, Math.Min(index, dataProvider.DataCount - 1)));
        }

        /// <summary>
        /// Return the child width at the given index
        /// </summary>
        /// <param name="index">Index of child to return</param>
        /// <returns>Width in float</returns>
        float GetItemWidth(int index)
        {
            if (null == dataProvider || dataProvider.DataCount == 0)
            {
                return 0;
            }
            return dataProvider.GetItemWidth(Math.Max(0, Math.Min(index, dataProvider.DataCount - 1)));
        }

        /// <summary>
        /// Return the child width at the given index
        /// </summary>
        /// <param name="index">Index of child to return</param>
		/// <param name="recyclableItem">RectTransform</param>
        /// <returns>Return RectTransform attached RecyclableItem.</returns>
        RectTransform GetItem(int index, RectTransform recyclableItem)
        {
            if (null == dataProvider || index < 0 || dataProvider.DataCount <= index)
            {
                if (null != recyclableItem && 0 <= index && dataProvider.DataCount <= index)
                {
                    recyclableItem.gameObject.SetActive(false);
                }
                return recyclableItem;
            }
     
            var item = dataProvider.GetItem(index, recyclableItem);
            if (item != recyclableItem)
            {
                item.SetParent(transform, false);
            }
      
            item.anchoredPosition = GetPosition(index);
            item.gameObject.SetActive(true);
            return item;
        }

        private float GetPositionCacheX(int index)
        {
            for (var i = positionCachesX.Count; i <= index; i++)
            {
                int[] colRow = GetColRowPostion(i);
                positionCachesX.Add(i == 0 ? (direction == Direction.Vertical ? padding.top : padding.left) : ((GetItemWidth(i)*(colRow[0])) + (spacing*(colRow[0]+1))));
            }
            return positionCachesX[index];
        }

		private float GetPositionCacheY(int index)
        {
            for (var i = positionCachesY.Count; i <= index; i++)
            {
                int[] colRow = GetColRowPostion(i);
                positionCachesY.Add(i == 0 ? (direction == Direction.Vertical ? padding.top : padding.left) : ((GetItemHeight(i)*(colRow[1])) + (spacing*(colRow[1]+1))));
            }
            return positionCachesY[index];
        }

		private Vector2 GetPosition(int index)
        {
            if (index < 0)
            {
                return Vector2.zero;
            }
            float positionX = GetPositionCacheX(index);
            float positionY = GetPositionCacheY(index);
            return direction == Direction.Vertical ? new Vector2(positionX, -positionY) : new Vector2(positionX, -positionY);
        }

		/// <summary>
		/// <para>Return column position and row position.</para>
		/// <para>int[0] = column position, int[1] = row position</para>
		/// </summary>
		/// <returns>The col row postion.</returns>
		/// <param name="index">Index.</param>
        public int[] GetColRowPostion(int index)
        {
            int[] colRow = new int[2];
            if (direction == Direction.Vertical)
            {
                index += 1;
                int column = (index%fixedColumnCount);
                if(0 == column) {
                    column = fixedColumnCount;
                }
                int row = (index/(fixedColumnCount));
                    if(fixedColumnCount == column) {
                    row = row-1;
                }
                colRow[0] = column-1;
                colRow[1] = row;
            }
            else
            {
                index += 1;
                int column = (index%fixedColumnCount);
                if(0 == column) {
                    column = fixedColumnCount;
                }
                int row = (index/(fixedColumnCount));
                    if(fixedColumnCount == column) {
                    row = row-1;
                }
                colRow[0] = row;
                colRow[1] = column-1;
            }
            return colRow;
        }

    }
}