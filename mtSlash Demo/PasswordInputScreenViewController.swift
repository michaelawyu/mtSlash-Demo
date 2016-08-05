//
//  PasswordInputScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/15/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

var password : String = ""

class PasswordInputScreenViewController: UIViewController {

    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var switchUserOption: UIButton!
    @IBOutlet weak var optionsTitle: UILabel!
    @IBOutlet weak var proceedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.view as! PasswordInputPage).extInit()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        (self.view as! PasswordInputPage).showAllElementsWithAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchUserOptionButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("fromPasswordInputScreenToUsernameInputScreen", sender: self)
    }

    @IBAction func proceedButtonPressed(sender: AnyObject) {
        if passwordInput.text == nil || passwordInput.text == "" {
            let passwordNotInputted = UIAlertController(title: "空的密码", message: "您似乎并没有输入任何密码。请重新输入后再试。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "重试", style: UIAlertActionStyle.Default, handler: { (action) in passwordNotInputted.dismissViewControllerAnimated(true, completion: nil)})
            passwordNotInputted.addAction(OKAction)
            self.presentViewController(passwordNotInputted, animated: true, completion: nil)
            return
        }
        
        password = passwordInput.text!
        
        passwordInput.userInteractionEnabled = false
        switchUserOption.userInteractionEnabled = false
        proceedButton.setTitle("验证中", forState: UIControlState.Normal)
        UIView.animateWithDuration(0.5) { 
            self.passwordInput.alpha = 0.5
            self.switchUserOption.alpha = 0.5
            self.optionsTitle.alpha = 0.5
        }
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
            self.proceedButton.backgroundColor = UIColor(red: 227.0/255.0, green: 18.0/255.0, blue: 11.0/255.0, alpha: 0.2)
            }, completion: nil)
        
        let serverEndURLForUserAuthentication = WebLinks.getAddressOfWebLink(WebLinks.UserAuthentication)
        let sessionForUserAuthentication = NSURLSession.sharedSession()
        let requestForUserAuthentication = NSMutableURLRequest(URL: serverEndURLForUserAuthentication)
        requestForUserAuthentication.HTTPMethod = "POST"
        requestForUserAuthentication.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        let HTTPBodyContentForRequest = "username=\(username)&password=\(password)"
        requestForUserAuthentication.HTTPBody = HTTPBodyContentForRequest.dataUsingEncoding(NSUTF8StringEncoding)
        
        let taskForUserAuthentication = sessionForUserAuthentication.dataTaskWithRequest(requestForUserAuthentication) { (data, response, error) in
            if error != nil || data == nil {
                dispatch_async(dispatch_get_main_queue(), {
                    let authenticationFailed = UIAlertController(title: "无法验证您的密码", message: "密码验证失败。可能是发生了一个网络问题。请检查您当前的网络设置，或访问随缘居以了解服务器的工作状态。", preferredStyle: UIAlertControllerStyle.Alert)
                    let OKAction = UIAlertAction(title: "重试", style: UIAlertActionStyle.Default, handler: { (action) in
                        authenticationFailed.dismissViewControllerAnimated(true, completion: nil)
                    })
                    authenticationFailed.addAction(OKAction)
                    self.presentViewController(authenticationFailed, animated: true, completion: nil)
                    
                    self.proceedButton.layer.removeAllAnimations()
                    self.proceedButton.backgroundColor = UIColor(red: 227.0/255.0, green: 18.0/255.0, blue: 11.0/255.0, alpha: 0.7)
                    
                    self.passwordInput.userInteractionEnabled = true
                    self.switchUserOption.userInteractionEnabled = true
                    self.proceedButton.setTitle("下一步", forState: UIControlState.Normal)
                    self.passwordInput.alpha = 1
                    self.switchUserOption.alpha = 1
                    self.optionsTitle.alpha = 1
                })
            }
            if error == nil {
                let serverResponse = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
                let ifPassedAuthentication = serverResponse["result"]!
                
                if ifPassedAuthentication as! Int == 1 {
                    self.performSegueWithIdentifier("fromPasswordInputScreenToAccessGrantedScreen", sender: self)
                }

                if ifPassedAuthentication as! Int == 0 {
                    dispatch_async(dispatch_get_main_queue(), {
                        let accessDenied = UIAlertController(title: "错误的用户名或密码", message: "你输入的密码与当前的用户名不匹配，或您使用的身份还不具备访问随缘居的权限。请尝试重新输入登录凭据。", preferredStyle: UIAlertControllerStyle.Alert)
                        let OKAction = UIAlertAction(title: "重试", style: UIAlertActionStyle.Default, handler: { (action) in
                            accessDenied.dismissViewControllerAnimated(true, completion: nil)
                        })
                        accessDenied.addAction(OKAction)
                        self.presentViewController(accessDenied, animated: true, completion: nil)
                        
                        self.proceedButton.layer.removeAllAnimations()
                        self.proceedButton.backgroundColor = UIColor(red: 227.0/255.0, green: 18.0/255.0, blue: 11.0/255.0, alpha: 0.7)
                         
                        self.passwordInput.userInteractionEnabled = true
                        self.switchUserOption.userInteractionEnabled = true
                        self.proceedButton.setTitle("下一步", forState: UIControlState.Normal)
                        self.passwordInput.alpha = 1
                        self.switchUserOption.alpha = 1
                        self.optionsTitle.alpha = 1
                    })
                }
            }
        }
        taskForUserAuthentication.resume()
    }

    
}
