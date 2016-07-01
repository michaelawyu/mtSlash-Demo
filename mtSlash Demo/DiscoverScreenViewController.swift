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
    @IBOutlet weak var secretGiftSubforumButton: UIButton!
    @IBOutlet weak var helpCenterSubforumButton: UIButton!
    @IBOutlet weak var songSubforumButton: UIButton!
    @IBOutlet weak var discussionSubformButton: UIButton!
    @IBOutlet weak var fanbookSubformButton: UIButton!
    @IBOutlet weak var fanvidSubforumButton: UIButton!
    @IBOutlet weak var fanartSubforumButton: UIButton!
    @IBOutlet weak var tvFanficSubforumButton: UIButton!
    @IBOutlet weak var movieFanficSubforumButton: UIButton!
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
    
    var firstEntry : UIButton? = nil
    var secondEntry : UIButton? = nil
    var thirdEntry : UIButton? = nil
    var fourthEntry : UIButton? = nil
    var fifthEntry : UIButton? = nil
    var sixthEntry : UIButton? = nil
    var seventhEntry : UIButton? = nil
    var eighthEntry : UIButton? = nil
    var mainEntry : UIButton? = nil
    
    var collectionOfForumEntriesInName : [UIButton]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionOfForumEntriesInName = [secretGiftSubforumButton, helpCenterSubforumButton, songSubforumButton, discussionSubformButton, fanbookSubformButton, fanvidSubforumButton, fanartSubforumButton, tvFanficSubforumButton]
        
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
        
        let collectionOfForumEntries = [firstEntry, secondEntry, thirdEntry, fourthEntry, fifthEntry, sixthEntry, seventhEntry, eighthEntry]
        
        for entry in collectionOfForumEntries {
            entry!.transform = CGAffineTransformMakeTranslation(0.0, -80.0)
            entry!.alpha = 0.0
        }
        
        mainEntry!.transform = CGAffineTransformMakeTranslation(0.0, -90.0)
        mainEntry!.alpha = 0.0
        
        let collectionOfForumDetails = [forumSubtitle, noOfPosts, noOfPostsTitle, noOfReplies, noOfRepliesTitle, noOfNewPostsToday, forumIntroduction, enterCurrentForum, enterSubsectionsTitle, firstSubsectionImage, enterFirstSubsection, secondSubsectionImage, enterSecondSubsection]
        
        for entry in collectionOfForumDetails {
            entry.alpha = 0.0
        }

    }
    
    func firstAppearance() {
        firstEntry = secretGiftSubforumButton
        firstEntry?.addTarget(self, action: #selector(self.firstButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        secondEntry = helpCenterSubforumButton
        thirdEntry = songSubforumButton
        fourthEntry = discussionSubformButton
        fifthEntry = fanbookSubformButton
        sixthEntry = fanvidSubforumButton
        seventhEntry = fanartSubforumButton
        eighthEntry = tvFanficSubforumButton
        mainEntry = movieFanficSubforumButton
        
        let collectionOfForumEntries = [firstEntry, secondEntry, thirdEntry, fourthEntry, fifthEntry, sixthEntry, seventhEntry, eighthEntry]
        
        let collectionOfForumDetails = [forumSubtitle, noOfPosts, noOfPostsTitle, noOfReplies, noOfRepliesTitle, noOfNewPostsToday, forumIntroduction, enterCurrentForum, enterSubsectionsTitle, firstSubsectionImage, enterFirstSubsection, secondSubsectionImage, enterSecondSubsection]
        
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            
            self.backgroundImage.alpha = 1.0
            
            for entry in collectionOfForumEntries {
                entry!.transform = CGAffineTransformIdentity
                entry!.alpha = 0.25
            }
            
            self.mainEntry!.transform = CGAffineTransformIdentity
            self.mainEntry!.alpha = 1.0
            
            for entry in collectionOfForumDetails {
                entry.alpha = 1.0
            }
            
            }, completion: nil)
    }
}
