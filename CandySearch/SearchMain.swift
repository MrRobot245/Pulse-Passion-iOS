//
//  SearchMain.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-07-29.
//
//



import Foundation
import UIKit

class SearchMain: UIViewController {
   
    @IBAction func unwindToMainSearch(segue: UIStoryboardSegue) {
    }
    
    @IBAction func EnterPressed(sender: AnyObject) {
        print ("Enter pressed")
    }
    @IBOutlet weak var searchField: UITextField!
    
    
        override func viewDidLoad() {

    }
    
}
