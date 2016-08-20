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
        newSubforumSelected(0)
    }
    
    func secondButtonPressed() {
        newSubforumSelected(1)
    }
    
    func thirdButtonPressed() {
        newSubforumSelected(2)
    }
    
    func fourthButtonPressed() {
        newSubforumSelected(3)
    }
    
    func fifthButtonPressed() {
        newSubforumSelected(4)
    }
    
    func sixthButtonPressed() {
        newSubforumSelected(5)
    }
    
    func seventhButtonPressed() {
        newSubforumSelected(6)
    }
    
    func eighthButtonPressed() {
        newSubforumSelected(7)
    }
    
    func newSubforumSelected(forumSelected: Int) {
        for i in (0..<9) {
            if i != 8 {
                // Ease-out all forum entry labels except for the main one
                UIView.animateWithDuration(0.8, delay: 0.05 * Double(i), usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                    self.collectionOfForumEntries![i].transform = CGAffineTransformMakeTranslation(0.0, -100.0)
                    self.collectionOfForumEntries![i].alpha = 0.0
                }, completion: nil)
            }
            if i == 8 {
                // Ease-out the main forum entry label and the section for forum details
                // Hide the background image
                UIView.animateWithDuration(0.8, delay: 0.05 * Double(i), usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                    self.mainForumEntry.transform = CGAffineTransformMakeTranslation(0.0, -100.0)
                    self.mainForumEntry.alpha = 0.0
                    for entry in self.collectionOfForumDetails! {
                        entry.alpha = 0.0
                    }
                    self.backgroundImage.alpha = 0.15
                    }, completion: { (ifCompleted) in
                        
                        // Switch titles of the labels
                        self.switchLabelsBetweenForumEntryCollectionAndMainForumEntry(forumSelected)
                        let currentSection = ForumSections.Sections(rawValue: self.collectionOfForumEntryNumbers!.last!)!
                        
                        // Update the section of forum details
                        self.initForumDetails(currentSection)
                        
                        // Animation block for revealing the background image
                        UIView.animateWithDuration(0.8, animations: {
                            // Update the background image
                            self.backgroundImage.image = ForumSections.getSectionBackgroundImageOfGivenSection(currentSection)
                            // Reveal the background image
                            self.backgroundImage.alpha = 1.0
                        })
                        
                        for i in (0..<9) {
                            if i != 8 {
                                // Ease-in all updated forum entry labels except for the main on
                                UIView.animateWithDuration(0.8, delay: 0.05 * Double(i), usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                                    self.collectionOfForumEntries![i].transform = CGAffineTransformIdentity
                                    self.collectionOfForumEntries![i].alpha = 0.25
                                    }, completion: nil)
                            }
                            if i == 8{
                                // Ease-in the updated main forum entry label and the section for forum details
                                // Refresh the background
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
        var firstSlice : [String]? = nil
        var firstSliceOfCollectionOfForumEntryNumbers : [Int]? = nil
        var secondSlice : [String]? = nil
        var secondSliceOfCollectionOfForumEntryNumbers : [Int]? = nil
        
        if forumSelected != 0 {
            firstSlice = Array(collectionOfForumEntryTitles![0..<forumSelected])
            firstSliceOfCollectionOfForumEntryNumbers = Array(collectionOfForumEntryNumbers![0..<forumSelected])
        }
        else {
            firstSlice = []
            firstSliceOfCollectionOfForumEntryNumbers = []
        }

        secondSlice = Array(collectionOfForumEntryTitles![(forumSelected + 1)..<9])
        secondSliceOfCollectionOfForumEntryNumbers = Array(collectionOfForumEntryNumbers![(forumSelected + 1)..<9])

        let mainForumEntryTitle = collectionOfForumEntryTitles![forumSelected]
        let mainForumEntryNumber = collectionOfForumEntryNumbers![forumSelected]
        
        var newCollectionOfForumEntryTitles : [String] = []
        var newCollectionOfForumEntryNumbers : [Int] = []
        
        for element in secondSlice! {
            newCollectionOfForumEntryTitles.append(element)
        }
        
        for element in secondSliceOfCollectionOfForumEntryNumbers! {
            newCollectionOfForumEntryNumbers.append(element)
        }
        
        for element in firstSlice! {
            newCollectionOfForumEntryTitles.append(element)
        }
        
        for element in firstSliceOfCollectionOfForumEntryNumbers! {
            newCollectionOfForumEntryNumbers.append(element)
        }
        
        newCollectionOfForumEntryTitles.append(mainForumEntryTitle)
        newCollectionOfForumEntryNumbers.append(mainForumEntryNumber)
        
        for i in (0..<9) {
            collectionOfForumEntries![i].setTitle(newCollectionOfForumEntryTitles[i], forState: UIControlState.Normal)
        }
        
        collectionOfForumEntryTitles = newCollectionOfForumEntryTitles
        collectionOfForumEntryNumbers = newCollectionOfForumEntryNumbers
        
       
    }
    

}