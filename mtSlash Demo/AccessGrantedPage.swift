//
//  AccessGrantedPage.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/19/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class AccessGrantedPage: UIView {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var mainTitle: UIButton!
    @IBOutlet weak var optionsTitle: UIButton!
    @IBOutlet weak var whatsNewOption: UIButton!
    @IBOutlet weak var userExpImprovProjOption: UIButton!
    @IBOutlet weak var proceedButton: UIButton!
    
    var backgroundImageView : UIImageView? = nil
    let coverImagePath = NSBundle.mainBundle().pathForResource("accessGrantedPageBackgroundImage.prototype", ofType: "jpg")
    
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
        mainTitle.transform = CGAffineTransformMakeTranslation(0, +200)
        optionsTitle.alpha = 0.0
        optionsTitle.transform = CGAffineTransformMakeTranslation(0, +200)
        whatsNewOption.alpha = 0.0
        whatsNewOption.transform = CGAffineTransformMakeTranslation(0, +200)
        userExpImprovProjOption.alpha = 0.0
        userExpImprovProjOption.transform = CGAffineTransformMakeTranslation(0, +200)
        proceedButton.alpha = 0.0
        
        self.backgroundImageView = UIImageView(image: UIImage(named: coverImagePath!))
        self.backgroundImageView!.tag = 10
        self.addSubview(backgroundImageView!)
        self.sendSubviewToBack(backgroundImageView!)
    }
    
    func showAllElementsWithAnimation() {
        UIView.animateWithDuration(25.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
            self.backgroundImageView!.transform = CGAffineTransformMakeTranslation(-1200.0, -1000.0)
            }, completion: nil)
        
        UIView.animateWithDuration(0.8, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseOut], animations: {
            self.navigationBar.alpha = 1.0
            self.mainTitle.alpha = 1.0
            self.mainTitle.transform = CGAffineTransformIdentity
            self.optionsTitle.alpha = 1.0
            self.whatsNewOption.alpha = 1.0
            self.userExpImprovProjOption.alpha = 1.0
            self.proceedButton.alpha = 1.0
            self.optionsTitle.transform = CGAffineTransformIdentity
            self.whatsNewOption.transform = CGAffineTransformIdentity
            self.userExpImprovProjOption.transform = CGAffineTransformIdentity
            }, completion: nil)
        
    }
    
    func hideAllElementsForAnimation() {
        navigationBar.alpha = 0.0
        mainTitle.alpha = 0.0
        optionsTitle.alpha = 0.0
        whatsNewOption.alpha = 0.0
        userExpImprovProjOption.alpha = 0.0
        proceedButton.alpha = 0.0
    }
}
