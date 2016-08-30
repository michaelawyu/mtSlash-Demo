//
//  PostsViewScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/29/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class PostsViewScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var navigationItemOnCurrentPage: UINavigationItem!
    
    var currentNumberOfPages : Int = 1
    var selectedAuthorID : Int = -1
    var listOfPosts : [NSDictionary] = []
    
     // Initiate a parser
    var bulletinBoardCodeParser = BulletinBoardCode2NSMutableAttributedStringParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set height and estimated height of the rows in the table view, enabling auto dimension
        postsTableView.estimatedRowHeight = 400.0
        postsTableView.rowHeight = UITableViewAutomaticDimension
        
        // Set the style of navigation bar to light style, better accomodate current settings
        NavigationBarStylesInTopicsAndPostsViewScreen.setStyleOfNavigationBarToLightStyle(navigationBarInTopicsAndPostsViewScreens!)
        
        // Retrieve posts from the server
        retrievePostsFromServer()
       
    }
    
    // Function for retrieving posts from the server
    func retrievePostsFromServer() {
        // Fetch the URL of backend Server from WebLinks class
        let serverEndURLForRetrievingPosts = WebLinks.getAddressOfWebLink(WebLinks.RetrievePosts)
        
        // Download the list of threads from the server and read them into listOfThreads variable
        let sessionForRetrievingPosts = NSURLSession.sharedSession()
        let requestForRetrievingPosts = NSMutableURLRequest(URL: serverEndURLForRetrievingPosts)
        requestForRetrievingPosts.HTTPMethod = "POST"
        requestForRetrievingPosts.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        let HTTPBodyContentForRequest = "tid=\(threadID!)&author_id=\(selectedAuthorID)&limit_multiplier=\(currentNumberOfPages)"
        requestForRetrievingPosts.HTTPBody = HTTPBodyContentForRequest.dataUsingEncoding(NSUTF8StringEncoding)
        let taskForRetrievingPosts = sessionForRetrievingPosts.dataTaskWithRequest(requestForRetrievingPosts) { (data, response, error) in
            if error == nil && data != nil {
                let retrievedPosts = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                self.listOfPosts = retrievedPosts["results"]! as! [NSDictionary]
                dispatch_async(dispatch_get_main_queue(), {
                    self.postsTableView.reloadData()
                })
            } else {
                // Issuse a warning if an error has occurred
                dispatch_async(dispatch_get_main_queue(), {
                    let retrievalOfPostsFailed = UIAlertController(title: "无法获取帖子列表", message: "似乎发生了一个网络错误。您的数据链接可能已经中断，或服务器暂时无法为您提供服务。请稍后再试。", preferredStyle: UIAlertControllerStyle.Alert)
                    let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                        retrievalOfPostsFailed.dismissViewControllerAnimated(true, completion: nil)
                    })
                    retrievalOfPostsFailed.addAction(OKAction)
                    self.presentViewController(retrievalOfPostsFailed, animated: true, completion: nil)
                })
            }
        }
        taskForRetrievingPosts.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPosts.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentEntryIndex = indexPath.indexAtPosition(1)
        
        // If list of threads is not available yet, return a cell indicating that the list of posts is still being retrieved
        if listOfPosts.count == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("noContentSignifierCell")!
            return cell
        }
        
         // If reaches the end of list of the threads, return a cell indicating the option to load more posts from server
        if currentEntryIndex == listOfPosts.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("loadMorePostsSignifierCell")!
            return cell
        }
        
        // Configure the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("standardPostContainerCell")! as! postContainerCell
        
        let currentPost = listOfPosts[currentEntryIndex]
        
        let pid = currentPost["pid"]! as! Int
        let fid = currentPost["fid"]! as! Int
        let tid = currentPost["tid"]! as! Int
        let authorName = currentPost["author"]! as! String
        let authorID = currentPost["author_id"]! as! Int
        let subject = currentPost["subject"]! as! String
        let publishDateInSeconds = currentPost["dateline"]! as! Int
        let message = currentPost["message"]! as! String
        
        cell.setAdditionalInfo(pid, fid: fid, tid: tid)
        cell.setAuthor(authorName, authorID: authorID)
        cell.setSubjectAndMessage(subject, message: message, parser: bulletinBoardCodeParser)
        cell.setDateOfPublishing(publishDateInSeconds)
        
        if currentEntryIndex != 0 {
            cell.disableViewContentFromThisAuthorOnlyButton()
        }
        
        return cell
    }
    
    @IBAction func addToReadingListButtonPressed(sender: AnyObject) {
    }
}
