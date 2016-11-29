# Image Fetcher

The ImageFetcher automatically gets urls and downloads the image data in the background, so all you have to do is tell the ImageFetcher to give an image when needed!
Made with `Swift3.0`

### Installation

ImageFetcher requires `Xcode8+` to run.

Simply drag the two files below to your project.
- ImageFetcher.swift
- ImageUrlDownloader.swift

### Example Project
In the example project you can find a custom ImageUrlDownloader that fetches random public images from Flickr.
The example project simply shows lists of random images from Flickr, transitioning after a few seconds. 

### Usage

Implement your own ImageUrlDownloader that has a function to feed the ImageFetcher list of image urls that suits you.

```swift
//Implement your own url downloader by adopting ImageurlDownloader Protocol
struct FlickrUrlDownloader:ImageUrlDownloader {
func getImageUrls(complete: @escaping ([URL]?) -> Void) {
//get list of public image url feeds from flickr
}
}
```

Whenever you need a image from the ImageFetcher, you can simply use the fetchImage method.

```swift
//Initialize the ImageFetcher with a custom downloader, and set how many image datas the fetcher can have in its cache. Minimum size is 3.
let imageFetcher:ImageFetcher = ImageFetcher(downloader: FlickrUrlDownloader(), cacheSize: 3)

//Downloads images from the image urls. Image fetcher automatically fetches new urls from the ImageUrlDownloader whenever there are no more urls left.
imageFetcher.fetchImage(complete: {(image) in
}
```

License
----

MIT
