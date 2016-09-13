//
//  Initialization.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/28/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Initialization {
    
    static func incorporateDefaultReadingList(dataController: DefaultDataController, user: MTUsers) {
        
        // Throw a fatal error if data model is not ready when executing this function
        if dataReadyFlag == false {
            fatalError("An error has occurred: Data model is not ready.")
        }
        
        // Initialize moc (managed object context)
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Initialize a new reading list item based on current data mobel
        let userManualAsAReadingListItem = NSEntityDescription.insertNewObjectForEntityForName("MTReadingList", inManagedObjectContext: managedObjectContextInUse) as! MTReadingList
        let devProjectSummaryAsAReadingListItem = NSEntityDescription.insertNewObjectForEntityForName("MTReadingList", inManagedObjectContext: managedObjectContextInUse) as! MTReadingList
        
        // Set values of the item
        userManualAsAReadingListItem.setValuesOfReadingListItem("使用指南", timeAdded: NSDate(), link: "62", ifVisible: false, category: 70, abstract: "欢迎您使用访问随缘居。请阅读此文档，了解如何使用、配置以及拓展此应用程序。", belongTo: user)
    
        devProjectSummaryAsAReadingListItem.setValuesOfReadingListItem("欢迎加入开发者计划", timeAdded: NSDate(), link: "61", ifVisible: false, category: 70, abstract: "对于如何开发此应用程序、改进其内部设计或是将此程序迁移至其它平台感兴趣？此文档内包含了一切与开发者计划相关的信息。", belongTo: user)
        
        // Save the changes
        do {
            try managedObjectContextInUse.save()
        } catch {
            fatalError("An error has occurred: System cannot incorporate the default reading list.")
        }
    }

}
