Flicker test app (Flickr API)
===========================

## Sample project requirements

Create a project in Swift with the following requirements:

* Single screen project using an appropriate architecture.
* Translucent navigation bar at the top of the screen.
* Each row should have: 
    * an image (item media), 
    * a title (item title) 
    * subtitle (item date taken in human friendly format like 2 days ago)

Extras:
* Pull to refresh
* Create a few unit/UI tests.
* Make use of any iOS libraries you like.

The main criteria is the code structure / quality.
Code test coverage is not important.
There should be some basic styling - positioning, margins, etc. but this is not an important aspect.

Use the following API for content:

https://api.flickr.com/services/feeds/photos_public.gne?format=json&lang=en-us&nojsoncallback=1

If parsing errors occur just show an error in a popup