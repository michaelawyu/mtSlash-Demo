//
//  CoverPage.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/12/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class CoverPage: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        extInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        extInit()
    }
    
    func extInit() {
        let coverImagePath = NSBundle.mainBundle().pathForResource("coverImage.prototype", ofType: "jpg")
        let backgroundImageView = UIImageView(image: UIImage(named: coverImagePath!))
        self.addSubview(backgroundImageView)
        self.sendSubviewToBack(backgroundImageView)
        
        UIView.animateWithDuration(20.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
            backgroundImageView.transform = CGAffineTransformMakeTranslation(-2400.0, -900.0)
            }, completion: nil)
        
    }
    
}
