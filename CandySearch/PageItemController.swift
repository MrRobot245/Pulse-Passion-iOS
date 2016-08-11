//
//  PageItemController.swift
//  Paging_Swift
//
//  Created by olxios on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    @IBOutlet weak var HelpText: UITextView!
    @IBOutlet weak var textArea: UITextView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func QuestionnaireAction(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://ehealth.heartandstroke.ca/questions")!)
    }
    @IBOutlet weak var QuestionnaireButton: UIButton!
    // MARK: - Variables
    var itemIndex: Int = 0
    var HelpTextText: String = ""
    var LabelTextText: String = ""
    @IBOutlet weak var labelName: UILabel!
    var imageName: String = "" {
        
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
              
            }
            
        }
    }
    
    @IBOutlet var contentImageView: UIImageView?
    
    @IBAction func CloseButtonAction(sender: AnyObject) {
        
        
    }

    @IBOutlet weak var CloseButton: UIButton!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        if itemIndex==4
        {
            QuestionnaireButton.hidden=false
            CloseButton.hidden = false
            
            
        }
        else{
            QuestionnaireButton.hidden=true
            CloseButton.hidden=true
           // print(itemIndex)
        }
          textArea.text = HelpTextText
        titleLabel.text = LabelTextText
        QuestionnaireButton.layer.masksToBounds = true
        QuestionnaireButton.layer.cornerRadius = 5.0
        super.viewDidLoad()
        contentImageView!.image = UIImage(named: imageName)
    }
}
