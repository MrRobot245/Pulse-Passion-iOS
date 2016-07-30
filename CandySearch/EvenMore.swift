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
    
    @IBAction func unwindToEvenMore(segue: UIStoryboardSegue) {
    }
    
 
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var catView: UILabel!
    @IBOutlet weak var ratingView: UIImageView!
    @IBOutlet weak var iListView: UITextView!

    @IBOutlet weak var ratingNum: UILabel!
    var getTopLabel:String!
    var getIngre:String!
    var getRatingPic:String!
    var getRatingNum: String!
    var getCat:String!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        self.goodView.flashScrollIndicators()
//        self.badView.flashScrollIndicators()
    }
    override func viewDidLayoutSubviews() {

    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.foodLabel.text = self.getTopLabel
        self.catView.text = self.getCat
        self.iListView.text = self.getIngre
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
