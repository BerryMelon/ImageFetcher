//
//  FlickerUrlDownloader.swift
//  hpcnt
//
//  Created by BerryMelon on 29/11/2016.
//  Copyright © 2016 berrymelon. All rights reserved.
//

import Foundation

struct FlickrUrlDownloader:ImageUrlDownloader {
    
    func getImageUrls(complete: @escaping ([URL]?) -> Void) {
        
        let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1"
        // "https://api.flickr.com/services/feeds/photos_public.gne?id=59807924@N02&lang=en-us&format=json&jsoncallback=?"
        guard let requestURL = URL(string: baseURL) else {
            complete(nil)
            return
        }
        
        getDataFromUrl(url: requestURL) { (data, response, error)  in
            
            guard let data = data else {
                complete(nil)
                return
            }
            
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                guard let items = result["items"] as? [[String:AnyObject]] else {
                    complete(nil)
                    return
                }
                
                var imageArr = [URL]()
                for itemDic in items {
                    if let media = itemDic["media"] as? [String:String] {
                        let urlStr = media["m"]!.replacingOccurrences(of: "_m", with: "")
                        imageArr.append(URL(string:urlStr)!)
                    }
                }
                complete(imageArr)
                
            } catch {
                //print(error)
                complete(nil)
                self.getImageUrls(complete: complete)
            }
            
        }
        
    }

    
}
