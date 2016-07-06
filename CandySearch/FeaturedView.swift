//
//  FeaturedView.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-03-19.
//
//

import Foundation
import UIKit
class FeaturedView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    let productName = ["Chickpea and Red Lentil Pizza Dough", "Red Lentil Crackers", "Lentil Muffins", "Chickpea Shake and Bake"]
    let imageArray = [UIImage(named: "rPizza3"), UIImage(named: "crack2"), UIImage(named: "muff2"),  UIImage(named: "shake2")]
    let ingredArray = ["Whole Grain Wheat Flour, Lentil Flour, Chickpea Flour , Cayenne Infused Olive Oil, Sugar, Yeast, Salt",
                       "Lentils, Whole Grain Wheat Flour, Egg, Flaxseed (Ground) , Canola Oil, Baking Powder , Salt, Baking Soda, Rosemary, Pepper, Turmeric",
                       "Lentils, Skim Milk , Carrots, Brown Sugar, Whole Grain Wheat Flour, Egg, Canola Oil, Flaxseed (Ground) , Wheat Bran, Baking Powder , Baking Soda, Vanilla Extract, Cinnamon",
                       "Chickpea Flour , Garlic Powder, Cajun Spice, Paprika, Salt"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.productName.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.imageView?.image = self.imageArray[indexPath.row]
        cell.titleLabel?.text = self.productName[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showImage"
        {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destinationViewController as! NewViewController
            vc.image = self.imageArray[indexPath.row]!
            vc.getTopLabel = self.productName[indexPath.row]
            vc.getiList = self.ingredArray[indexPath.row]
            
            vc.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
            vc.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
}

