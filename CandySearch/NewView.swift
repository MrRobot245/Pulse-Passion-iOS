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
    var getTopLabel:String!
    var getiList:String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        
        self.imageView.image = self.image
        self.topLabel.text = self.getTopLabel
        self.ratingView.image = UIImage(named: "nnGreen")
        self.iView.text = self.getiList
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
