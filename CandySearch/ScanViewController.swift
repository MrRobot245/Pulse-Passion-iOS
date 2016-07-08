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
    
    var barFood = [Food]()
    
    
    
    
    
    
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
                    // print("Barcode found: type=" + barcode.type + " value=" + barcode.stringValue)
                    
                    
                    
                    
                    let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
                    let fileURL = documents.URLByAppendingPathComponent("DB2.sqlite")
                    let database = FMDatabase(path: fileURL.path)
                    if !database.open() {
                        print("Unable to open database")
                    }
                    let querySQL = "SELECT cat,title,fRate,iList,gList,bList,iRate FROM DB WHERE bar =" + barcode.stringValue
                    
                    //let querySQL = "SELECT cat,title,fRate,iList,gList,bList,iRate FROM DB WHERE title = 'Apple Envy'"
                    
                    let results:FMResultSet? = database.executeQuery(querySQL,
                                                                     withArgumentsInArray: nil)
                    while(results!.next()) {
                        self.barFood.append(Food(category: results!.stringForColumn("cat"),
                            name: results!.stringForColumn("title"),
                            fRate: results!.stringForColumn("fRate"),
                            iList: results!.stringForColumn("iList"),
                            gList: results!.stringForColumn("gList"),
                            bList: results!.stringForColumn("bList"),
                            iRate: results!.stringForColumn("iRate")))
                        
                        
                        
                    }
                    
//                    let alert = UIAlertController(title: self.barFood[0].name , message:barcode.stringValue, preferredStyle: .Alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
//                    self.presentViewController(alert, animated: true){}
                    
                    
                    
                    
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
            let controller = (segue.destinationViewController as! DetailViewController)
            controller.detailCandy = barFood[0]
       
        }
    }
    
    
}
