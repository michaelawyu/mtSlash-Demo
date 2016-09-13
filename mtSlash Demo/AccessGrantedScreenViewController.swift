//
//  AccessGrantedScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/19/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit
import CoreData

class AccessGrantedScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        (self.view as! AccessGrantedPage).extInit()
        // Do any additional setup after loading the view.
        
        // Additional initialization procedure
        extInit()
    }
    
    func extInit() {
        // Set default values of settings in database
        // Wait until the framework is ready
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Initialize default setting based on current data model
        let defaultSetting = NSEntityDescription.insertNewObjectForEntityForName("MTSettings", inManagedObjectContext: managedObjectContextInUse) as! MTSettings
        
        // Get current user
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        // Update settings
        defaultSetting.definedFont = "PingFangSC-Regular"
        defaultSetting.definedFontSize = NSNumber(integer: 16)
        defaultSetting.belongTo = currentUser
        
        // Save the setting to data framework
        do {
            try managedObjectContextInUse.save()
        } catch {
            fatalError("An error has occurred: Failed to save updated setting to the database.")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        (self.view as! AccessGrantedPage).showAllElementsWithAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func whatsNewOptionButtonPressed(sender: AnyObject) {
        ActivatedWebLink = WebLinks.WhatsNew
        performSegueWithIdentifier("fromAccessGrantedScreenToWebDocumentScreen", sender: self)
    }
    
    @IBAction func userExpImprovProjButtonPressed(sender: AnyObject) {
        ActivatedWebLink = WebLinks.UserExpImprovProj
        performSegueWithIdentifier("fromAccessGrantedScreenToWebDocumentScreen", sender: self)
    }
    
    @IBAction func proceedButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("fromAccessGrantedScreenToCentralControlScreen", sender: self)
    }
    
}
