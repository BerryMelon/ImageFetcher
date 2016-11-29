//
//  ImageFetcher.swift
//  hpcnt
//
//  Created by BerryMelon on 29/11/2016.
//  Copyright © 2016 berrymelon. All rights reserved.
//

import Foundation
import UIKit

class ImageFetcher {
    
    let urlDownloader:ImageUrlDownloader
    let cacheSize:Int // Mininum of 3
    
    var imageUrlStack = [URL]()
    var cachedImageDatas:[Data]
    
    init(downloader:ImageUrlDownloader, cacheSize:Int) {
        self.urlDownloader = downloader
        self.cacheSize = cacheSize < 3 ? 3 : cacheSize
        
        self.cachedImageDatas = [Data]()
    }
    
    func fetchImage(complete:@escaping (UIImage)->Void) {
        //print("Fetch Image Called; remaining ImageCaches: \(self.cachedImageDatas.count)")
        
        if self.imageUrlStack.count < self.cacheSize - 1 {
            //ImageUrlStack is low. Fetch more.
            //print("ImageUrlStack is running low. Fetching more")
            self.urlDownloader.getImageUrls(complete: { (URLs) in
                if let URLs = URLs {
                    //print("Fetched \(URLs.count) more URLs. Begin Downloading")
                    self.imageUrlStack.append(contentsOf: URLs)
                    self.downloadImage(didSuccess: {success in
                        self.fetchImage(complete: complete)
                    })
                }
            })
            
            return
        }
        
        if !self.cachedImageDatas.isEmpty {
            let imageData = self.cachedImageDatas.removeFirst()
            guard let image = UIImage(data: imageData) else {
                return
            }
            complete(image)
            
            self.downloadImage(didSuccess: {success in })
        }
        else {
            self.downloadImage(didSuccess: {success in
                self.fetchImage(complete: complete)
            })
        }
        
    }
    
    func clearCache() {
        self.imageUrlStack.removeAll()
        self.cachedImageDatas.removeAll()
    }
    
    private var downloadingInProcess = false
    
    private func downloadImage(didSuccess:@escaping (Bool)->Void) {
        
        if self.imageUrlStack.isEmpty || self.cachedImageDatas.count > self.cacheSize - 1 || self.downloadingInProcess {
            didSuccess(false)
            return
        }
        
        let imageUrl = self.imageUrlStack.removeFirst()
        
        //print("Downloading image data from URL; remaining urlstack: \(self.imageUrlStack.count)")
        self.downloadingInProcess = true
        getDataFromUrl(url: imageUrl) { (data, response, error)  in
            self.downloadingInProcess = false
            guard let data = data, error == nil else {
                didSuccess(false)
                return
            }
            //print("Download Finished: \(imageUrl)")
            self.cachedImageDatas.append(data)
            didSuccess(true)
            
            self.downloadImage(didSuccess: {success in })
        }
        
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
}
