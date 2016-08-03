//
//  LearnMore.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-03-30.
//
//

import Foundation
import UIKit


class LearnMore: UIViewController

{
@IBOutlet weak var DTView: UITextView!
    override func viewDidLoad()
    {
        DTView.scrollEnabled = false;
        DTView.scrollEnabled = true;

        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.DTView.flashScrollIndicators()
    }
    override func viewDidLayoutSubviews() {
        self.DTView.setContentOffset(CGPointZero, animated: false)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
