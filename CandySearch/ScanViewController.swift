//
//  ScanViewController.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-07-06.
//
//

import UIKit
import RSBarcodes

class ScanViewController: RSCodeReaderViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.focusMarkLayer.strokeColor = UIColor.redColor().CGColor
        
        self.cornersLayer.strokeColor = UIColor.yellowColor().CGColor
        
        self.tapHandler = { point in
            print(point)
        }
        
        self.barcodesHandler = { barcodes in
            
            for barcode in barcodes {
                
                
                print("Barcode found: type=" + barcode.type + " value=" + barcode.stringValue)
            }
        }
    }

}
