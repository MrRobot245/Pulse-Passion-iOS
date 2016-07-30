//
//  PageItemController.swift
//  Paging_Swift
//
//  Created by olxios on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit

class PageItemController: UIViewController {
    
    // MARK: - Variables
    var itemIndex: Int = 0
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
    
    @IBOutlet weak var HelpText: UITextView!
    
    @IBOutlet weak var CloseButton: UIButton!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        CloseButton.layer.masksToBounds = true
        CloseButton.layer.cornerRadius = 5.0
        super.viewDidLoad()
        contentImageView!.image = UIImage(named: imageName)
    }
}
