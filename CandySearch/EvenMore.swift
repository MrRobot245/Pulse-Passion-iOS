//
//  File.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-03-20.
//
//

import Foundation
import UIKit


class EvenMoreViewController: UIViewController
{
    @IBOutlet weak var ratingView: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!

    @IBOutlet weak var goodView: UITextView!
    @IBOutlet weak var badView: UITextView!
    
    var getTopLabel:String!
    var getgoodLabel:String!
    var getbadLabel:String!
    var getRatingPic:String!

   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.foodLabel.text = self.getTopLabel
        self.goodView.text = self.getgoodLabel
        self.badView.text = self.getbadLabel
       
        
        if(self.getRatingPic == "Red")
        {
            ratingView.image = UIImage(named: "nnRed")
        }
        if(self.getRatingPic == "Yellow")
        {
            ratingView.image = UIImage(named: "nnYellow")
        }
        if(self.getRatingPic == "Green")
        {
            ratingView.image = UIImage(named: "nnGreen")
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
