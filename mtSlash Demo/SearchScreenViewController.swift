//
//  SearchScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/20/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit
import CoreData

var searchKeyword : String? = nil

class SearchScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var keywordInputField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var fetchedSearchHistoryItems : [MTSearchHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        retrieveSearchHistory()
    }
    
    // Function for retrieving search history entries from database
    func retrieveSearchHistory() {
        // Wait until the framework is initialized
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController : DefaultDataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Set up fetch requests
        let searchHistoryEntriesFetchRequest = NSFetchRequest(entityName: "MTSearchHistory")
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        let predicateForFetchingSpecifiySearchHistory = NSPredicate(format: "(belongTo == %@)", argumentArray: [currentUser])
        searchHistoryEntriesFetchRequest.predicate = predicateForFetchingSpecifiySearchHistory
        searchHistoryEntriesFetchRequest.fetchLimit = 5
        
        var searchHistoryItems : [MTSearchHistory]? = nil
        
        // Fetch user-specific search history from the data framework
        do {
            searchHistoryItems = try managedObjectContextInUse.executeFetchRequest(searchHistoryEntriesFetchRequest) as? [MTSearchHistory]
        } catch {
            fatalError("An error has occurred: Failed to fetch search history from the database.")
        }
        
        // Sort the search history entries by time added, then expose them
        let timeAddedSortDescriptor : NSSortDescriptor = NSSortDescriptor(key: "timeAdded", ascending: false)
        let sortedSearchHistoryEntries = NSArray(array: searchHistoryItems!).sortedArrayUsingDescriptors([timeAddedSortDescriptor])
        fetchedSearchHistoryItems = sortedSearchHistoryEntries as! [MTSearchHistory]
        
        // Reload the table view
        searchHistoryTableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        let searchInput = keywordInputField.text
        
        if searchInput == nil || searchInput == "" {
            let searchKeywordNotAvailable = UIAlertController(title: "无效的搜索关键词", message: "您似乎并没有输入任何搜索关键词。请重新输入后再试。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                searchKeywordNotAvailable.dismissViewControllerAnimated(true, completion: nil)
            })
            searchKeywordNotAvailable.addAction(OKAction)
            self.presentViewController(searchKeywordNotAvailable, animated: true, completion: nil)
            return
        }
        
        // Add current keyword to search history
        // Wait until the framework is initialized.
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Get current user
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        // Initialize a new reading list item based on current data model
        let newSearchHistoryEntry = NSEntityDescription.insertNewObjectForEntityForName("MTSearchHistory", inManagedObjectContext: managedObjectContextInUse) as! MTSearchHistory
        
        // Set values of the new entry
        newSearchHistoryEntry.setValuesOfSearchHistoryEntry(searchInput!, timeAdded: NSDate(), belongTo: currentUser)
        
        // Save the changes
        do {
            try managedObjectContextInUse.save()
        } catch {
            fatalError("An error has occurred: New search history entry cannot be saved.")
        }
        
        // Clear the text field
        keywordInputField.text = ""
        
        // Refresh the search history table view
        retrieveSearchHistory()
        
        // Expose search keyword
        searchKeyword = searchInput!
        
        // Transition to the search result screen
        self.performSegueWithIdentifier("fromSearchScreenToSearchResultScreen", sender: self)
        
    }
    
    // Required function for UITableViewDataSource protocol
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedSearchHistoryItems.count
    }
    
    // Required function for UITableViewDataSource protocol
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Always return an empty cell if no search history is available
        if fetchedSearchHistoryItems.count == 0 {
            return UITableViewCell()
        }
        
        let currentIndex = indexPath.indexAtPosition(1)
        
        // Request a standard cell from tableView
        let cell = tableView.dequeueReusableCellWithIdentifier("standardSearchHistoryEntryContainerCell")! as! standardSearchHistoryEntryContainerCell
        
        // Load the corresponding entry from the list of search history
        let requestedSearchHistoryEntry = fetchedSearchHistoryItems[currentIndex]
        let keyword = requestedSearchHistoryEntry.keyword!
        let timeAdded = requestedSearchHistoryEntry.timeAdded!
        
        // Configure the cell
        cell.setValuesOfCell(keyword, timeAdded: timeAdded)
        
        // Disable the selection style
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    // Specify the height for each row in the table view
    // Cells in this table view have a fixed height of 25.0
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 25.0
    }
    
    // Specify the estimated height for each row in the table view, as to improve the performance
    //Cells in this table view have a fixed estimated height of 25.0
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 25.0
    }
    
    // Function to call when a cell is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! standardSearchHistoryEntryContainerCell
        
        searchKeyword = selectedCell.keyword
        
        performSegueWithIdentifier("fromSearchScreenToSearchResultScreen", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
