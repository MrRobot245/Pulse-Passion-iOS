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
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var labelView: UILabel!
    

    var getTopLabel:String!
    var getgoodLabel:String!
    var getbadLabel:String!
    var getRatingPic:String!

   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.foodLabel.text = self.getTopLabel
        self.labelView.text = self.getgoodLabel
        self.badLabel.text = self.getbadLabel
       
        
        if(self.getRatingPic == "1")
        {
            ratingView.image = UIImage(named: "Ured")
        }
        if(self.getRatingPic == "2")
        {
            ratingView.image = UIImage(named: "Uyellow")
        }
        if(self.getRatingPic == "3")
        {
            ratingView.image = UIImage(named: "Ugreen")
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
