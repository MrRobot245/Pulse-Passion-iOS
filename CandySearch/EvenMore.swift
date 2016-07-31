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
    
    @IBOutlet weak var foodTitle: UILabel!

    @IBOutlet weak var foodCat: UILabel!
    
    @IBOutlet weak var foodImg: UIImageView!
    
    @IBOutlet weak var theGood: UITextView!
    
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var theBad: UITextView!
    @IBOutlet weak var iRating: UILabel!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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
        
        
    }
    override func viewDidLayoutSubviews() {

    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
