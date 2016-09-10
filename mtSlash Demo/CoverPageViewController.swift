//
//  ViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/12/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit
import CoreData

// Set up a variable for storing server-end settings
var serverEndSettings : NSDictionary?

class CoverPageViewController: UIViewController {
    
    @IBOutlet weak var logonButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch the URL of backend Server from WebLinks class
        let serverEndURLForSettings = WebLinks.getAddressOfWebLink(WebLinks.ServerStatus)
        
        // Download the settings from the server and read them into serverEndSettings variable
        let sessionForFetchingServerEndSettings = NSURLSession.sharedSession()
        let taskForFetchingServerEndSettings = sessionForFetchingServerEndSettings.dataTaskWithURL(serverEndURLForSettings) { (data, response, error) in
            if error == nil && data != nil {
                serverEndSettings = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            }
        }
        taskForFetchingServerEndSettings.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // Function : Activiated when the logon button is pressed
    @IBAction func logonButtonTouchedUpInside(sender: AnyObject) {
        
        // Check if an user is currently active
        
        // Get the reading list contents from data model (as described in Data Model group).
        // Wait until the framework is initialized.
        while dataReadyFlag != true {
            print("Waiting for the Data Model.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController : DefaultDataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Sign in as last active user, bypassing verification
        let predicateForIdentifyingLastActiveUser = NSPredicate(format: "ifActive == %@", argumentArray: [true])
        let requestForIdentifyingLastActiveUser = NSFetchRequest(entityName: "MTUsers")
        requestForIdentifyingLastActiveUser.predicate = predicateForIdentifyingLastActiveUser
        
        var lastActiveUsers : [MTUsers]? = nil
        
        do {
            lastActiveUsers = try managedObjectContextInUse.executeFetchRequest(requestForIdentifyingLastActiveUser) as? [MTUsers]
        } catch {
            fatalError("An error as occured: Failed to fetch info of last active user from the database.")
        }
        
        if lastActiveUsers?.count != 0 {
            let lastActiveUser = lastActiveUsers!.first!
            username = lastActiveUser.username!
            password = lastActiveUser.password!
            uid = Int(lastActiveUser.uid!)
            
            self.performSegueWithIdentifier("fromCoverPageToCentralControlScreen", sender: self)
        }
        
        // Prepare for Segue: Hide up all elements on screen (if last active user is not found)
        if lastActiveUsers?.count == 0 {
            UIView.animateWithDuration(0.5, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseIn], animations: {
            
                (self.view as! CoverPage).buildLabel.alpha = 0.0
                (self.view as! CoverPage).SCTitleLabel.alpha = 0.0
                (self.view as! CoverPage).SCSubtitleLabel.alpha = 0.0
                (self.view as! CoverPage).ENTitleLabel.alpha = 0.0
                (self.view as! CoverPage).logonButton.alpha = 0.0
                (self.view as! CoverPage).viewWithTag(10)?.alpha = 0.0
            
                }) { (ifCompleted) in
                    
                    let testBuildWarning = UIAlertController(title: "您当前使用的是测试版本", message: "在您开始之前，请注意您即将测试的版本并非最终产品。部分功能及帮助文档可能不可用。请参阅发送至您手中的测试指南了解更多有关此测试版本的信息。", preferredStyle: UIAlertControllerStyle.Alert)
                    let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                        dispatch_async(dispatch_get_main_queue(), {
                            testBuildWarning.dismissViewControllerAnimated(true, completion: nil)
                            // Perform the Segue
                            self.performSegueWithIdentifier("fromCoverPageToUsernameInputScreen", sender: self)
                        })
                    })
                    testBuildWarning.addAction(OKAction)
                    self.presentViewController(testBuildWarning, animated: true, completion: nil)
                    
            }
        }
    }
    


}

