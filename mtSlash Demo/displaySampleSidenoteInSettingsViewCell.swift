//
//  displaySampleSidenoteInSettingsViewCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/10/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit
import CoreData

class displaySampleSidenoteInSettingsViewCell: UITableViewCell {

    @IBOutlet weak var displaySampleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func refreshDisplayLabel() {
        let sampleText = "一只敏捷的狐狸跳过了那条栅栏。"
        
        // Read current font and font size settings from data framework
        // Wait until the framework is ready
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Set up fetch request
        let settingItemsFetchRequest = NSFetchRequest(entityName: "MTSettings")
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        let predicateForFetchingSettingsOfSpecificUser = NSPredicate(format: "(belongTo == %@)", argumentArray: [currentUser])
        settingItemsFetchRequest.predicate = predicateForFetchingSettingsOfSpecificUser
        
        var settingsOfCurrentUser : [MTSettings]? = nil
        var settingOfCurrentUser : MTSettings? = nil
        
        // Fetch user-specific setting from data framework
        do {
            settingsOfCurrentUser = try managedObjectContextInUse.executeFetchRequest(settingItemsFetchRequest) as? [MTSettings]
            settingOfCurrentUser = settingsOfCurrentUser!.last
        } catch {
            fatalError("An error has occurred: Failed to fetch setting items from the database.")
        }
        
        let currentFontSizeInRawValue = settingOfCurrentUser!.definedFontSize!.longValue
        let currentFontInRawValue = settingOfCurrentUser!.definedFont! as String
        
        displaySampleLabel.font = UIFont(name: currentFontInRawValue, size: CGFloat(currentFontSizeInRawValue))
        displaySampleLabel.text = sampleText
    }
}
