Simple Class that lets you fetch unlimited images from wherever image sources you provide.

# Image Fetcher

By setting your customized ImageUrlDownloader(*see below for detailed instruction*), ImageFetcher automatically gets urls and downloads the image data in the background, so all you have to do is tell the ImageFetcher to give an image when needed!
Made with `Swift3.0`

### Installation

ImageFetcher requires `Xcode8+` to run.

Simply drag the two files below to your project.
- ImageFetcher.swift
- ImageUrlDownloader.swift

### Example Project
In the example project you can find a custom ImageUrlDownloader that fetches random public images from Flickr.
The example project simply shows lists of random images from Flickr, transitioning after a few seconds. And it's done by simply asking the ImageFetcher to fetch a new image when needed. 
ImageFetcher caches several images(*minimum of 3*) so whenever the user needs a new image it returns it without delay.

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

Copyright (c) 2016 Doheny Yoon

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
