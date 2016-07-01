//
//  MTReadingList.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/28/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import CoreData


class MTReadingList: NSManagedObject {

    func setUpValues(title: String, timeAdded: NSDate, owner: String, link: String, ifVisible: NSNumber, category: NSNumber, abstract: String) {
        
        self.title = title
        self.timeAdded = timeAdded
        self.owner = owner
        self.link = link
        self.ifVisible = ifVisible
        self.category = category
        self.abstract = abstract
    }
}
