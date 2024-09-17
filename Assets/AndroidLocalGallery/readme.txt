--------------------------------------------------
Android Local Gallery Plugin
--------------------------------------------------

Android Local Gallery Plugin is a Native Plugin which can easy to query local photos and videos from phone storage.
With this plugin, you can make a local gallery like Google Photo's Photos on device.


------------------Version v1.1.1------------------

Improved pooling stability of thumbnail path loader.

------------------Version v1.1.0------------------

Audio type was supported.
Added mime type filter.(Beta version)

------------------Version v1.0.0------------------

[Features]

Local Gallery Manager
 -Query all videos and photos which is stored in the local storage.
 -Query all photos which is stored in the local storage.
 -Query all videos which is stored in the local storage.
 -Query all folders which has photos or videos in the local storage.
 -Support offset and limit query.
 -Support sort.

Recyclable Grid Scroll View
 -Using recyclable grid layout which can use with uGUI.
 -Direction support.(Vertical, Horizontal)
 -Can change column count.(1 or more)
 -Can change recycle item count.(1 or more)
 -Optimized memory performance.
 -60 fps smooth scroll on Galaxy S8.

Demos
 -Android Local Gallery with Recyclable Grid ScrollView.
 -Demo scene uses standard image asset to view photo.*Gif format is not supported.
 -Demo scene uses new VideoPlayer to playback.
  VideoPlayer is a new API so it has several issues like a below.
  https://unity3d.com/search?refinement=issues&gq=VideoPlayer

Others
 -Using Standard Unity Activity.(This asset has an AndroidManifest which only changed(add) WRITE_EXTERNAL_PERMISSION)
 -Demo supports runtime permission. You will need WRITE_EXTERNAL_PERMISSION to read photos and videos from phone storage.

Setting requirements
Change Build target from windows to Android.
Check Minimum build target is 6.0 or higher.
Check multi thread render is ON. *ON is faster than OFF.

[Next version]
Demo
 -Android Local Gallery works on the Daydream.
--------------------------------------------------
