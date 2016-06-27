//
//  DefaultDataController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/27/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.

import Foundation
import UIKit
import CoreData

var dataReadyFlag : Bool = false

class DefaultDataController: NSObject {
    
    var managedObjectContext : NSManagedObjectContext
    
    override init() {
        guard let URLForModel = NSBundle.mainBundle().URLForResource("mtSlash_Demo", withExtension: "momd") else {
            fatalError("An error has occurred: Failed to load the data model.")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOfURL: URLForModel) else {
            fatalError("An error has occurred: Failed to initialize the data model.")
        }
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let URLForDocumentDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let selectedURLForDocumentDirectory = URLForDocumentDirectory[URLForDocumentDirectory.endIndex - 1]
            let URLForDataStorage = selectedURLForDocumentDirectory.URLByAppendingPathComponent("DataModel.sqlite")
            do {
                try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: URLForDataStorage, options: nil)
            }   catch {
                fatalError("An error has occurred: Failed to set the persistent store.")
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                dataReadyFlag = true
            })
        }
    }
    
}