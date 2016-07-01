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
    static func incorporateDefaultReadingList(dataController: DefaultDataController) {
        if dataReadyFlag == false {
            fatalError("An error has occurred: Data model is not ready.")
        }
        let managedObjectContextInUse = dataController.managedObjectContext
        let userManualAsAReadingListItem = NSEntityDescription.insertNewObjectForEntityForName("ReadingList", inManagedObjectContext: managedObjectContextInUse) as! MTReadingList
        
        userManualAsAReadingListItem.setUpValues("使用指南", timeAdded: NSDate(), owner: username, link: "", ifVisible: NSNumber(integer: 0), category: NSNumber(integer: 1), abstract: "欢迎您使用手机端访问随缘居。请阅读此文档，了解如何使用、配置以及拓展此应用程序。")
        
        let devProjectSummaryAsAReadingListItem = NSEntityDescription.insertNewObjectForEntityForName("ReadingList", inManagedObjectContext: managedObjectContextInUse) as! MTReadingList
        
        devProjectSummaryAsAReadingListItem.setUpValues("欢迎加入开发者计划", timeAdded: NSDate(), owner: username, link: "", ifVisible: NSNumber(integer: 0), category: NSNumber(integer: 1), abstract: "对于如何开发此应用程序、改进其内部设计或是将此程序迁移至其它平台感兴趣？此文档内包含了一切与开发者计划相关的信息。")
        
        do {
            try managedObjectContextInUse.save()
        } catch {
            print(error)
            fatalError("An error has occurred: System cannot incorporate the default reading list.")
        }
        
        
    }
}
