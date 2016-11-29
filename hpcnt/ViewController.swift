//
//  ViewController.swift
//  hpcnt
//
//  Created by BerryMelon on 28/11/2016.
//  Copyright © 2016 berrymelon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var transitionSlider: UISlider!
    @IBOutlet weak var transitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.transitionLabel.text = "\(Int(self.transitionSlider.value))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController , segue.identifier == "DetailViewController" {
            vc.transitionValue = sender as! Int
        }
    }
    
    @IBAction func transitionValueChanged(_ sender: AnyObject) {
        
        let discreteValue = round(self.transitionSlider.value)
        self.transitionLabel.text = "\(Int(discreteValue))"
        
    }

    @IBAction func startButtonTapped(_ sender: AnyObject) {
        
        let discreteValue = round(self.transitionSlider.value)
        self.performSegue(withIdentifier: "DetailViewController", sender: Int(discreteValue))
    }
    
}

