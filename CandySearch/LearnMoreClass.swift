//
//  LearnMoreClass.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-04-15.
//
//

import Foundation
import UIKit


class LearnMoreClass: UIViewController

    
{
    
    @IBAction func HeartButton(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://ehealth.heartandstroke.ca")!)
    }


    
}
