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
    
    var resultCount: Int = 0
    
    
    
    
    
    
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
        let types = NSMutableArray(array: self.output.availableMetadataObjectTypes)
        types.removeObject(AVMetadataObjectTypeQRCode)
        self.output.metadataObjectTypes = NSArray(array: types) as [AnyObject]
        
        self.barcodesHandler = { barcodes in
            if !self.dispatched { // triggers for only once
                self.dispatched = true
                for barcode in barcodes {
                    self.resultCount = 0
                    self.barcode = barcode.stringValue
                    // print("Barcode found: type=" + barcode.type + " value=" + barcode.stringValue)
                    
                    
                    
                    
                    let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
                    let fileURL = documents.URLByAppendingPathComponent("DB2.sqlite")
                    let database = FMDatabase(path: fileURL.path)
                    if !database.open() {
                        print("Unable to open database")
                    }
                    
                    
                    let querySQL = "SELECT cat,title,fRate,iList,gList,bList,iRate FROM DB WHERE bar =" + barcode.stringValue
                    
                    let results:FMResultSet? = database.executeQuery(querySQL,
                                                                     withArgumentsInArray: nil)
                    
                    while(results!.next()) {
                        self.resultCount += 1
                        self.barFood.append(Food(category: results!.stringForColumn("cat"),
                            name: results!.stringForColumn("title"),
                            fRate: results!.stringForColumn("fRate"),
                            iList: results!.stringForColumn("iList"),
                            gList: results!.stringForColumn("gList"),
                            bList: results!.stringForColumn("bList"),
                            iRate: results!.stringForColumn("iRate")))
                        
                        
                        
                    }
                    if(self.resultCount != 0)
                    {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.performSegueWithIdentifier("barSeg", sender: self)
                            
                            // MARK: NOTE: Perform UI related actions here.
                        })
                    }
                    else{
                        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
                        dispatch_after(time, dispatch_get_main_queue()) {
                            let alert = UIAlertController(title: "Error" , message:"Food Not Found!", preferredStyle: .Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                            self.presentViewController(alert, animated: true){}
                            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
                            dispatch_after(time, dispatch_get_main_queue()) {
                                self.dispatched = false
                                self.resultCount = 0
                                self.barcode = ""
                            }
                            
                       

                           
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
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
