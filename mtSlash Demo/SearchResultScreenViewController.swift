//
//  SearchResultScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/8/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit

class SearchResultScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    var fetchedSearchResultEntries : [NSDictionary] = []
    var currentPageOfSearchResult : Int = 1
    var searchID : Int = -1
    var numberOfSearchResults : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Fetch search result from the server from WebLinks class
        retrieveSearchResultFromServer()
    }

    func retrieveSearchResultFromServer() {
        // Read the URL of backend server
        let serverEndURLForRetrievingSearchResult = WebLinks.getAddressOfWebLink(WebLinks.BasicSearch)
        
        // Download the list of search result from server and read them into fetchedSearchResultEntries variable
        let sessionForRetrievingSearchResult = NSURLSession.sharedSession()
        let requestForRetrievingSearchResult = NSMutableURLRequest(URL: serverEndURLForRetrievingSearchResult)
        requestForRetrievingSearchResult.HTTPMethod = "POST"
        requestForRetrievingSearchResult.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        let HTTPBodyContentForRequest = "keyword=\(searchKeyword!)&page=\(currentPageOfSearchResult)&search_id=\(searchID)"
        print(HTTPBodyContentForRequest)
        requestForRetrievingSearchResult.HTTPBody = HTTPBodyContentForRequest.dataUsingEncoding(NSUTF8StringEncoding)
        let taskForRetrievingSearchResult = sessionForRetrievingSearchResult.dataTaskWithRequest(requestForRetrievingSearchResult) { (data, response, error) in
            if error == nil && data != nil {
                let retrievedSearchResult = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                self.numberOfSearchResults = retrievedSearchResult["number_of_results"] as! Int
                self.fetchedSearchResultEntries = retrievedSearchResult["results"] as! [NSDictionary]
                let searchIDAsString = retrievedSearchResult["search_id"] as! String
                self.searchID = Int(searchIDAsString)!
                dispatch_async(dispatch_get_main_queue(), {
                    self.searchResultTableView.reloadData()
                })
                
            } else {
                // Issue a warning if an error has occurred
                dispatch_async(dispatch_get_main_queue(), {
                    let retrievalOfSearchResultFailed = UIAlertController(title: "无法取得搜索结果", message: "似乎发生了一个网络错误。您的数据链接可能已经中断，或服务器暂时无法为您提供服务。请稍后再试", preferredStyle: UIAlertControllerStyle.Alert)
                    let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                        retrievalOfSearchResultFailed.dismissViewControllerAnimated(true, completion: nil)
                    })
                    retrievalOfSearchResultFailed.addAction(OKAction)
                    self.presentViewController(retrievalOfSearchResultFailed, animated: true, completion: nil)
                })
            }
        }
        taskForRetrievingSearchResult.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure info panel
        let currentIndex = indexPath.indexAtPosition(1)
        
        if currentIndex == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("infoPanelContainerCell", forIndexPath: indexPath) as! infoPanelContainerCell
            
            // Update the search summary label in info panel container cell when results are not yet fetched
            if fetchedSearchResultEntries == [] {
                cell.updateSearchSummaryLabel("正在接受从服务器返回的搜索结果，请稍候。您也可以更改搜索关键词重新进行搜索。")
            } else {
            // Update the search summary label in info panel container cell when results have been retrieved
                cell.updateSearchSummaryLabel("搜索关键词\(searchKeyword!)共返回\(numberOfSearchResults)项结果。浏览下方的条目并找到符合您要求的主题，或更改搜索关键词以进一步缩小结果。")
            }
            return cell
        }
        
        let currentSearchResultEntry = fetchedSearchResultEntries[currentIndex - 1]
        let threadID = currentSearchResultEntry["tid"] as! Int
        let titleOfThread = currentSearchResultEntry["topic_title"] as! String
        let viewCountOfThread = currentSearchResultEntry["no_of_views"] as! Int
        let noOfRepliesOfThread = currentSearchResultEntry["no_of_replies"] as! Int
        let summaryOfThread = currentSearchResultEntry["topic_summary"] as! String
        let publishTimeOfThread = currentSearchResultEntry["publish_time"] as! String
        let authorNameOfThread = currentSearchResultEntry["author"] as! String
        let sectionReferenceOfThread = currentSearchResultEntry["section"] as! Int
        
        print(titleOfThread)
        
        // Configure standardSearchResultContainerCell
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultContainerCell", forIndexPath: indexPath) as! searchResultContainerCell
        cell.setAdditionalInfo(threadID, sectionRef: sectionReferenceOfThread)
        cell.setTitleAndSummaryOfThread(titleOfThread, summary: summaryOfThread)
        cell.setNoOfRepliesAndViewCount(noOfRepliesOfThread, viewCount: viewCountOfThread)
        cell.setUsernameAndPublishDate(authorNameOfThread, publishDate: publishTimeOfThread)
        
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedSearchResultEntries.count + 1
    }
    
    @IBAction func redoSearchButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
