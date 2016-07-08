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
    
    @IBAction func unwindToAbout(segue: UIStoryboardSegue) {
    }
    
    
    @IBAction func facebookButton(sender: AnyObject) {
        
         UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/Pulse-Passion-564611067026281/")!)
    }
    @IBAction func supportButton(sender: AnyObject) {
        let url = NSURL(string: "mailto:PulsePassionCo@gmail.com")
        UIApplication.sharedApplication().openURL(url!)
    }

    @IBAction func contactButton(sender: AnyObject) {
        let url = NSURL(string: "mailto:PulsePassionCo@gmail.com")
        UIApplication.sharedApplication().openURL(url!)
        
        
    }
    @IBAction func HeartButton(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://ehealth.heartandstroke.ca")!)
    }
    @IBOutlet weak var bLabel: UILabel!
    @IBAction func webButton(sender: AnyObject) {

            UIApplication.sharedApplication().openURL(NSURL(string: "http://pulsepassion.ca")!)
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
