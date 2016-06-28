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
    
    @IBAction func HeartButton(_ sender: AnyObject) {
        UIApplication.shared().openURL(URL(string: "https://ehealth.heartandstroke.ca")!)
    }


    
}
