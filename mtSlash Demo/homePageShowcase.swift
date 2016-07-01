//
//  homePageShowcase.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/27/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class homePageShowcase: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setConstraintsForCenterPanel(panel: homePageShowcasePanel) {
        let viewMargins = self.layoutMarginsGuide
        
        panel.translatesAutoresizingMaskIntoConstraints = false
        
        panel.topAnchor.constraintEqualToAnchor(viewMargins.topAnchor, constant: -8.0).active = true
        panel.bottomAnchor.constraintEqualToAnchor(viewMargins.bottomAnchor, constant: 8.0).active = true
        panel.leadingAnchor.constraintEqualToAnchor(viewMargins.leadingAnchor, constant: 22.0).active = true
        panel.trailingAnchor.constraintEqualToAnchor(viewMargins.trailingAnchor, constant: -22.0).active = true
        
    }
    
    func setConstraintsForLeftPanel(panel: homePageShowcasePanel, showcaseWidth: CGFloat) {
        let viewMargins = self.layoutMarginsGuide
        
        panel.translatesAutoresizingMaskIntoConstraints = false
        
        panel.topAnchor.constraintEqualToAnchor(viewMargins.topAnchor, constant: -8.0).active = true
        panel.bottomAnchor.constraintEqualToAnchor(viewMargins.bottomAnchor, constant: 8.0).active = true
        
        let newWidth = showcaseWidth - 60.0
        
        panel.leadingAnchor.constraintEqualToAnchor(viewMargins.leadingAnchor, constant: 22.0 - newWidth).active = true
        panel.trailingAnchor.constraintEqualToAnchor(viewMargins.trailingAnchor, constant: -22.0 - newWidth).active = true
        
    }
    
    func setConstraintsForRightPanel(panel: homePageShowcasePanel, showcaseWidth: CGFloat) {
        let viewMargins = self.layoutMarginsGuide
        
        panel.translatesAutoresizingMaskIntoConstraints = false
        
        panel.topAnchor.constraintEqualToAnchor(viewMargins.topAnchor, constant: -8.0).active = true
        panel.bottomAnchor.constraintEqualToAnchor(viewMargins.bottomAnchor, constant: 8.0).active = true
        
        let newWidth = showcaseWidth - 60.0
        
        panel.leadingAnchor.constraintEqualToAnchor(viewMargins.leadingAnchor, constant: 22.0 + newWidth).active = true
        panel.trailingAnchor.constraintEqualToAnchor(viewMargins.trailingAnchor, constant: -22.0 + newWidth).active = true
    }
    

}
