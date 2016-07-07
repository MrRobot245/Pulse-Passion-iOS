//
//  ScanViewController.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-07-06.
//
//

import UIKit
import RSBarcodes
import AVFoundation

class ScanViewController: RSCodeReaderViewController {
    var barcode: String = ""
    var dispatched: Bool = false
    var getFood = [Food]()
    
    @IBOutlet weak var FlashButt: UIButton!
    
    @IBAction func flashLight(sender: AnyObject) {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.On) {
                    device.torchMode = AVCaptureTorchMode.Off
                    let image = UIImage(named: "FlashOff")! as UIImage
                    FlashButt.setImage(image, forState: UIControlState.Normal)
                } else {
                    try device.setTorchModeOnWithLevel(1.0)
                    let image = UIImage(named: "FlashOn")! as UIImage
                    FlashButt.setImage(image, forState: UIControlState.Normal)
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.focusMarkLayer.strokeColor = UIColor.whiteColor().CGColor
        self.cornersLayer.strokeColor = UIColor.greenColor().CGColor
        for subview in self.view.subviews {
            self.view.bringSubviewToFront(subview)
        }
        
//        print (getFood.count)
        
        // MARK: NOTE: If you layout views in storyboard, you should these 3 lines
        for subview in self.view.subviews {
            self.view.bringSubviewToFront(subview)
        }
        
        if !self.hasTorch() {
            FlashButt.enabled = false
        }
        
        
        self.barcodesHandler = { barcodes in
            if !self.dispatched { // triggers for only once
                self.dispatched = true
                for barcode in barcodes {
                    self.barcode = barcode.stringValue
                    print("Barcode found: type=" + barcode.type + " value=" + barcode.stringValue)
                    
                    let alert = UIAlertController(title: "Hey-o!", message:barcode.stringValue, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                    self.presentViewController(alert, animated: true){}
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.performSegueWithIdentifier("barSeg", sender: self)
                        
                        // MARK: NOTE: Perform UI related actions here.
                    })
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.dispatched = false // reset the flag so user can do another scan
        super.viewWillAppear(animated)
        //        self.navigationController?.navigationBarHidden = true
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "barSeg" {
            //            let vc = segue.destinationViewController as! EvenMoreViewController
        }
    }
    
    
}
