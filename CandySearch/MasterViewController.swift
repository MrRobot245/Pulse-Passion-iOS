

import UIKit
import RSBarcodes

class MasterViewController: UITableViewController {
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var detailViewController: DetailViewController? = nil
    
    var getFood = [Food]()


      override func viewDidLoad() {
     
        self.searchController.loadViewIfNeeded()
        //self.resultSearchController.loadViewIfNeeded()
    }

    override func viewWillAppear(animated: Bool) {
        // clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getFood.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let candy: Food

            candy = getFood[indexPath.row]
        
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let candy: Food
                    candy = getFood[indexPath.row]
                let controller = (segue.destinationViewController as! DetailViewController)
                controller.detailCandy = candy
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if segue.identifier == "sendAllBar" {
            let dbTran = segue.destinationViewController as! ScanViewController
            dbTran.getFood = getFood
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

