/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var foodRating: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var candyImageView: UIImageView!
    
    @IBOutlet weak var ratingNum: UILabel!
    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var iList: UITextView!
    var detailCandy: Food? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailCandy = detailCandy {
            if let detailDescriptionLabel = detailDescriptionLabel, candyImageView = candyImageView {
                candyImageView.image = UIImage(named: "logoNoText")
                 iList.text = detailCandy.iList
                if(detailCandy.fRate == "Limit")
                {
                foodRating.image = UIImage(named: "nnRed")
                }
                if(detailCandy.fRate == "Sometimes")
                {
                    foodRating.image = UIImage(named: "nnYellow")
                }
                if(detailCandy.fRate == "Often")
                {
                    foodRating.image = UIImage(named: "nnGreen")
                }
                ratingNum.text = "Rating: "+detailCandy.iRate+"/15"
                detailDescriptionLabel.text = detailCandy.name
                catLabel.text = detailCandy.category

            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.iList.setContentOffset(CGPointZero, animated: false)
        self.iList.contentSize = CGSizeMake(iList.frame.size.height,iList.contentSize.height);
        self.iList.showsHorizontalScrollIndicator = false;



    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
            }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.iList.flashScrollIndicators()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "showMore" {
            let vc = segue.destinationViewController as! EvenMoreViewController
            vc.getTopLabel = detailCandy?.name
            vc.getbadLabel = detailCandy?.bList
            vc.getgoodLabel = detailCandy?.gList
            vc.getRatingPic = detailCandy?.fRate

           }
    }
    
}

