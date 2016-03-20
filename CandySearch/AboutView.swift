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
   

    @IBAction func facebookButton(sender: AnyObject) {
        
         UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/Pulse-Passion-564611067026281/")!)
    }
    @IBAction func supportButton(sender: AnyObject) {
    }

    @IBAction func contactButton(sender: AnyObject) {
    }
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
