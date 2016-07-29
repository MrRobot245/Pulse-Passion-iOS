

import UIKit
import RSBarcodes

class MasterViewController: UITableViewController {
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredFood = [Food]()
    var detailViewController: DetailViewController? = nil
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
            
            
            //         let querySQL = "SELECT cat,title,fRate,iList FROM DB WHERE title = title ORDER BY title COLLATE NOCASE"
            //        let results:FMResultSet? = database.executeQuery(querySQL,
            //            withArgumentsInArray: nil)
            //        while(results!.next()) {
            //             //print("\(results!.stringForColumn("cat"),results!.stringForColumn("food"))")
            //            food.append(Food(category: results!.stringForColumn("cat"), name: results!.stringForColumn("title"),
            //                fRate: results!.stringForColumn("fRate"),
            //                iList: results!.stringForColumn("iList"),
            //                gList: "",
            //                bList: ""))
        }
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        copyDatabase()
        fmdb()
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        // clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let candy: Food
        if searchController.active && searchController.searchBar.text != "" {
            candy = filteredFood[indexPath.row]
        } else {
            candy = food[indexPath.row]
        }
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let candy: Food
                if searchController.active && searchController.searchBar.text != "" {
                    candy = filteredFood[indexPath.row]
                } else {
                    candy = food[indexPath.row]
                }
                let controller = (segue.destinationViewController as! DetailViewController)
                controller.detailCandy = candy
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if segue.identifier == "sendAllBar" {
            let dbTran = segue.destinationViewController as! ScanViewController
            dbTran.getFood = food
            
            
        }
        
    }
    
    
}


extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //let searchBar = searchController.searchBar
       // let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
       // filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
extension MasterViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //filterContentForScope(searchBar.scopeButtonTitles![selectedScope])
       // filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        
    }
}

