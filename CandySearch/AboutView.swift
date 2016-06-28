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
    @IBAction func facebookButton(_ sender: AnyObject) {
        
         UIApplication.shared().openURL(URL(string: "https://www.facebook.com/Pulse-Passion-564611067026281/")!)
    }
    @IBAction func supportButton(_ sender: AnyObject) {
        let url = URL(string: "mailto:PulsePassionCo@gmail.com")
        UIApplication.shared().openURL(url!)
    }

    @IBAction func contactButton(_ sender: AnyObject) {
        let url = URL(string: "mailto:PulsePassionCo@gmail.com")
        UIApplication.shared().openURL(url!)
        
        
    }
    @IBOutlet weak var bLabel: UILabel!
    @IBAction func webButton(_ sender: AnyObject) {

            UIApplication.shared().openURL(URL(string: "http://pulsepassion.ca")!)
    }
    func getVersion(){
        let info:NSDictionary = Bundle.main().infoDictionary!
        let version:String = info.object(forKey: "CFBundleShortVersionString") as! String
        let build:String = info.object(forKey: "CFBundleVersion") as! String
        vLabel.text = version
        bLabel.text = build
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getVersion()
    }
   
}
