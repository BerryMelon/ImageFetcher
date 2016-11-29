//
//  DetailViewController.swift
//  hpcnt
//
//  Created by BerryMelon on 28/11/2016.
//  Copyright © 2016 berrymelon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var transitionValue:Int = 5

    let imageFetcher:ImageFetcher = ImageFetcher(downloader: FlickrUrlDownloader(), cacheSize: 3)
    var imageTimer:Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        self.view.addGestureRecognizer(viewTapGesture)
        
        self.doSlideShow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.imageTimer?.invalidate()
        self.imageTimer = nil
        self.imageFetcher.clearCache()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewTapped() {
        self.navigationController?.setNavigationBarHidden(!self.navigationController!.isNavigationBarHidden, animated: true)
    }
    
    func doSlideShow() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.imageFetcher.fetchImage(complete: {(image) in
            DispatchQueue.main.async() { () -> Void in
                self.activityIndicator.isHidden = true
                
                UIView.transition(with: self.imageView, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                    
                    self.imageView.image = image
                    
                    }, completion: { completion in
                        
                        if #available(iOS 10.0, *) {
                            self.imageTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.transitionValue), repeats: false, block: {timer in
                                self.doSlideShow()
                            })
                        } else {
                            // Fallback on earlier versions
                            self.imageTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.transitionValue), target: self, selector: #selector(self.doSlideShow), userInfo: nil, repeats: false)
                        }
                        
                })
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
