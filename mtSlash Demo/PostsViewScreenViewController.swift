//
//  PostsViewScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/29/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit
import CoreData

class PostsViewScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var navigationItemOnCurrentPage: UINavigationItem!
    @IBOutlet weak var toolbarView: UIView!
    
    var currentNumberOfPages : Int = 1
    var selectedAuthorID : Int = -1
    var listOfPosts : [NSDictionary] = []
    
    var threadTitle : String = ""
    
    // Initiate a parser
    var bulletinBoardCodeParser = BulletinBoardCode2NSMutableAttributedStringParser()
    
    // Initiate gesture recongizers
    let panGestureRecognizerForAppearanceAndDisappearanceOfNavigationBar = UIPanGestureRecognizer()
    let pinchGestureRecognizerForDisablingFullScreenMode = UIPinchGestureRecognizer()
    
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
        
        // Configure gesture recognizers
        panGestureRecognizerForAppearanceAndDisappearanceOfNavigationBar.addTarget(self, action: #selector(self.pannedInPostsTableView(_:)))
        panGestureRecognizerForAppearanceAndDisappearanceOfNavigationBar.delegate = self
        
        pinchGestureRecognizerForDisablingFullScreenMode.addTarget(self, action: #selector(self.pinchedInPostsTableView(_:)))
        pinchGestureRecognizerForDisablingFullScreenMode.delegate = self
        pinchGestureRecognizerForDisablingFullScreenMode.enabled = false
        
        // Add gesture recognizers to the post table view
        postsTableView.addGestureRecognizer(panGestureRecognizerForAppearanceAndDisappearanceOfNavigationBar)
        postsTableView.addGestureRecognizer(pinchGestureRecognizerForDisablingFullScreenMode)
    }
    
    // Function for retrieving posts from the server
    func retrievePostsFromServer() {
        // Read the URL of backend server from WebLinks class
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
                let retrievedPostsAsArray = retrievedPosts["results"]! as! [NSDictionary]
                
                // Load the retrieved posts into memory and refresh the view
                if self.listOfPosts.count < retrievedPostsAsArray.count {
                    self.listOfPosts = retrievedPosts["results"]! as! [NSDictionary]
                    dispatch_async(dispatch_get_main_queue(), {
                        self.postsTableView.reloadData()
                    })
                } else {
                    // Reduce current number of pages
                    if self.currentNumberOfPages > 1 {
                        self.currentNumberOfPages = self.currentNumberOfPages - 1
                    }
                    
                    // Issue a notification suggesting all posts available from server has been loaded
                    dispatch_async(dispatch_get_main_queue(), {
                        let notificationForHavingLoadedAllPostsFromServer = UIAlertController(title: "没有更多可用回复", message: "在您选择的主题下，当前没有更多符合条件的回复可供读取。请稍后再试。", preferredStyle: UIAlertControllerStyle.Alert)
                        let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                            notificationForHavingLoadedAllPostsFromServer.dismissViewControllerAnimated(true, completion: nil)
                        })
                        notificationForHavingLoadedAllPostsFromServer.addAction(OKAction)
                        self.presentViewController(notificationForHavingLoadedAllPostsFromServer, animated: true, completion: nil)
                    })
                }
            } else {
                // Issue a warning if an error has occurred
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Add shadow to the toolbar
        let toolbarViewShadowPath = UIBezierPath(rect: toolbarView.bounds)
        toolbarView.layer.masksToBounds = false
        toolbarView.layer.shadowColor = UIColor.blackColor().CGColor
        toolbarView.layer.shadowOffset = CGSize(width: 0.0, height: -0.05)
        toolbarView.layer.shadowOpacity = 0.2
        toolbarView.layer.shadowPath = toolbarViewShadowPath.CGPath

    }
    
    // Method from UIGestureRecognizerDelegate
    // Allowing multiple gesture recognizers to work simultaneously
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
            cell.selectionStyle = .None
            return cell
        }
        
         // If reaches the end of list of the threads, return a cell indicating the option to load more posts from server
        if currentEntryIndex == listOfPosts.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("loadMorePostsSignifierCell")!
            cell.selectionStyle = .None
            return cell
        }
        let currentPost = listOfPosts[currentEntryIndex]
        
        let pid = currentPost["pid"]! as! Int
        let fid = currentPost["fid"]! as! Int
        let tid = currentPost["tid"]! as! Int
        let authorName = currentPost["author"]! as! String
        let authorID = currentPost["author_id"]! as! Int
        let subject = currentPost["subject"]! as! String
        let publishDateInSeconds = currentPost["dateline"]! as! Int
        let message = currentPost["message"]! as! String
        
        // Configure the cell containing the first post
        if currentEntryIndex == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("standardPostContainerCell")! as! postContainerCell
            cell.selectionStyle = .None
        
            cell.setAdditionalInfo(pid, fid: fid, tid: tid)
            cell.setAuthor(authorName, authorID: authorID)
            cell.setSubjectAndMessage(subject, message: message, parser: bulletinBoardCodeParser)
            cell.setDateOfPublishing(publishDateInSeconds)
            
            // Save the thread title in memory
            self.threadTitle = subject
        
            return cell
        }
        
        // Configure the cell containing other posts
        let cell = tableView.dequeueReusableCellWithIdentifier("standardPostReplyContainerCell")! as! postReplyContainerCell
        cell.selectionStyle = .None
        
        cell.setAdditionalInfo(pid, fid: fid, tid: tid)
        cell.setAuthor(authorName, authorID: authorID)
        cell.setSubjectAndMessage(subject, message: message, parser: bulletinBoardCodeParser)
        cell.setDateOfPublishing(publishDateInSeconds)
        
        return cell
    }
    
    // Function to call when a row of table is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Load more threads from server if More button is pressed
        if indexPath.indexAtPosition(1) == listOfPosts.count {
            currentNumberOfPages = currentNumberOfPages + 1
            retrievePostsFromServer()
            return
        }
    }
    
    // Function to call when the pan gesture recognizer is activated
    func pannedInPostsTableView(sender: UIPanGestureRecognizer) {
        let distanceMovedVertically = sender.translationInView(self.view).y
        
        // Hide the navigation bar when panned down long enough in the view
        if distanceMovedVertically <= -20 {
            navigationControllerInTopicsAndPostsViewScreens?.setNavigationBarHidden(true, animated: true)
        }
        
        // Show the navigation bar when panned up long enough in the view
        if distanceMovedVertically >= 20 {
            navigationControllerInTopicsAndPostsViewScreens?.setNavigationBarHidden(false, animated: true)
        }
        
    }
    
    // Function to call when the pinch gesture recognizer is activated
    func pinchedInPostsTableView(sender: UIPinchGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            // Issue a notification for leaving full screen mode
            let switchOffFullScreenModeNotification = UIAlertController(title: "离开全屏模式", message: "即将离开全屏模式。离开全屏模式后，标题栏及工具栏将重新显示。您可以随时使用工具栏上的快捷方式重新启用全屏模式。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) in
                switchOffFullScreenModeNotification.dismissViewControllerAnimated(true, completion: nil)
            
                // Enable panGestureRecognizerForAppearanceAndDisappearanceOfNavigationBar
                self.panGestureRecognizerForAppearanceAndDisappearanceOfNavigationBar.enabled = true
            
                // Disable pinchGestureRecognizerForDisablingFullScreenMode
                self.pinchGestureRecognizerForDisablingFullScreenMode.enabled = false
            
                navigationControllerInTopicsAndPostsViewScreens?.setNavigationBarHidden(false, animated: true)
                self.toolbarView.hidden = false
            }
            let CancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (action) in
                switchOffFullScreenModeNotification.dismissViewControllerAnimated(true, completion: nil)
            }
            switchOffFullScreenModeNotification.addAction(OKAction)
            switchOffFullScreenModeNotification.addAction(CancelAction)
            self.presentViewController(switchOffFullScreenModeNotification, animated: true, completion: nil)
        }
    }
    
    // Function to call when view content from this author only button is pressed
    @IBAction func viewPostsFromThisAuthorOnlyButtonPressed(sender: UIButtonWithLink) {
        self.listOfPosts = []
        
        if selectedAuthorID == -1 {
            // Load selectedAuthorID, retrieve posts from the server and refresh the table
            selectedAuthorID = sender.link!
            retrievePostsFromServer()
            postsTableView.reloadData()
            
            // Update the text on the button
            sender.setTitle("显示所有帖子", forState: UIControlState.Normal)
        } else {
            // Reset selectedAuthorID, retrieve posts from the server and refresh the table
            selectedAuthorID = -1
            retrievePostsFromServer()
            postsTableView.reloadData()
            
            // Update the text on the button
            sender.setTitle("仅浏览由此作者发布的帖子", forState: UIControlState.Normal)
        }
    }
    
    // Function to call when add this thread to reading list button is pressed
    @IBAction func addToReadingListButtonPressed(sender: AnyObject) {
        // Check if the thread has been loaded
        if listOfPosts.count == 0 {
            let threadNotAvailableYet = UIAlertController(title: "仍在加载帖子内容", message: "当前仍然没有得到从服务器返回的帖子信息，因此无法将此主题加入阅读列表。请稍后重试。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                threadNotAvailableYet.dismissViewControllerAnimated(true, completion: nil)
            })
            threadNotAvailableYet.addAction(OKAction)
            self.presentViewController(threadNotAvailableYet, animated: true, completion: nil)
        }
        
        // Check if the entry has been added to reading list
        // Wait until the framework is ready
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController : DefaultDataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Set up fetch request
        let readingListItemsFetchRequest = NSFetchRequest(entityName: "MTReadingList")
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        let predicateForFetchingReadingListEntryWithSpecificID = NSPredicate(format: "(belongTo == %@) AND (link == %@)", argumentArray: [currentUser, String(threadID!)])
        readingListItemsFetchRequest.predicate = predicateForFetchingReadingListEntryWithSpecificID
        var readingListItems : [MTReadingList] = []
        var readingListItem : MTReadingList? = nil
        
        // Fetch reading list entry with specific thread ID from data framework
        do {
            readingListItems = try managedObjectContextInUse.executeFetchRequest(readingListItemsFetchRequest) as! [MTReadingList]
        } catch {
            fatalError("An error has occurred: Failed to fetch reading list items from the database.")
        }
        
        // Add the new entry to the reading list if it has not been saved before
        if readingListItems.count == 0 {
            // Initialize a new reading list item based on current data model
            let newReadingListItem = NSEntityDescription.insertNewObjectForEntityForName("MTReadingList", inManagedObjectContext: managedObjectContextInUse) as! MTReadingList
            
            // Get current user
            let currentUser = ConvenientMethods.getCurrentUser(uid)
            
            // Set values of the item
            newReadingListItem.setValuesOfReadingListItem(threadTitle, timeAdded: NSDate(), link: String(threadID!), ifVisible: true, category: forumSectionIdentificationNumber!.rawValue, abstract: "", belongTo: currentUser)
            
            // Save the changes
            do {
                try managedObjectContextInUse.save()
            } catch {
                print(error)
                fatalError("An error has occurred: Failed to save the changes to the database.")
            }
            
            // Issue a confirmation of completion of action
            let newReadingListItemAdded = UIAlertController(title: "已加入阅读列表", message: "当前主题已被记录在阅读列表中。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                newReadingListItemAdded.dismissViewControllerAnimated(true, completion: nil)
            })
            newReadingListItemAdded.addAction(OKAction)
            self.presentViewController(newReadingListItemAdded, animated: true, completion: nil)
        }
        
        // Issue a warning if the entry has been added to the reading list
        if readingListItems.count > 0 {
            readingListItem = readingListItems.last!
            
            // Invisible reading list items cannot be removed
            if readingListItem!.ifVisible!.boolValue == false {
                let removalOfInvisibleItemsIsForbidden = UIAlertController(title: "无法修改当前项目", message: "当前主题是随程序一同安装的帮助文档，暂时无法从程序中移除。", preferredStyle: UIAlertControllerStyle.Alert)
                let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                    removalOfInvisibleItemsIsForbidden.dismissViewControllerAnimated(true, completion: nil)
                })
                removalOfInvisibleItemsIsForbidden.addAction(OKAction)
                self.presentViewController(removalOfInvisibleItemsIsForbidden, animated: true, completion: nil)
                return
            }
            
            let confirmationOfRemovalOfReadingListItemRequired = UIAlertController(title: "当前主题已在阅读列表中", message: "您确认要从阅读列表中移除此主题吗？", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                // Remove the entry
                managedObjectContextInUse.deleteObject(readingListItem!)
                
                // Save the changes
                do {
                    try managedObjectContextInUse.save()
                } catch {
                    fatalError("An error has occurred: System cannot incorporate the default reading list.")
                }
                
                // Dismiss the alert view controller
                confirmationOfRemovalOfReadingListItemRequired.dismissViewControllerAnimated(true, completion: nil)
            })
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: { (action) in
                confirmationOfRemovalOfReadingListItemRequired.dismissViewControllerAnimated(true, completion: nil)
            })
            
            confirmationOfRemovalOfReadingListItemRequired.addAction(OKAction)
            confirmationOfRemovalOfReadingListItemRequired.addAction(cancelAction)
            self.presentViewController(confirmationOfRemovalOfReadingListItemRequired, animated: true, completion: nil)
        }
    }
    
    // Function to call when like button is pressed
    @IBAction func likeButtonPressed(sender: AnyObject) {
        // Not implemented for current testing builds
        let likeActionFailed = UIAlertController(title: "在测试版本中无法执行此操作", message: "当前连接的服务器（随缘居移动应用程序测试站点）并未提供对当前的操作的支持。请在正式版本中再试。", preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) in
            likeActionFailed.dismissViewControllerAnimated(true, completion: nil)
        }
        likeActionFailed.addAction(OKAction)
        self.presentViewController(likeActionFailed, animated: true, completion: nil)
    }
    
    // Function to cell when switch to full screen mode button is pressed
    @IBAction func fullScreenButtonPressed(sender: AnyObject) {
        // Issue a notification for switching to full screen mode
        let switchToFullScreenModeNotification = UIAlertController(title: "切换至全屏模式", message: "即将切换到全屏模式。在此模式下，标题栏及工具栏将被隐藏。您可以随时使用双指缩放屏幕回复。", preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) in
            switchToFullScreenModeNotification.dismissViewControllerAnimated(true, completion: nil)
            
            // Disable panGestureRecognizerForAppearanceAndDisappearanceOfNavigationBar, as in this mode navigation bar remains hidden
            self.panGestureRecognizerForAppearanceAndDisappearanceOfNavigationBar.enabled = false
            
            // Enable pinchGestureRecognizerForDisablingFullScreenMode, for switching off full screen mode
            self.pinchGestureRecognizerForDisablingFullScreenMode.enabled = true
            
            navigationControllerInTopicsAndPostsViewScreens?.setNavigationBarHidden(true, animated: true)
            self.toolbarView.hidden = true
        }
        let CancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (action) in
            switchToFullScreenModeNotification.dismissViewControllerAnimated(true, completion: nil)
        }
        switchToFullScreenModeNotification.addAction(OKAction)
        switchToFullScreenModeNotification.addAction(CancelAction)
        self.presentViewController(switchToFullScreenModeNotification, animated: true, completion: nil)
    }
    
    // Function to call when share button is pressed
    @IBAction func shareButtonPressed(sender: AnyObject) {
        let sharedText = "@\(username)向您分享了一篇来自随缘居的文章。"
            
        let sharedURL = WebLinks.getAddressOfWebLink(WebLinks.ShareThreads)
        print(sharedURL)
        
        let objectsToShare = [sharedText, sharedURL]
        let activityViewControllerForSharing = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
        activityViewControllerForSharing.popoverPresentationController?.sourceView = self.view
        self.presentViewController(activityViewControllerForSharing, animated: true, completion: nil)
    }
   
    // Function to call when reply button is pressed
    @IBAction func replyButtonPressed(sender: AnyObject) {
        // Not implemented for current testing buildings
        let replyActionFailed = UIAlertController(title: "在测试版本中无法执行此操作", message: "此功能在测试版本中不可用。请在正式版本中再试。", preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) in
            replyActionFailed.dismissViewControllerAnimated(true, completion: nil)
        }
        replyActionFailed.addAction(OKAction)
        self.presentViewController(replyActionFailed, animated: true, completion: nil)
    }
    
    
    
}
