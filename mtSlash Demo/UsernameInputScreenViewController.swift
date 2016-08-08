//
//  UsernameInputScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/13/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

// Set up a variable for storing username entered
var username : String = ""
// Set up a variable for storing requested link
var ActivatedWebLink: WebLinks?

class UsernameInputScreenViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.view as! UsernameInputPage).extInit()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        (self.view as! UsernameInputPage).showAllElementsWithAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func registrationOptionButtonPressed(sender: AnyObject) {
        ActivatedWebLink = WebLinks.Registration
        self.performSegueWithIdentifier("fromUsernameInputScreenToWebDocumentScreen", sender: self)
    }
    
    
    @IBAction func logonAsGuestOptionButtonPressed(sender: AnyObject) {
    }

    @IBAction func userNoticeButtonPressed(sender: AnyObject) {
        ActivatedWebLink = WebLinks.UserNotice
        self.performSegueWithIdentifier("fromUsernameInputScreenToWebDocumentScreen", sender: self)
    }
    
    @IBAction func privacyPolicyButtonPressed(sender: AnyObject) {
        ActivatedWebLink = WebLinks.PrivacyPolicy
        self.performSegueWithIdentifier("fromUsernameInputScreenToWebDocumentScreen", sender: self)
    }
    
    @IBAction func proceedButtonPressed(sender: AnyObject) {
        if usernameInput.text == nil || usernameInput.text == "" {
            let usernameNotInputted = UIAlertController(title: "空的用户名", message: "您似乎并没有输入任何用户名。请重新输入后再试。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "重试", style: UIAlertActionStyle.Default, handler: { (action) in usernameNotInputted.dismissViewControllerAnimated(true, completion: nil)})
            usernameNotInputted.addAction(OKAction)
            self.presentViewController(usernameNotInputted, animated: true, completion: nil)
            return
        }
        
        if usernameInput.text!.characters.count < 3 || usernameInput.text!.characters.count > 15 {
            let usernameTooLarge = UIAlertController(title: "过长或过短的用户名", message: "您当前输入的用户名过长或过短。在注册时，您应当使用了一个长度在3和15之间的字符串作为您的用户名。请重新输入后再试。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "重试", style: UIAlertActionStyle.Default, handler: { (action) in usernameTooLarge.dismissViewControllerAnimated(true, completion: nil)})
            usernameTooLarge.addAction(OKAction)
            self.presentViewController(usernameTooLarge, animated: true, completion: nil)
            return
        }
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseIn], animations: {
            
            (self.view as! UsernameInputPage).hideAllElementsForAnimation()
                
        }) { (ifCompleted) in
                self.performSegueWithIdentifier("fromUsernameInputScreenToPasswordInputScreen", sender: self)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        username = usernameInput.text!
    }
}
