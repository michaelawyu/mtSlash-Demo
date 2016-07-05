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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionOfForumEntries = [firstSubforumEntry, secondSubforumEntry, thirdSubforumEntry, fourthSubforumEntry, fifthSubforumEntry, sixthSubforumEntry, seventhSubforumEntry, eighthSubforumEntry, mainForumEntry]
        
        collectionOfForumEntryTitles = ["SECRET GIFTS in Holiday Season", "HELP CENTER", "SONG", "DISCUSSION", "FANBOOK", "FANVID", "FANART", "TV FANFIC", "MOVIE FANFIC"]
        
        collectionOfForumDetails = [forumSubtitle, noOfPosts, noOfPostsTitle, noOfReplies, noOfRepliesTitle, noOfNewPostsToday, forumIntroduction, enterCurrentForum, enterSubsectionsTitle, firstSubsectionImage, enterFirstSubsection, secondSubsectionImage, enterSecondSubsection]

        
        // Update Number of Posts, Number of Replies and Number of Today's New Posts
        
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
}
