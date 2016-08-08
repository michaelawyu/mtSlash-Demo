//
//  MTUsers+CoreDataProperties.swift
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

extension MTUsers {

    @NSManaged var username: String?
    @NSManaged var password: String?
    @NSManaged var uid: NSNumber?
    @NSManaged var email: String?
    @NSManaged var groupid: NSNumber?
    @NSManaged var ifActive: NSNumber?
    @NSManaged var haveAReadingListOf: NSSet?

}
