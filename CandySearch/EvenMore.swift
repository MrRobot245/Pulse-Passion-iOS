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
    var getFood = [Food]()
    
    @IBAction func unwindToEvenMore(segue: UIStoryboardSegue) {
    }
    var bulletBad: String!
    var bulletGood: String!
    
    @IBOutlet weak var foodTitle: UILabel!

    @IBOutlet weak var foodCat: UILabel!
    
    @IBOutlet weak var foodImg: UIImageView!
    
    @IBOutlet weak var theGood: UITextView!
    
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var theBad: UITextView!
    @IBOutlet weak var iRating: UILabel!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    override func viewDidLayoutSubviews() {

    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        theGood.scrollEnabled = false;
        theGood.scrollEnabled = true;
        
        theBad.scrollEnabled = false;
        theBad.scrollEnabled = true;
        self.theGood.flashScrollIndicators()
        self.theBad.flashScrollIndicators()
        
        
        if(getFood[0].fRate == "Limit")
        {
            foodImg.image = UIImage(named: "nnRed")
        }
        if(getFood[0].fRate == "Sometimes")
        {
            foodImg.image = UIImage(named: "nnYellow")
        }
        if(getFood[0].fRate == "Often")
        {
            foodImg.image = UIImage(named: "nnGreen")
        }
        bulletBad = getFood[0].bList
        bulletGood = getFood[0].gList
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
        
        self.theGood.text = NewbulletGood
        self.theBad.text = NewbulletBad
        foodTitle.text = getFood[0].name
        foodCat.text = getFood[0].category
        iRating.text = "Rating: "+getFood[0].iRate
        ingredients.text = getFood[0].iList
        


    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
