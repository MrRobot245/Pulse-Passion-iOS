

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var foodRating: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var candyImageView: UIImageView!
    
    @IBOutlet weak var AltButton: UIButton!
    @IBOutlet weak var ratingNum: UILabel!
    @IBOutlet weak var iList: UITextView!
    
    @IBOutlet weak var goodView: UITextView!
    @IBOutlet weak var badView: UITextView!
    var bulletBad: String!
    var bulletGood: String!
    var sendFood = [Food]()
    var allFood = [Food]()
    var bestRated: Int = -30
    
    var bestIndex: Int = 0
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var ingred: UITextView!
    
    
    func screenEdgeSwiped(recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .Recognized {
            dispatch_async(dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("UnwindP", sender: self)
            })
           // print("Screen edge swiped!")
        }
    }

    
    
    var detailCandy: Food? {
        didSet {
            configureView()
        }
    }
    
    
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
    }
    
    func configureView() {
        if let detailCandy = detailCandy {
            if let detailDescriptionLabel = detailDescriptionLabel {
               //  iList.text = detailCandy.iList
                
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
                ratingNum.text = "Rating: "+detailCandy.iRate
                detailDescriptionLabel.text = detailCandy.name
    
                
                
                bulletBad = detailCandy.bList
                bulletGood = detailCandy.gList
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
                self.ingred.text = detailCandy.iList
                self.category.text = detailCandy.category
                
                if(detailCandy.fRate == "Sometimes")
                {
                    AltButton.hidden = false
                    bestRated = -30
                    
                    bestIndex = -1
                    
                    // print (allFood.count)
                    for i in 0...allFood.count-1 {
                        if allFood[i].category == detailCandy.category && allFood[i].fRate == "Often"
                        {
                            if(Int(allFood[i].iRate) > bestRated)
                            {
                                bestRated = Int(allFood[i].iRate)!
                                bestIndex = i
                            }
                            
                            
                        }
                    }
                    if(bestIndex == -1)
                    {
                        AltButton.hidden = true
                    }
                    else{
                        AltButton.hidden = false
                    }
                }
                
                if(detailCandy.fRate == "Limit")
                {
                    AltButton.hidden = false
                    bestRated = -30
                    
                    bestIndex = -1
                    
                   // print (allFood.count)
                    for i in 0...allFood.count-1 {
                        if allFood[i].category == detailCandy.category && allFood[i].fRate == "Often"
                        {
                            if(Int(allFood[i].iRate) > bestRated)
                            {
                                bestRated = Int(allFood[i].iRate)!
                                bestIndex = i
                            }
                            
                            
                        }
                    }
                    if(bestIndex == -1)
                    {
                        AltButton.hidden = true
                    }
                }

            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.iList.setContentOffset(CGPointZero, animated: false)
//        self.iList.contentSize = CGSizeMake(iList.frame.size.height,iList.contentSize.height);
//        self.iList.showsHorizontalScrollIndicator = false;



    }
    override func viewDidLoad() {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .Left
        
        view.addGestureRecognizer(edgePan)

        AltButton.hidden = true
        super.viewDidLoad()
        configureView()
        goodView.scrollEnabled = false;
        goodView.scrollEnabled = true;
        
        badView.scrollEnabled = false;
        badView.scrollEnabled = true;
        
        
            }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.goodView.flashScrollIndicators()
        self.badView.flashScrollIndicators()
        self.ingred.flashScrollIndicators()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goodSend" {

            sendFood.removeAll()
            sendFood.append(allFood[bestIndex])
                
         
            
           // print(sendFood[0].name)
                let vc: UINavigationController = segue.destinationViewController as! UINavigationController
                let controller = vc.topViewController as! EvenMoreViewController
                controller.getFood = sendFood
            
        }

    }
    

    
}

