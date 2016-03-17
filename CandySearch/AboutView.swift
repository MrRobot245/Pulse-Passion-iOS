//
//  AboutView.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-03-16.
//
//

import Foundation
import UIKit

class AboutView: UIViewController {
    @IBOutlet weak var vLabel: UILabel!
   
    @IBOutlet weak var bLabel: UILabel!
    @IBAction func webButton(sender: AnyObject) {

            UIApplication.sharedApplication().openURL(NSURL(string: "http://reymern.wix.com/pulseplus")!)
    }
    func getVersion(){
        let info:NSDictionary = NSBundle.mainBundle().infoDictionary!
        let version:String = info.objectForKey("CFBundleShortVersionString") as! String
        let build:String = info.objectForKey("CFBundleVersion") as! String
        vLabel.text = version
        bLabel.text = build
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getVersion()
    }
   
}
