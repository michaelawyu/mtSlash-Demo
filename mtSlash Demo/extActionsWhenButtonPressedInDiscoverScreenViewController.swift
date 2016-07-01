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
        var newCollectionOfForumEntriesInName : [UIButton] = []
        newCollectionOfForumEntriesInName.append(mainEntry!)
        mainEntry = collectionOfForumEntriesInName![forumSelected]
        
        var firstSlice : [UIButton]! = []
        var secondSlice : [UIButton]! = []
        
        if forumSelected != 7 {
            firstSlice = Array(collectionOfForumEntriesInName![(forumSelected)..<8])
            let firstSliceReversed = firstSlice.reverse()
            for item in firstSliceReversed {
                newCollectionOfForumEntriesInName.append(item)
            }
        }
        if forumSelected != 0 {
            secondSlice = Array(collectionOfForumEntriesInName![0..<forumSelected])
            let secondSliceReversed = secondSlice.reverse()
            for item in secondSliceReversed {
                newCollectionOfForumEntriesInName.append(item)
            }
        }
        
        let distanceToMoveFor
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: [], animations: {
            
            }, completion: nil)
        
        collectionOfForumEntriesInName = newCollectionOfForumEntriesInName
        
        firstEntry = collectionOfForumEntriesInName![0]
        secondEntry = collectionOfForumEntriesInName![1]
        thirdEntry = collectionOfForumEntriesInName![2]
        fourthEntry = collectionOfForumEntriesInName![3]
        fifthEntry = collectionOfForumEntriesInName![4]
        sixthEntry = collectionOfForumEntriesInName![5]
        seventhEntry = collectionOfForumEntriesInName![6]
        eighthEntry = collectionOfForumEntriesInName![7]
        

    }
}