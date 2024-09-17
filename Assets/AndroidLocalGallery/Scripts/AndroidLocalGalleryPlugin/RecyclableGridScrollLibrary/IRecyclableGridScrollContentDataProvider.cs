using UnityEngine;
using System.Collections;

namespace AndroidLocalGalleryPlugin {

	/// <summary>
	/// Controller script should inherits this callback to answer the information to calculate grid layout for RecyclableGridScrollLayout.
	/// </summary>
	public interface IRecyclableGridScrollContentDataProvider
	{
		/// <summary>
		/// Gets the data count.
		/// </summary>
		/// <value>The data count.</value>
	    int DataCount { get; }

		/// <summary>
		/// Gets the height of the item.
		/// </summary>
		/// <returns>The item height.</returns>
		/// <param name="index">Index.</param>
	    float GetItemHeight(int index);

		/// <summary>
		/// Gets the width of the item.
		/// </summary>
		/// <returns>The item width.</returns>
		/// <param name="index">Index.</param>
	    float GetItemWidth(int index);

		/// <summary>
		/// <para>Gets the recyclableItem(RectTransform) to manage the RecyclableGridScrollContent.</para>
		/// <para>Make a recyclableItem when RecyclableItemsScrollContent.initialize(this, true) is called.</para>
		/// <para>At first, recyclableItem is null so you should instantiate the recyclableItem.</para>
		/// <para>You have to update the item information like the text, thumbnail, onClickListener and etc before you return.</para>
		/// </summary>
		/// <returns>recyclableItem(RectTransform).</returns>
		/// <param name="index">Index.</param>
		/// <param name="recyclableItem">RecyclableItem(RectTransform)</param>
	    RectTransform GetItem(int index, RectTransform recyclableItem);
	}
}