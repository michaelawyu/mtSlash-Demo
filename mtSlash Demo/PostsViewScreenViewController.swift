//
//  PostsViewScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/29/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class PostsViewScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var navigationItemOnCurrentPage: UINavigationItem!
    @IBOutlet weak var toolbarView: UIView!
    
    var currentNumberOfPages : Int = 1
    var selectedAuthorID : Int = -1
    var listOfPosts : [NSDictionary] = []
    
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
                self.listOfPosts = retrievedPosts["results"]! as! [NSDictionary]
                dispatch_async(dispatch_get_main_queue(), {
                    self.postsTableView.reloadData()
                })
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
            return cell
        }
        
         // If reaches the end of list of the threads, return a cell indicating the option to load more posts from server
        if currentEntryIndex == listOfPosts.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("loadMorePostsSignifierCell")!
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
        
            cell.setAdditionalInfo(pid, fid: fid, tid: tid)
            cell.setAuthor(authorName, authorID: authorID)
            cell.setSubjectAndMessage(subject, message: message, parser: bulletinBoardCodeParser)
            cell.setDateOfPublishing(publishDateInSeconds)
        
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("standardPostReplyContainerCell")! as! postReplyContainerCell
        
        cell.setAdditionalInfo(pid, fid: fid, tid: tid)
        cell.setAuthor(authorName, authorID: authorID)
        cell.setSubjectAndMessage(subject, message: message, parser: bulletinBoardCodeParser)
        cell.setDateOfPublishing(publishDateInSeconds)
        
        return cell
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
