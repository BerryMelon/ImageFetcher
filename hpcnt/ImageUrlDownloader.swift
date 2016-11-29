//
//  ImageUrlDownloader.swift
//  hpcnt
//
//  Created by BerryMelon on 29/11/2016.
//  Copyright © 2016 berrymelon. All rights reserved.
//

import Foundation
import UIKit

protocol ImageUrlDownloader {
    
    func getImageUrls(complete:@escaping ([URL]?)->Void)
}

extension ImageUrlDownloader {
    internal func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}
