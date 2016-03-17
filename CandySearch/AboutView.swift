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
   
}
