//
//  CoverPage.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/12/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class CoverPage: UIView {
    
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var SCTitleLabel: UILabel!
    @IBOutlet weak var SCSubtitleLabel: UILabel!
    @IBOutlet weak var ENTitleLabel: UILabel!
    @IBOutlet weak var logonButton: UIButton!
    
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
        backgroundImageView.tag = 10
        self.addSubview(backgroundImageView)
        self.sendSubviewToBack(backgroundImageView)
        
        UIView.animateWithDuration(30.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
            backgroundImageView.transform = CGAffineTransformMakeTranslation(-2400.0, -900.0)
            }, completion: nil)
        
    }
    
}


