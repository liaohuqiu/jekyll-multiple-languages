---
layout: post_wide
title:  Solution for Loading Image in Android
description: 
category: blog
---
#### Problems

* Memory quota
* ListView
* OutOfMemory
* Network traffic  -> reuse / cache


---
A common workflow to load image from network:

    +-----------------------+
    |  Start to load        |
    +-------+---------------+
            |
            v
    +-----------------------+
    | Found in local cache  |
    +-------+---------------+
            |
        N --+--- Y ------------+
        |                      |
        v                      |
    +-----------------------+  |
    | Fetch from network    |  |
    +-------+---------------+  |
            |                  |
            v                  |
    +-----------------------+  |
    | Store to local cache  |  |
    +-------+---------------+  |
            |                  |
            v                  |
    +-----------------------+  |
    | Draw in ImageView     |<-+
    +-------+---------------+

---
#### Local Cache

1. Quota

2. Memory Cache

3. File Cache

> Reuse

---
#### Cross Thread

1. `Handler` and `LoadImageHandler`

2. Thread Pool

3. Task Schedule


---
#### Size and Format Control

* From network

* From local cache

> The image data in local cache is reused for a smaller size.

* Support `.webp` format.

#### Notice

* Memory In android

    * native

    * Dalvik heap

* API Level < 11 (Android 3.0), native + heap : `bitmap.recycle()`

* Bitmap Memory Use


        private static int getBytesPerPixel(Config config) {
            if (config == Config.ARGB_8888) {
                return 4;
            } else if (config == Config.RGB_565) {
                return 2;
            } else if (config == Config.ARGB_4444) {
                return 2;
            } else if (config == Config.ALPHA_8) {
                return 1;
            }
            return 1;
        }

    > 2592x1936 pixels (5 megapixels)
    > If the bitmap configuration used is ARGB_8888 (the default from the Android 2.3 onward) then loading this image into memory takes about 19MB of memory (2592*1936*4 bytes), immediately exhausting the per-app limit on some devices.
