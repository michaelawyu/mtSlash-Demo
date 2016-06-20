//
//  PasswordInputPage.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/17/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class PasswordInputPage: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var optionsTitle: UILabel!
    @IBOutlet weak var switchUserOption: UIButton!
    @IBOutlet weak var helpNeededText: UILabel!
    @IBOutlet weak var proceedButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func extInit() {
        let navigationBarBackgroundImage = UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3))
        navigationBar.setBackgroundImage(navigationBarBackgroundImage, forBarMetrics: UIBarMetrics.Default)
        navigationBar.alpha = 0.0
        mainTitle.alpha = 0.0
        descriptionText.alpha = 0.0
        passwordInput.alpha = 0.0
        optionsTitle.alpha = 0.0
        switchUserOption.alpha = 0.0
        helpNeededText.alpha = 0.0
        proceedButton.alpha = 0.0
        switchUserOption.setTitle("@" + username, forState: UIControlState.Normal)
        
        passwordInput.delegate = self
    }
    
    func showAllElementsWithAnimation() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: [UIViewAnimationOptions.CurveLinear], animations: {
            self.navigationBar.alpha = 1.0
            self.mainTitle.alpha = 1.0
            self.descriptionText.alpha = 1.0
            self.passwordInput.alpha = 1.0
            self.optionsTitle.alpha = 1.0
            self.switchUserOption.alpha = 1.0
            self.helpNeededText.alpha = 1.0
            self.proceedButton.alpha = 1.0
            }, completion: nil)
    }
    
    func hideAllElementsForAnimation() {
        self.navigationBar.alpha = 0.0
        self.mainTitle.alpha = 0.0
        self.descriptionText.alpha = 0.0
        self.passwordInput.alpha = 0.0
        self.optionsTitle.alpha = 0.0
        self.switchUserOption.alpha = 0.0
        self.helpNeededText.alpha = 0.0
        self.proceedButton.alpha = 0.0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil && touches.first!.view != nil && touches.first!.view! != passwordInput {
            passwordInput.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        passwordInput.resignFirstResponder()
        return true
    }
}
