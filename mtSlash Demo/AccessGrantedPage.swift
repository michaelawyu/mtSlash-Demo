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
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var optionsTitle: UILabel!
    @IBOutlet weak var whatsNewOption: UIButton!
    @IBOutlet weak var userExpImproProjOption: UIButton!
    @IBOutlet weak var proceedButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func extInit() {
        let coverImagePath = NSBundle.mainBundle().pathForResource("accessGrantedPageBackgroundImage.prototype", ofType: "jpg")
        let backgroundImageView = UIImageView(image: UIImage(named: coverImagePath!))
        backgroundImageView.tag = 10
        self.addSubview(backgroundImageView)
        self.sendSubviewToBack(backgroundImageView)
        
        UIView.animateWithDuration(25.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
            backgroundImageView.transform = CGAffineTransformMakeTranslation(-1200.0, -1000.0)
            }, completion: nil)
        
        let navigationBarBackgroundImage = UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3))
        navigationBar.setBackgroundImage(navigationBarBackgroundImage, forBarMetrics: UIBarMetrics.Default)
        navigationBar.alpha = 0.0
        mainTitle.alpha = 0.0
        mainTitle.transform = CGAffineTransformMakeTranslation(0, +200)
        
    }
}
