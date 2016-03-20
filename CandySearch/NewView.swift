//
//  NewView.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-03-19.
//
//

import UIKit

class NewViewController: UIViewController
{
    
    @IBOutlet weak var iView: UITextView!
    @IBOutlet weak var ratingView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    var image = UIImage()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        
        self.imageView.image = self.image
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
