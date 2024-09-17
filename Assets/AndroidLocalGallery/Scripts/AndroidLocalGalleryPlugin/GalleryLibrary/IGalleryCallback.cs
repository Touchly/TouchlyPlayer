using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace AndroidLocalGalleryPlugin {

    /// <summary>Controller script should inherits this callback to receive the mediadata or thumbdata result.</summary>
    public interface IGalleryCallback
    {
        /// <summary>Media query callback.</summary>
        /// <param name="results">MediaData Array which contains query results</param>
        void onMediaCallback(MediaData[] results);

        /// <summary>Thumbnail query callback.</summary>
        /// <param name="results">ThumbData Array which contains query results</param>
        void onThumbCallback(ThumbData[] results);
    }
}