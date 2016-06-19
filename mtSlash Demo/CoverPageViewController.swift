//
//  ViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/12/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

var serverEndSettings : NSDictionary?

class CoverPageViewController: UIViewController {
    
    @IBOutlet weak var logonButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let serverEndURLForSettings = WebLinks.getAddressOfWebLink(WebLinks.ServerStatus)
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
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logonButtonTouchedUpInside(sender: AnyObject) {
        UIView.animateWithDuration(0.5, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseIn], animations: {
            
            (self.view as! CoverPage).buildLabel.alpha = 0.0
            (self.view as! CoverPage).SCTitleLabel.alpha = 0.0
            (self.view as! CoverPage).SCSubtitleLabel.alpha = 0.0
            (self.view as! CoverPage).ENTitleLabel.alpha = 0.0
            (self.view as! CoverPage).logonButton.alpha = 0.0
            (self.view as! CoverPage).viewWithTag(10)?.alpha = 0.0
            
            }) { (ifCompleted) in
                self.performSegueWithIdentifier("fromCoverPageToUsernameInputScreen", sender: self)
        }
    }
    


}

