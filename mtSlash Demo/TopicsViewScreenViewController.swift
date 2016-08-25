//
//  TopicsViewScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/12/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class TopicsViewScreenViewController: UIViewController, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var topicsTableView: UITableView!
    @IBOutlet weak var subSectionsCollectionView: UICollectionView!
    @IBOutlet weak var upperRegionForPanGestureRecognizer: UIView!
    @IBOutlet weak var backgroundPanelInUpperRegion: UIImageView!
    @IBOutlet weak var leftPlaceholderView: UIView!
    @IBOutlet weak var rightPlaceholderView: UIView!
    @IBOutlet weak var navigationItemOnCurrentPage: UINavigationItem!
    @IBOutlet weak var mainTitleInUpperRegion: UILabel!
    @IBOutlet weak var subTitleInUpperRegion: UILabel!
    @IBOutlet weak var noteInUpperRegion: UILabel!
    
    
    var listOfAvailableSubSectionsAndItsRefs : [(String, Int)] = []
    var listOfThreads : [NSDictionary] = []
    
    // Convert InAppSectionDef (sectionLink) to web end reference number
    let currentForumID_Raw : Int = ForumSections.convertInAppSectionDef2WebEndSectionNumber(ForumSections.Sections(rawValue: sectionLink!)!).0
    var currentSort_ID_Raw : Int = ForumSections.convertInAppSectionDef2WebEndSectionNumber(ForumSections.Sections(rawValue: sectionLink!)!).1
    var currentNumberOfPages : Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarInTopicsAndPostsViewScreens!.setBackgroundImage(UIImage.fromColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)), forBarMetrics: UIBarMetrics.Default)
        (subSectionsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 100, height: 50.5)
        
        // Load current section
        let currentSection = ForumSections.Sections(rawValue: sectionLink!)!
        
        // Initialize list of available sections
        listOfAvailableSubSectionsAndItsRefs = ForumSections.getListOfAvailableCategories(currentSection)

        // Initalize background image panel in the upper region
        backgroundPanelInUpperRegion.image = ForumSections.getPanelBackgroundInUpperRegionOfTopicsViewScreen()
        
        // Initalized texts in the upper region
        let listOfTitlesAndNotesOfCurrentSection = ForumSections.getTitlesAndNotesOfCurrentSubSection(currentSection)
        mainTitleInUpperRegion.text = listOfTitlesAndNotesOfCurrentSection[0]
        subTitleInUpperRegion.text = listOfTitlesAndNotesOfCurrentSection[1]
        noteInUpperRegion.text = listOfTitlesAndNotesOfCurrentSection[2]
        
        // Initialize gesture recognizers
        let panGestureRecognizerForUpperRegion = UIPanGestureRecognizer(target: self, action: #selector(self.pannedInUpperRegion(_:)))
        upperRegionForPanGestureRecognizer.addGestureRecognizer(panGestureRecognizerForUpperRegion)
        
        let panGestureRecognizerForLowerRegion = UIPanGestureRecognizer(target: self, action: #selector(self.pannedInLowerRegion(_:)))
        panGestureRecognizerForLowerRegion.delegate = self
        topicsTableView.addGestureRecognizer(panGestureRecognizerForLowerRegion)
        
        // Retrieve threads from the server
        retrieveThreadsFromServer()
    }
    
    func retrieveThreadsFromServer() {
        // Fetch the URL of backend Server from WebLinks class
        let serverEndURLForRetrievingThreads = WebLinks.getAddressOfWebLink(WebLinks.RetrieveThreads)
        
        // Download the list of threads from the server and read them into listOfThreads variable
        let sessionForRetrievingThreads = NSURLSession.sharedSession()
        let requestForRetrievingThreads = NSMutableURLRequest(URL: serverEndURLForRetrievingThreads)
        requestForRetrievingThreads.HTTPMethod = "POST"
        requestForRetrievingThreads.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let HTTPBodyContentForRequest = "fid=\(currentForumID_Raw)&sort_id=\(currentSort_ID_Raw)&limit_multiplier=\(currentNumberOfPages)"
        requestForRetrievingThreads.HTTPBody = HTTPBodyContentForRequest.dataUsingEncoding(NSUTF8StringEncoding)
        let taskForRetrievingThreads = sessionForRetrievingThreads.dataTaskWithRequest(requestForRetrievingThreads) { (data, response, error) in
            if error == nil && data != nil {
                let retrievedThreads = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                self.listOfThreads = retrievedThreads["results"]! as! [NSDictionary]
                dispatch_async(dispatch_get_main_queue(), {
                    self.topicsTableView.reloadData()
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let retrievalOfThreadsFailed = UIAlertController(title: "无法获取主题列表", message: "似乎发生了一个网络错误。您的数据链接可能已经中断，或服务器暂时无法为您提供服务。请稍后再试。", preferredStyle: UIAlertControllerStyle.Alert)
                    let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                        retrievalOfThreadsFailed.dismissViewControllerAnimated(true, completion: nil)
                    })
                    retrievalOfThreadsFailed.addAction(OKAction)
                    self.presentViewController(retrievalOfThreadsFailed, animated: true, completion: nil)
                })
            }
        }
        taskForRetrievingThreads.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // Return to the previous screen
    @IBAction func leftBackButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfAvailableSubSectionsAndItsRefs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = (subSectionsCollectionView.dequeueReusableCellWithReuseIdentifier("subSectionNameContainerCell", forIndexPath: indexPath) as! subSectionNameContainerCell)
        let titleOfSubSection = listOfAvailableSubSectionsAndItsRefs[indexPath.indexAtPosition(1)].0
        let linkOfSubSection = listOfAvailableSubSectionsAndItsRefs[indexPath.indexAtPosition(1)].1
        cell.setTitleOfButton(titleOfSubSection)
        cell.setEmbeddedSectionLinkOfButton(linkOfSubSection)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfThreads.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentEntryIndex = indexPath.indexAtPosition(1)
        
        // If list of threads is not available yet, return a cell indicating that the list of threads is still being retrieved
        if listOfThreads.count == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("noContentSignifierCell")!
            return cell
        }
        
        // If reaches the end of list of the threads, return a cell indicating the option to load more threads from server
        if currentEntryIndex == listOfThreads.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("noContentSignifierCell")!
            return cell
        }
        
        // Configure the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("standardTopicContainerCell")! as! topicTitleContainerCell
        
        let currentThread = listOfThreads[currentEntryIndex]
        
        let authorName = currentThread["author"] as! String
        let authorID = currentThread["authorid"] as! Int
        let publishDateInSections = currentThread["dateline"] as! Int
        let fid = currentThread["fid"] as! Int
        let lastPosterName = currentThread["lastposter"] as! String
        let numberOfReplies = currentThread["replies"] as! Int
        let categoryID = currentThread["sort_id"] as! Int
        let postTitle = currentThread["subject"] as! String
        let tid = currentThread["tid"] as! Int
        let typeID = currentThread["type_id"] as! Int
        let numberOfViews = currentThread["views"] as! Int
        
        
        cell.setTitle(postTitle)
        cell.setAuthor(authorName, authorID: authorID)
        cell.setDateOfPublishing(publishDateInSections)
        cell.setNoOfRepliesViewsAndLastReplyFromInfo(numberOfReplies, numberOfViews: numberOfViews, lastPosterName: lastPosterName)
        cell.setAdditonalInfo(fid, tid: tid, categoryID: categoryID, typeID: typeID)
        
        return cell
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        if upperRegionForPanGestureRecognizer.transform.ty >= 0 && (gestureRecognizer as! UIPanGestureRecognizer).translationInView(self.view).y > 0 {
            return true
        }
        
        if upperRegionForPanGestureRecognizer.transform.ty <= -258 {
            return true
        }

        return false
    }
    
    var lastDistanceMovedVertically : CGFloat = 0.0
    
    func pannedInUpperRegion(sender : UIPanGestureRecognizer) {
        let distanceMovedVertically = sender.translationInView(self.view).y
        
        if sender.state == UIGestureRecognizerState.Began {
            lastDistanceMovedVertically = 0.0
        }
        
        if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled) && self.upperRegionForPanGestureRecognizer.transform.ty >= 0 {
            UIView.animateWithDuration(0.1, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: -1.0, options: [], animations: {
                for subview in self.view.subviews {
                    subview.transform.ty = 0
                }
                }, completion: nil)
        }
        
        var deltaDistanceMovedVertically = distanceMovedVertically - lastDistanceMovedVertically
        
        if self.upperRegionForPanGestureRecognizer.transform.ty >= 0 && deltaDistanceMovedVertically > 0 {
            deltaDistanceMovedVertically = 0
        }
        
        for subview in self.view.subviews {
            subview.transform = CGAffineTransformConcat(subview.transform, CGAffineTransformMakeTranslation(0.0, deltaDistanceMovedVertically))
        }
        
        if self.upperRegionForPanGestureRecognizer.transform.ty <= -220 && deltaDistanceMovedVertically < 0 {
            for subview in self.view.subviews {
                    subview.transform.ty = -258
            }
            subSectionsCollectionView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            navigationBarInTopicsAndPostsViewScreens?.setBackgroundImage(UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)), forBarMetrics: UIBarMetrics.Default)
            leftPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            rightPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            
            // Filled With Sample Data: Update When Code is Ready
            navigationItemOnCurrentPage.title = "MOVIE FANFIC"

            deltaDistanceMovedVertically = 0
        }
        
        lastDistanceMovedVertically = distanceMovedVertically
        
        if self.upperRegionForPanGestureRecognizer.transform.ty > -258 && navigationItemOnCurrentPage.title != "" {
            navigationItemOnCurrentPage.title = ""
            subSectionsCollectionView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            navigationBarInTopicsAndPostsViewScreens?.setBackgroundImage(UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)), forBarMetrics: UIBarMetrics.Default)
            leftPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            rightPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }
    
    var lastDistanceMovedVerticallyInLowerRegion : CGFloat = 0.0
    
    func pannedInLowerRegion(sender : UIPanGestureRecognizer) {
        
        let distanceMovedVertically = sender.translationInView(self.view).y
        
        if sender.state == UIGestureRecognizerState.Began {
            lastDistanceMovedVerticallyInLowerRegion = 0.0
        }
        
        if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled) && self.upperRegionForPanGestureRecognizer.transform.ty >= 0 {
            UIView.animateWithDuration(0.1, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: -1.0, options: [], animations: {
                for subview in self.view.subviews {
                    subview.transform.ty = 0
                }
                }, completion: nil)
        }
        
        var deltaDistanceMovedVertically = distanceMovedVertically - lastDistanceMovedVerticallyInLowerRegion
        
        if self.upperRegionForPanGestureRecognizer.transform.ty >= 0 && distanceMovedVertically > 0 {
            deltaDistanceMovedVertically = 0.0
        }
        
        if self.upperRegionForPanGestureRecognizer.transform.ty <= -258 && self.topicsTableView.contentOffset.y >= 0.0 {
            deltaDistanceMovedVertically = 0.0
        }
        
        for subview in self.view.subviews {
            subview.transform = CGAffineTransformConcat(subview.transform, CGAffineTransformMakeTranslation(0.0, deltaDistanceMovedVertically))
        }
        
        if self.upperRegionForPanGestureRecognizer.transform.ty <= -220 && deltaDistanceMovedVertically < 0 {
            for subview in self.view.subviews {
                subview.transform.ty = -258
            }
            subSectionsCollectionView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            navigationBarInTopicsAndPostsViewScreens?.setBackgroundImage(UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)), forBarMetrics: UIBarMetrics.Default)
            leftPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            rightPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            
            // Filled With Sample Data: Update When Code is Ready
            navigationItemOnCurrentPage.title = "MOVIE FANFIC"
            
            deltaDistanceMovedVertically = 0
        }
        
        lastDistanceMovedVerticallyInLowerRegion = distanceMovedVertically
        
        if self.upperRegionForPanGestureRecognizer.transform.ty > -258 && navigationItemOnCurrentPage.title != "" {
            navigationItemOnCurrentPage.title = ""
            subSectionsCollectionView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            navigationBarInTopicsAndPostsViewScreens?.setBackgroundImage(UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)), forBarMetrics: UIBarMetrics.Default)
            leftPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            rightPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
        
    }
}
