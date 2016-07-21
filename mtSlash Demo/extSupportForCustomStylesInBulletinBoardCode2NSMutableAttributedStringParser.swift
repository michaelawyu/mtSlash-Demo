//
//  extSupportForCustomStylesInBulletinBoardCode2NSMutableAttributedStringParser.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/21/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
// Extended BulletinBoardCode2NSMutableAttributedStringParser

extension BulletinBoardCode2NSMutableAttributedStringParser {
    func loadSavedStyles() {
        // Update Needed: Load Styles From Local Source
        fontRegularStyle = "PingFangSC"
        fontBoldStyle = Fonts.getBoldVersionOfSupportedFonts(Fonts.convertFontName2SupportedFonts(fontRegularStyle)!)
        fontSize = 12.0
    }
    
    func refreshStyles() {
        loadSavedStyles()
        convert2NSMutableAttributedString()
    }
    
    
}