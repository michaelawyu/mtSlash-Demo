//
//  DiscoverScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/20/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class DiscoverScreenViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backgroundMask: UIImageView!
    @IBOutlet weak var firstSubforumEntry: UIButton!
    @IBOutlet weak var secondSubforumEntry: UIButton!
    @IBOutlet weak var thirdSubforumEntry: UIButton!
    @IBOutlet weak var fourthSubforumEntry: UIButton!
    @IBOutlet weak var fifthSubforumEntry: UIButton!
    @IBOutlet weak var sixthSubforumEntry: UIButton!
    @IBOutlet weak var seventhSubforumEntry: UIButton!
    @IBOutlet weak var eighthSubforumEntry: UIButton!
    @IBOutlet weak var mainForumEntry: UIButton!
    @IBOutlet weak var forumSubtitle: UILabel!
    @IBOutlet weak var noOfPosts: UILabel!
    @IBOutlet weak var noOfPostsTitle: UILabel!
    @IBOutlet weak var noOfReplies: UILabel!
    @IBOutlet weak var noOfRepliesTitle: UILabel!
    @IBOutlet weak var noOfNewPostsToday: UILabel!
    @IBOutlet weak var forumIntroduction: UILabel!
    @IBOutlet weak var enterCurrentForum: UIButton!
    @IBOutlet weak var enterSubsectionsTitle: UILabel!
    @IBOutlet weak var firstSubsectionImage: UIImageView!
    @IBOutlet weak var enterFirstSubsection: UIButton!
    @IBOutlet weak var secondSubsectionImage: UIImageView!
    @IBOutlet weak var enterSecondSubsection: UIButton!
    
    var collectionOfForumEntries : [UIButton]? = nil
    var collectionOfForumDetails : [UIView]? = nil
    var collectionOfForumEntryTitles : [String]? = nil
    var collectionOfForumEntryNumbers : [Int]? = nil
    
    var numberOfCurrentForumEntry : Int? = nil
    var numberOfFirstSubSection : Int? = nil
    var numberOfSecondSubSection : Int? = nil
    
    var numberOfThreadsInSectionsDict = NSDictionary()
    var numberOfPostsInSectionsDict = NSDictionary()
    var numberOfPostsTodayInSectionsDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionOfForumEntries = [firstSubforumEntry, secondSubforumEntry, thirdSubforumEntry, fourthSubforumEntry, fifthSubforumEntry, sixthSubforumEntry, seventhSubforumEntry, eighthSubforumEntry, mainForumEntry]
        
        collectionOfForumEntryTitles = ["SECRET GIFTS in Holiday Season", "HELP CENTER", "SONG", "DISCUSSION", "FANBOOK", "FANVID", "FANART", "TV FANFIC", "MOVIE FANFIC"]
        
        collectionOfForumEntryNumbers = [74, 72, 71, 70, 68, 64, 63, 34, 2]
        
        collectionOfForumDetails = [forumSubtitle, noOfPosts, noOfPostsTitle, noOfReplies, noOfRepliesTitle, noOfNewPostsToday, forumIntroduction, enterCurrentForum, enterSubsectionsTitle, firstSubsectionImage, enterFirstSubsection, secondSubsectionImage, enterSecondSubsection]
        
        // Update Number of Posts, Number of Replies and Number of Today's New Posts
        retrieveMiscellaneousInfoOfSections()
        setUpElementsForFirstAppearance()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        firstAppearance()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func retrieveMiscellaneousInfoOfSections() {
        // Fetch the URL of backend Server from WebLinks class
        let serverEndURLForSectionInfo = WebLinks.getAddressOfWebLink(WebLinks.SectionInfo)
        
        // Download the settings from the server and read them into serverEndSettings variable
        let sessionForFetchingSectionInfo = NSURLSession.sharedSession()
        let taskForFetchingSectionInfo = sessionForFetchingSectionInfo.dataTaskWithURL(serverEndURLForSectionInfo) { (data, response, error) in
            if error == nil && data != nil {
                let sectionInfo = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                self.numberOfPostsInSectionsDict = sectionInfo["posts"] as! NSDictionary
                self.numberOfThreadsInSectionsDict = sectionInfo["threads"] as! NSDictionary
                self.numberOfPostsTodayInSectionsDict = sectionInfo["todayposts"] as! NSDictionary
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    let failedToFetchSectionInfoWindow = UIAlertController(title: "无法取得板块基本信息", message: "似乎发生了一个网络错误。您的数据链接可能已经中断，或服务器暂时无法为您提供服务。请稍后再试。", preferredStyle: UIAlertControllerStyle.Alert)
                    let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                        failedToFetchSectionInfoWindow.dismissViewControllerAnimated(true, completion: nil)
                    })
                    failedToFetchSectionInfoWindow.addAction(OKAction)
                    self.presentViewController(failedToFetchSectionInfoWindow, animated: true, completion: nil)
                })
            }
        }
        taskForFetchingSectionInfo.resume()
    }
    
    func setUpElementsForFirstAppearance() {
        backgroundImage.alpha = 0.0
        // Set Up Background Image
        
        for entry in collectionOfForumEntries! {
            entry.transform = CGAffineTransformMakeTranslation(0.0, -80.0)
            entry.alpha = 0.0
        }
        
        mainForumEntry!.transform = CGAffineTransformMakeTranslation(0.0, -90.0)
        
        for entry in collectionOfForumDetails! {
            entry.alpha = 0.0
        }
        
        initForumDetails(ForumSections.Sections.MovieFanfic_General)
    }
    
    func firstAppearance() {
        firstSubforumEntry?.addTarget(self, action: #selector(self.firstButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        secondSubforumEntry?.addTarget(self, action: #selector(self.secondButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        thirdSubforumEntry?.addTarget(self, action: #selector(self.thirdButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        fourthSubforumEntry?.addTarget(self, action: #selector(self.fourthButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        fifthSubforumEntry?.addTarget(self, action: #selector(self.fifthButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        sixthSubforumEntry?.addTarget(self, action: #selector(self.sixthButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        seventhSubforumEntry?.addTarget(self, action: #selector(self.seventhButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        eighthSubforumEntry?.addTarget(self, action: #selector(self.eighthButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        
        UIView.animateWithDuration(1.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            
            self.backgroundImage.alpha = 1.0
            
            for entry in self.collectionOfForumEntries! {
                entry.transform = CGAffineTransformIdentity
                entry.alpha = 0.25
            }
            
            self.mainForumEntry!.alpha = 1.0
            
            }, completion: nil)
        
        UIView.animateWithDuration(1.2, delay: 0.3, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            
            for item in self.collectionOfForumDetails! {
                item.alpha = 1.0
                if item == self.enterSubsectionsTitle {
                    item.alpha = 0.5
                }
            }
            
            }, completion: nil)
        
    }
    
    func initForumDetails(forumSection: ForumSections.Sections) {
        let forumID = ForumSections.convertInAppSectionDef2WebEndSectionNumber(forumSection).0
        
        var numberOfThreads: Int = 0
        var numberOfThreadsAbridgedInString : String = "数据不可用"
        var numberOfPosts : Int = 0
        var numberOfPostsAbridgedInString : String = "数据不可用"
        var numberOfPostsToday : Int = 0
        var numberOfPostsTodayAbridgedInString : String = "今日新增数据不可用"
        
        if numberOfThreadsInSectionsDict[forumID.description] != nil {
            numberOfThreads = numberOfThreadsInSectionsDict[forumID.description] as! Int
            numberOfThreadsAbridgedInString = self.numberAbridger(numberOfThreads)
        }
        
        if numberOfPostsInSectionsDict[forumID.description] != nil {
            numberOfPosts = numberOfPostsInSectionsDict[forumID.description] as! Int
            numberOfPostsAbridgedInString = self.numberAbridger(numberOfPosts)
        }
        
        if numberOfPostsTodayInSectionsDict[forumID.description] != nil {
            numberOfPostsToday = numberOfPostsTodayInSectionsDict[forumID.description] as! Int
            numberOfPostsTodayAbridgedInString = "今日新增\(self.numberAbridger(numberOfPostsToday))"
        }
        
        noOfPosts.text = numberOfThreadsAbridgedInString
        noOfReplies.text = numberOfPostsAbridgedInString
        noOfNewPostsToday.text = numberOfPostsTodayAbridgedInString
        
        let availabilityOfSubSections = ForumSections.getAvailabilityOfSubSections(forumSection)
        
        numberOfCurrentForumEntry = collectionOfForumEntryNumbers!.last
        
        let ifFirstSubSectionAvailable = availabilityOfSubSections.2
        let ifSecondSubSectionAvailable = availabilityOfSubSections.6
        
        self.forumSubtitle.text = availabilityOfSubSections.0
        self.forumIntroduction.text = availabilityOfSubSections.1
        
        if ifFirstSubSectionAvailable == true {
            enterSubsectionsTitle.hidden = false
            firstSubsectionImage.hidden = false
            enterFirstSubsection.hidden = false
            
            enterFirstSubsection.setTitle(availabilityOfSubSections.3!, forState: UIControlState.Normal)
            numberOfFirstSubSection = availabilityOfSubSections.4!
            firstSubsectionImage.image = availabilityOfSubSections.5!
        } else {
            firstSubsectionImage.hidden = true
            enterFirstSubsection.hidden = true
        }
        
        if ifSecondSubSectionAvailable == true {
            secondSubsectionImage.hidden = false
            enterSecondSubsection.hidden = false
            
            enterSecondSubsection.setTitle(availabilityOfSubSections.7!, forState: UIControlState.Normal)
            numberOfSecondSubSection = availabilityOfSubSections.8!
            secondSubsectionImage.image = availabilityOfSubSections.9!
        } else {
            secondSubsectionImage.hidden = true
            enterSecondSubsection.hidden = true
        }
        
        if ifFirstSubSectionAvailable == false && ifSecondSubSectionAvailable == false {
            enterSubsectionsTitle.hidden = true
        }
        
        self.view.layoutIfNeeded()
        
    }
    
    func numberAbridger(number : Int) -> String {
        if number >= 10000 {
            let numberAbridged = number / 10000
            return "\(numberAbridged)万+"
        }
        
        if number >= 1000 && number < 10000 {
            let numberAbridged = number / 1000
            return "\(numberAbridged)千+"
        }
        
        if number >= 100 && number < 1000 {
            let numberAbridged = number / 100
            return "\(numberAbridged)百+"
        }
        
        return number.description
    }
}
