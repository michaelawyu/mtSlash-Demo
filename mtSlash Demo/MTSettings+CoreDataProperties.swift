//
//  MTSettings+CoreDataProperties.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 9/8/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MTSettings {

    @NSManaged var definedFontSize: NSNumber?
    @NSManaged var definedFont: String?
    @NSManaged var belongTo: MTUsers?

}
