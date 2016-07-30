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
    var regularExpressionForUnderlinedText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForFontalText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForHeadOfTagOfFontalText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForTailOfTagOfFontalText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForEmbeddedTable : NSRegularExpression = NSRegularExpression()
    var regularExpressionForFloatingContent : NSRegularExpression = NSRegularExpression()
    var regularExpressionForFlashContent : NSRegularExpression = NSRegularExpression()
    var regularExpressionForBackgroundImage : NSRegularExpression = NSRegularExpression()
    var regularExpressionForList : NSRegularExpression = NSRegularExpression()
    var regularExpressionForAudioFile : NSRegularExpression = NSRegularExpression()
    var regularExpressionForMediaFile : NSRegularExpression = NSRegularExpression()
    
    // Styles
    var fontRegularStyle : String = ""
    var fontBoldStyle : String = ""
    var fontSize : CGFloat = 0.0
    
    init(bulletinBoardCode: String) {
        self.bulletinBoardCode = bulletinBoardCode
        initializeRE()
        loadSavedStyles()
    }
    
    func updateStringToParse(newString: String) -> NSMutableAttributedString {
        bulletinBoardCode = newString
        return convert2NSMutableAttributedString()
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
            
            convertedString.addAttributes([NSFontAttributeName : UIFont(name: fontBoldStyle, size: fontSize)!], range: rangeOfMatchedBoldTextWithTag)
            
            let rangeOfHeadOfTag = NSMakeRange(rangeOfMatchedBoldTextWithTag.location, 3)
            let rangeOfTailOfTag = NSMakeRange((rangeOfMatchedBoldTextWithTag.location + rangeOfMatchedBoldTextWithTag.length - 7), 4)
            
            convertedString.deleteCharactersInRange(rangeOfHeadOfTag)
            convertedString.deleteCharactersInRange(rangeOfTailOfTag)
        }
        
        // Remove All [i][/i] Tags : Tag Not Supported
        while true {
            let matchedItalicTextWithTag = regularExpressionForItalicText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedItalicTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedItalicTextWithTag = matchedItalicTextWithTag!.range
            
            let rangeOfHeadOfTag = NSMakeRange(rangeOfMatchedItalicTextWithTag.location, 3)
            let rangeOfTailOfTag = NSMakeRange((rangeOfMatchedItalicTextWithTag.location + rangeOfMatchedItalicTextWithTag.length - 7), 4)
            
            convertedString.deleteCharactersInRange(rangeOfHeadOfTag)
            convertedString.deleteCharactersInRange(rangeOfTailOfTag)
        }
        
        // Remove All [font = ...][/font] Tags : Tag Not Supported
        while true {
            let matchedFontalTextWithTag = regularExpressionForFontalText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedFontalTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedFontalTextWithTag = matchedFontalTextWithTag!.range
            
            let matchedHeadOfTagOfFontalText = regularExpressionForHeadOfTagOfFontalText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: rangeOfMatchedFontalTextWithTag)
            let matchedTailOfTagOfFontalText = regularExpressionForTailOfTagOfFontalText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: rangeOfMatchedFontalTextWithTag)
            
            let rangeOfHeadOfTag = matchedHeadOfTagOfFontalText!.range
            let rangeOfTailOfTagBeforeDeletionOfHeadOfTag = matchedTailOfTagOfFontalText!.range
            let rangeOfTailOfTag = NSMakeRange(rangeOfTailOfTagBeforeDeletionOfHeadOfTag.location - 19, 7)
            
            convertedString.deleteCharactersInRange(rangeOfHeadOfTag)
            convertedString.deleteCharactersInRange(rangeOfTailOfTag)
        }
        
        // Remove All [table][/table] Tags : Tag Not Supported
        while true {
            let matchedEmbeddedTableWithTag = regularExpressionForEmbeddedTable.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedEmbeddedTableWithTag == nil {
                break
            }
            
            let rangeOfMatchedEmbeddedTableWithTag = matchedEmbeddedTableWithTag!.range
            
            convertedString.deleteCharactersInRange(rangeOfMatchedEmbeddedTableWithTag)
        }
        
        // Remove All [float][/float] Tags : Tag Not Supported
        while true {
            let matchedFloatingContentWithTag = regularExpressionForFloatingContent.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedFloatingContentWithTag == nil {
                break
            }
            
            let rangeOfMatchedFloatingContentWithTag = matchedFloatingContentWithTag!.range
            
            convertedString.deleteCharactersInRange(rangeOfMatchedFloatingContentWithTag)
        }
        
        // Remove All [flash][/flash] Tags : Tag Not Supported
        while true {
            let matchedFlashContentWithTag = regularExpressionForFlashContent.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedFlashContentWithTag == nil {
                break
            }
            
            let rangeOfMatchedFlashContentWithTag = matchedFlashContentWithTag!.range
            
            convertedString.deleteCharactersInRange(rangeOfMatchedFlashContentWithTag)
        }
        
        // Remove All [postbg][/postbg] Tags : Tag Not Supported
        while true {
            let matchedBackgroundImageWithTag = regularExpressionForBackgroundImage.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedBackgroundImageWithTag == nil {
                break
            }
            
            let rangeOfMatchedBackgroundImageWithTag = matchedBackgroundImageWithTag!.range
            
            convertedString.deleteCharactersInRange(rangeOfMatchedBackgroundImageWithTag)
        }
        
        // Remove All [list][/list] Tags : Tag Not Supported
        while true {
            let matchedListWithTag = regularExpressionForList.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedListWithTag == nil {
                break
            }
            
            let rangeOfMatchedListWithTag = matchedListWithTag!.range
            
            convertedString.deleteCharactersInRange(rangeOfMatchedListWithTag)
        }
        
        // Convert All [u][/u] Tags to Underlined Text
        while true {
            let matchedUnderlinedTextWithTag = regularExpressionForUnderlinedText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedUnderlinedTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedUnderlinedTextWithTag = matchedUnderlinedTextWithTag!.range
            
            convertedString.addAttributes([NSUnderlineStyleAttributeName : 1], range: rangeOfMatchedUnderlinedTextWithTag)
            
            let rangeOfHeadOfTag = NSMakeRange(rangeOfMatchedUnderlinedTextWithTag.location, 3)
            let rangeOfTailOfTag = NSMakeRange((rangeOfMatchedUnderlinedTextWithTag.location + rangeOfMatchedUnderlinedTextWithTag.length - 7), 4)
            
            convertedString.deleteCharactersInRange(rangeOfHeadOfTag)
            convertedString.deleteCharactersInRange(rangeOfTailOfTag)
        }
        
        // Convert All [audio][/audio] Tags to Embedded Link
        while true {
            let matchedEmbeddedAudioFileWithTag = regularExpressionForAudioFile.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedEmbeddedAudioFileWithTag == nil {
                break
            }
            
            let rangeOfMatchedEmbeddedAudioFileWithTag = matchedEmbeddedAudioFileWithTag!.range
            
            let extractedString = convertedString.mutableString.substringWithRange(rangeOfMatchedEmbeddedAudioFileWithTag)
            let URLForAudioFileAsString = extractedString[extractedString.startIndex.advancedBy(7)..<extractedString.endIndex.advancedBy(-8)]
            
            let URLForAudioFile = NSAttributedString(string: "检测到的音频链接", attributes: [NSLinkAttributeName: NSURL(string: URLForAudioFileAsString)!])
            
            convertedString.replaceCharactersInRange(rangeOfMatchedEmbeddedAudioFileWithTag, withAttributedString: URLForAudioFile)
        }
        
        // Convert All [video][/video] Tags to Embedded Link
        
        return convertedString
    }
}