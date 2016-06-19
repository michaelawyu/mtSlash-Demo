//
//  UsernameInputPage.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/13/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class UsernameInputPage: UIView, UITextFieldDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var optionsTitle: UILabel!
    @IBOutlet weak var registrationOption: UIButton!
    @IBOutlet weak var logonAsGuestOption: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userNoticeButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var proceedButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func showAllElementsWithAnimation() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: [UIViewAnimationOptions.CurveLinear], animations: {
            
            self.navigationBar.alpha = 1.0
            self.mainTitle.alpha = 1.0
            self.descriptionText.alpha = 1.0
            self.usernameInput.alpha = 1.0
            if serverEndSettings != nil && serverEndSettings!.objectForKey("ifBetaTesting") != nil {
                if (serverEndSettings?.objectForKey("ifBetaTesting")!)! as! Int == 1 {
                    self.optionsTitle.alpha = 1.0
                    self.registrationOption.alpha = 1.0
                    self.logonAsGuestOption.alpha = 1.0
                }
            }
            self.backgroundImageView?.alpha = 1.0
            self.userNoticeButton.alpha = 1.0
            self.privacyPolicyButton.alpha = 1.0
            self.proceedButton.alpha = 1.0
            
            }, completion: nil)
        
    }
    
    func hideAllElementsForAnimation() {
        navigationBar.alpha = 0.0
        mainTitle.alpha = 0.0
        descriptionText.alpha = 0.0
        usernameInput.alpha = 0.0
        optionsTitle.alpha = 0.0
        registrationOption.alpha = 0.0
        logonAsGuestOption.alpha = 0.0
        backgroundImageView?.alpha = 0.0
        userNoticeButton.alpha = 0.0
        privacyPolicyButton.alpha = 0.0
        proceedButton.alpha = 0.0
    }
    
    func extInit() {
        
        let navigationBarBackgroundImage = UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3))
        navigationBar.setBackgroundImage(navigationBarBackgroundImage, forBarMetrics: UIBarMetrics.Default)
        navigationBar.alpha = 0.0
        mainTitle.alpha = 0.0
        descriptionText.alpha = 0.0
        usernameInput.alpha = 0.0
        optionsTitle.alpha = 0.0
        registrationOption.alpha = 0.0
        logonAsGuestOption.alpha = 0.0
        backgroundImageView?.alpha = 0.0
        userNoticeButton.alpha = 0.0
        privacyPolicyButton.alpha = 0.0
        proceedButton.alpha = 0.0
        
        usernameInput.delegate = self
        usernameInput.text = username
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil && touches.first!.view != nil && touches.first!.view! != usernameInput {
            usernameInput.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        usernameInput.resignFirstResponder()
        return true
    }
    
}

extension UIImage {
    static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
