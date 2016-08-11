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
       var searchedFood = [Food]()
    var food = [Food]()
    var barFood = [Food]()

    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchButton(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var searchField: UITextField!
    @IBAction func unwindToMainSearch(segue: UIStoryboardSegue) {
        
    }
    @IBAction func EnterPressed(sender: AnyObject) {

    }
    @IBAction func ReturnPls(sender: AnyObject) {
         performSegueWithIdentifier("sendToTable", sender: self)
    }
    

    
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
        barFood  = food
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
        isAppAlreadyLaunchedOnce()
        copyDatabase()
        fmdb()
        searchField.layer.masksToBounds = true
        searchField.layer.cornerRadius = 7.0
        searchButton.layer.masksToBounds = true
        searchButton.layer.cornerRadius = 5.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchMain.tap(_:)))
        view.addGestureRecognizer(tapGesture)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarPosition: .Any, barMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    func tap(gesture: UITapGestureRecognizer) {
        searchField.resignFirstResponder()
    }
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.stringForKey("isAppAlreadyLaunchedOnce") != nil{
           // print("App already launched")
            return true
        }else{
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnce")
//            print("App launched first time")
            dispatch_async(dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("SendWalk", sender: self)
            })
            return false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "sendToTable") {
            
            let controller = segue.destinationViewController as! MasterViewController
            
     
            searchedFood = []
            for i in 1...food.count-1 {
                let string = food[i].name
                // print (string)
                let result1 = string.containsString(searchField.text!)
                if result1 == true
                {
                    searchedFood.append(food[i])
                }
            }
            controller.getFood = searchedFood
        }
        if segue.identifier == "sendAllBar" {
            let dbTran = segue.destinationViewController as! ScanViewController
            dbTran.getFood = barFood
        }
        
    }
}
