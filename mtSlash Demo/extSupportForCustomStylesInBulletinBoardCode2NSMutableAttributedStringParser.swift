//
//  extSupportForCustomStylesInBulletinBoardCode2NSMutableAttributedStringParser.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/21/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit
// Extended BulletinBoardCode2NSMutableAttributedStringParser

extension BulletinBoardCode2NSMutableAttributedStringParser {
    func loadSavedStyles() {
        // Load Styles from Database
        let currentStyle = ConvenientMethods.getCurrentSettingFromDatabase()
        
        fontRegularStyle = currentStyle.1.rawValue
        fontBoldStyle = Fonts.getStringDescriptorOfBoldVersionOfSupportedFonts(currentStyle.1)
        fontSize = CGFloat(currentStyle.0.rawValue)
    }
    
    func refreshStyles() {
        loadSavedStyles()
        convert2NSMutableAttributedString()
    }
    
}