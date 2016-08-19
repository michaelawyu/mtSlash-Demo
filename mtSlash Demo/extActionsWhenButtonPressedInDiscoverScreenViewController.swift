//
//  extActionsWhenButtonPressedInDiscoverScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/2/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit

extension DiscoverScreenViewController {
    //Constant: Total Number of Available Forums : 8
    
    func firstButtonPressed() {
        newSubformSelected(0)
    }
    
    func secondButtonPressed() {
        newSubformSelected(1)
    }
    
    func thirdButtonPressed() {
        newSubformSelected(2)
    }
    
    func fourthButtonPressed() {
        newSubformSelected(3)
    }
    
    func fifthButtonPressed() {
        newSubformSelected(4)
    }
    
    func sixthButtonPressed() {
        newSubformSelected(5)
    }
    
    func seventhButtonPressed() {
        newSubformSelected(6)
    }
    
    func eighthButtonPressed() {
        newSubformSelected(7)
    }
    
    func newSubformSelected(forumSelected: Int) {
        for i in (0..<9) {
            if i != 8 {
                UIView.animateWithDuration(0.8, delay: 0.05 * Double(i), usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                    self.collectionOfForumEntries![i].transform = CGAffineTransformMakeTranslation(0.0, -100.0)
                    self.collectionOfForumEntries![i].alpha = 0.0
                }, completion: nil)
            }
            if i == 8 {
                UIView.animateWithDuration(0.8, delay: 0.05 * Double(i), usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                    self.mainForumEntry.transform = CGAffineTransformMakeTranslation(0.0, -100.0)
                    self.mainForumEntry.alpha = 0.0
                    for entry in self.collectionOfForumDetails! {
                        entry.alpha = 0.0
                    }
                    }, completion: { (ifCompleted) in
                        self.switchLabelsBetweenForumEntryCollectionAndMainForumEntry(forumSelected)
                        self.updateForumDetails()
                        for i in (0..<9) {
                            if i != 8 {
                                UIView.animateWithDuration(0.8, delay: 0.05 * Double(i), usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                                    self.collectionOfForumEntries![i].transform = CGAffineTransformIdentity
                                    self.collectionOfForumEntries![i].alpha = 0.25
                                    }, completion: nil)
                            }
                            if i == 8{
                                UIView.animateWithDuration(0.8, delay: 0.05 * Double(i), usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                                    self.mainForumEntry.transform = CGAffineTransformIdentity
                                    self.mainForumEntry.alpha = 1.0
                                    for entry in self.collectionOfForumDetails! {
                                        entry.alpha = 1.0
                                        self.enterSubsectionsTitle.alpha = 0.5
                                    }
                                    }, completion: nil)
                            }
                        }
                })
            }
        }
    }
    
    func switchLabelsBetweenForumEntryCollectionAndMainForumEntry(forumSelected: Int) {
        print(forumSelected)
        var firstSlice : [String]? = nil
        var secondSlice : [String]? = nil
        
        if forumSelected != 0 {
            firstSlice = Array(collectionOfForumEntryTitles![0..<forumSelected])
        }
        else {
            firstSlice = []
        }

        secondSlice = Array(collectionOfForumEntryTitles![(forumSelected + 1)..<9])

        let mainForumEntryTitle = collectionOfForumEntryTitles![forumSelected]
        
        var newCollectionOfForumEntryTitles : [String] = []
        
        for element in secondSlice! {
            newCollectionOfForumEntryTitles.append(element)
        }
        for element in firstSlice! {
            newCollectionOfForumEntryTitles.append(element)
        }
        newCollectionOfForumEntryTitles.append(mainForumEntryTitle)
        for i in (0..<9) {
            collectionOfForumEntries![i].setTitle(newCollectionOfForumEntryTitles[i], forState: UIControlState.Normal)
        }
        collectionOfForumEntryTitles = newCollectionOfForumEntryTitles
        
    }
    
    func updateForumDetails() {
        // Update Details of Subforums Here
    }
}