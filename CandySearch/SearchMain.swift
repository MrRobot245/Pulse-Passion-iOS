//
//  SearchMain.swift
//  MyPulse
//
//  Created by Nathan Reymer on 2016-07-29.
//
//



import Foundation
import UIKit

class SearchMain: UIViewController {
   
    @IBAction func unwindToMainSearch(segue: UIStoryboardSegue) {
    }
    
    @IBAction func EnterPressed(sender: AnyObject) {
        print ("Enter pressed")
    }
    @IBOutlet weak var searchField: UITextField!
    
    var food = [Food]()
    
    //FMDB
    func fmdb(){
        
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent("DB2.sqlite")
        let database = FMDatabase(path: fileURL.path)
        if !database.open() {
            print("Unable to open database")
            return
        }
        
        let querySQL = "SELECT cat,title,fRate,iList,gList,bList,iRate FROM DB WHERE title = title ORDER BY title COLLATE NOCASE"
        let results:FMResultSet? = database.executeQuery(querySQL,
                                                         withArgumentsInArray: nil)
        while(results!.next()) {
            //print("\(results!.stringForColumn("cat"),results!.stringForColumn("food"))")
            food.append(Food(category: results!.stringForColumn("cat"),
                name: results!.stringForColumn("title"),
                fRate: results!.stringForColumn("fRate"),
                iList: results!.stringForColumn("iList"),
                gList: results!.stringForColumn("gList"),
                bList: results!.stringForColumn("bList"),
                iRate: results!.stringForColumn("iRate")))
            
        }
    }
    func copyDatabase(){
        let fileManger = NSFileManager.defaultManager()
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let destinationPath = doumentDirectoryPath.stringByAppendingPathComponent("DB2.sqlite")
        let sourcePath = NSBundle.mainBundle().pathForResource("DB2", ofType: "sqlite")
        if (fileManger.fileExistsAtPath(destinationPath)) {
            try!fileManger.removeItemAtPath(destinationPath)
        }
        try! fileManger.copyItemAtPath(sourcePath!, toPath: destinationPath)
    }

        override func viewDidLoad() {
            copyDatabase()
            fmdb()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
         if (segue.identifier == "sendToTable") {
        
        let vc: UINavigationController = segue.destinationViewController as! UINavigationController
        let detailVC = vc.topViewController as! MasterViewController
        detailVC.getFood = food
        }
        
//        
//        if (segue.identifier == "sendToTable") {
//            let dest = segue.destinationViewController as! MasterViewController
//            dest.getFood = food
//            //Assign to dest's properties
//        }
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        
//        if segue.identifier == "sendToTable" {
//            let vc = segue.destinationViewController as! MasterViewController
//            vc.getFood = food
//        }
//        
//        
//    }
//    
}
