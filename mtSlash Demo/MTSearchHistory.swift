//
//  MTSearchHistory.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 9/4/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import CoreData


class MTSearchHistory: NSManagedObject {

    func setValuesOfSearchHistoryEntry(keyword: String, timeAdded: NSDate, belongTo: MTUsers) {
        self.keyword = keyword
        self.timeAdded = timeAdded
        self.belongTo = belongTo
    }

}
