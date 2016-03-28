/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class MasterViewController: UITableViewController {
    
    
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
        
        let querySQL = "SELECT cat,title,fRate,iList,bad,good FROM DB WHERE title = title ORDER BY title COLLATE NOCASE"
        let results:FMResultSet? = database.executeQuery(querySQL,
                                                         withArgumentsInArray: nil)
        while(results!.next()) {
            //print("\(results!.stringForColumn("cat"),results!.stringForColumn("food"))")
            food.append(Food(category: results!.stringForColumn("cat"), name: results!.stringForColumn("title"),
                fRate: results!.stringForColumn("fRate"),
                iList: results!.stringForColumn("iList"),
                gList: results!.stringForColumn("bad"),
                bList: results!.stringForColumn("good")))
            
            
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
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        //self.navigationItem.titleView = searchController.searchBar ;
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "Red", "Yellow", "Green"]
        searchController.searchBar.delegate = self
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        let searchTerms = searchText.componentsSeparatedByString(" ").filter { $0 != "" }
        
        filteredFood = food.filter { candy in
            let categoryMatch = (scope == "All") || (candy.fRate == scope)
            if searchTerms == [] && !categoryMatch {
                return false
            }
            for term in searchTerms{
                if !candy.name.lowercaseString.containsString(term.lowercaseString) {
                    return false
                }
                if !categoryMatch {
                    return false
                }
                
            }
            
            return true
        }
        tableView.reloadData()
    }
//    func filterContentForScope(scope: String = "All") {
//        filteredFood = food.filter { candy in
//            let categoryMatch = (scope == "All") || (candy.fRate == scope)
//            return  categoryMatch
//        }
//        tableView.reloadData()
//    }
//    
//    
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
        if searchController.active && searchController.searchBar.text != "" {
            return filteredFood.count
        }
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
    }
    
}
extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
extension MasterViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
         //filterContentForScope(searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        
    }
}

