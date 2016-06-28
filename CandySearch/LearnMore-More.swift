//
//  LearnMore.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-03-30.
//
//

import Foundation
import UIKit


class LearnMoreMore: UIViewController
    
{
    @IBOutlet weak var TView: UITextView!

    override func viewDidLoad()
    {
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.TView.flashScrollIndicators()
    }
    override func viewDidLayoutSubviews() {
        self.TView.setContentOffset(CGPoint.zero, animated: false)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
