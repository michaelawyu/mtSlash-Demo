//
//  MTSearchHistory+CoreDataProperties.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 9/4/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MTSearchHistory {

    @NSManaged var keyword: String?
    @NSManaged var timeAdded: NSDate?
    @NSManaged var belongTo: MTUsers?

}
