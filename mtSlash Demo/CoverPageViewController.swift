//
//  ViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/12/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

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
    
    // Function : Activiated when the logon button is pressed
    @IBAction func logonButtonTouchedUpInside(sender: AnyObject) {
        
        // Prepare for Segue: Hide up all elements on screen
        UIView.animateWithDuration(0.5, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseIn], animations: {
            
            (self.view as! CoverPage).buildLabel.alpha = 0.0
            (self.view as! CoverPage).SCTitleLabel.alpha = 0.0
            (self.view as! CoverPage).SCSubtitleLabel.alpha = 0.0
            (self.view as! CoverPage).ENTitleLabel.alpha = 0.0
            (self.view as! CoverPage).logonButton.alpha = 0.0
            (self.view as! CoverPage).viewWithTag(10)?.alpha = 0.0
            
            }) { (ifCompleted) in
                // Perform the Segue
                self.performSegueWithIdentifier("fromCoverPageToUsernameInputScreen", sender: self)
        }
    }
    


}

