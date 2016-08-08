//
//  MTReadingList.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/8/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import CoreData


class MTReadingList: NSManagedObject {

    func setValuesOfReadingListItem(title: String, timeAdded: NSDate, link: String, ifVisible: Bool, category: Int, abstract: String, belongTo: MTUsers) {
        self.title = title
        self.timeAdded = timeAdded
        self.link = link
        self.ifVisible = ifVisible
        self.category = category
        self.abstract = abstract
        self.belongTo = belongTo
    }
}
