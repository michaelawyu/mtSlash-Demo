//
//  BulletBoardCode2NSMutableAttributedStringParser.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/21/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit
// Extension: extREInitializerForBulletinBoardCode2NSMutableAttributedStringParser
// Extension: extSupportForBulletinBoardCode2NSMutableAttributedStringParser

class BulletinBoardCode2NSMutableAttributedStringParser {
    
    var bulletinBoardCode : String = ""

    // REs
    var regularExpressionForBoldText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForItalicText : NSRegularExpression = NSRegularExpression()
    
    // Styles
    var fontRegularStyle : String = ""
    var fontBoldStyle : String = ""
    var fontSize : CGFloat = 0.0
    
    init(bulletinBoardCode: String) {
        self.bulletinBoardCode = bulletinBoardCode
        initializeRE()
        loadSavedStyles()
    }
    
    func convert2NSMutableAttributedString() -> NSMutableAttributedString {
        let convertedString = NSMutableAttributedString(string: bulletinBoardCode)
        
        // Apply Global Styles
        convertedString.addAttributes([NSFontAttributeName : UIFont(name: fontRegularStyle, size: fontSize)!], range: NSMakeRange(0, convertedString.mutableString.length))
        
        // Convert All [b][/b] Tags to Bold Text
        while true {
            let matchedBoldTextWithTag = regularExpressionForBoldText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedBoldTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedBoldTextWithTag = matchedBoldTextWithTag!.range
            
            convertedString.addAttributes([NSFontAttributeName: UIFont(name: fontBoldStyle, size: fontSize)!], range: rangeOfMatchedBoldTextWithTag)
            
            let rangeOfHeadOfTag = NSMakeRange(rangeOfMatchedBoldTextWithTag.location, 3)
            let rangeOfTailOfTag = NSMakeRange((rangeOfMatchedBoldTextWithTag.location + rangeOfMatchedBoldTextWithTag.length - 4), 4)
            
            convertedString.deleteCharactersInRange(rangeOfHeadOfTag)
            convertedString.deleteCharactersInRange(rangeOfTailOfTag)
        }
        
        // Remove All [i][/i] Tags : Not Supported
        while true {
            
        }
        
        return convertedString
    }
}