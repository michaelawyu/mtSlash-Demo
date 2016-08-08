//
//  MTReadingList+CoreDataProperties.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/8/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MTReadingList {

    @NSManaged var abstract: String?
    @NSManaged var category: NSNumber?
    @NSManaged var ifVisible: NSNumber?
    @NSManaged var link: String?
    @NSManaged var timeAdded: NSDate?
    @NSManaged var title: String?
    @NSManaged var belongTo: MTUsers?

}
