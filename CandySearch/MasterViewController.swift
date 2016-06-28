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
        
        let documents = try! FileManager.default().urlForDirectory(.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = try! documents.appendingPathComponent("DB2.sqlite")
        let database = FMDatabase(path: fileURL.path)
        if !(database?.open())! {
            print("Unable to open database")
            return
        }
        
        let querySQL = "SELECT cat,title,fRate,iList,gList,bList,iRate FROM DB WHERE title = title ORDER BY title COLLATE NOCASE"
        let results:FMResultSet? = database?.executeQuery(querySQL,
                                                         withArgumentsIn: nil)
        while(results!.next()) {
            //print("\(results!.stringForColumn("cat"),results!.stringForColumn("food"))")
            food.append(Food(category: results!.string(forColumn: "cat"), name: results!.string(forColumn: "title"),
                fRate: results!.string(forColumn: "fRate"),
                iList: results!.string(forColumn: "iList"),
                gList: results!.string(forColumn: "gList"),
                bList: results!.string(forColumn: "bList"),
                iRate: results!.string(forColumn: "iRate")))
            
            
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
        searchController.searchBar.scopeButtonTitles = ["All", "Limit", "Sometimes", "Often"]
        //searchController.searchBar.scopeButtonTitles = ["All", "Red", "Yellow", "Green"]
        searchController.searchBar.delegate = self
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        let searchTerms = searchText.components(separatedBy: " ").filter { $0 != "" }
        
        filteredFood = food.filter { candy in
            let categoryMatch = (scope == "All") || (candy.fRate == scope)
            if searchTerms == [] && !categoryMatch {
                return false
            }
            for term in searchTerms{
                if !candy.name.lowercased().contains(term.lowercased()) {
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
    override func viewWillAppear(_ animated: Bool) {
        // clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func copyDatabase(){
        let fileManger = FileManager.default()
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let destinationPath = doumentDirectoryPath.appendingPathComponent("DB2.sqlite")
        let sourcePath = Bundle.main().pathForResource("DB2", ofType: "sqlite")
        if (fileManger.fileExists(atPath: destinationPath)) {
            try!fileManger.removeItem(atPath: destinationPath)
        }
        try! fileManger.copyItem(atPath: sourcePath!, toPath: destinationPath)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredFood.count
        }
        return food.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let candy: Food
        if searchController.isActive && searchController.searchBar.text != "" {
            candy = filteredFood[(indexPath as NSIndexPath).row]
        } else {
            candy = food[(indexPath as NSIndexPath).row]
        }
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let candy: Food
                if searchController.isActive && searchController.searchBar.text != "" {
                    candy = filteredFood[(indexPath as NSIndexPath).row]
                } else {
                    candy = food[(indexPath as NSIndexPath).row]
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
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}
extension MasterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
         //filterContentForScope(searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        
    }
}

