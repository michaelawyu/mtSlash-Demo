//
//  ConvenientMethods.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/28/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ConvenientMethods {
    static func getDataControllerInAppDelegate() -> DefaultDataController {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).dataController
    }
    
    static func getCurrentUser(uid: Int) -> MTUsers {
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController : DefaultDataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Set up fetch requests for future use
        let currentUserFetchRequest = NSFetchRequest(entityName: "MTUsers")
        let predicateForLocatingCurrentUser = NSPredicate(format: "uid == %@", argumentArray: [uid])
        currentUserFetchRequest.predicate = predicateForLocatingCurrentUser
        var currentUser : [MTUsers]? = nil
        
        // Fetch user-specific reading list from the data famework
        do {
            currentUser = try managedObjectContextInUse.executeFetchRequest(currentUserFetchRequest) as? [MTUsers]
        } catch {
            fatalError("An error has occurred: Failed to fetch reading list items from the database.")
        }
        
        return currentUser!.last!
    }
    
}