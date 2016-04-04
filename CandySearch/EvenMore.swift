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
    
    @IBOutlet weak var ratingNum: UILabel!
    var getTopLabel:String!
    var getgoodLabel:String!
    var getbadLabel:String!
    var getRatingPic:String!
    var bulletBad: String!
    var bulletGood: String!
    var getRatingNum: String!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.goodView.flashScrollIndicators()
        self.badView.flashScrollIndicators()
    }
    override func viewDidLayoutSubviews() {
        self.goodView.setContentOffset(CGPointZero, animated: false)
        self.badView.setContentOffset(CGPointZero, animated: false)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.foodLabel.text = self.getTopLabel
        bulletBad = self.getbadLabel
        bulletGood = self.getgoodLabel
        var NewbulletBad = "• " + bulletBad.stringByReplacingOccurrencesOfString(",", withString: "\n•")
        var NewbulletGood =  "• " + bulletGood.stringByReplacingOccurrencesOfString(",", withString: "\n•")
        
        
        if (NewbulletGood == "• -")
        {
            NewbulletGood = "Not Applicable"
        }
        
        if (NewbulletBad == "• -")
        {
            NewbulletBad = "Not Applicable"
        }
        
        self.goodView.text = NewbulletGood
        self.badView.text = NewbulletBad
        self.ratingNum.text =  "Rating: "+getRatingNum+"/15"
        if(self.getRatingPic == "Limit")
        {
            ratingView.image = UIImage(named: "nnRed")
        }
        if(self.getRatingPic == "Sometimes")
        {
            ratingView.image = UIImage(named: "nnYellow")
        }
        if(self.getRatingPic == "Often")
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
