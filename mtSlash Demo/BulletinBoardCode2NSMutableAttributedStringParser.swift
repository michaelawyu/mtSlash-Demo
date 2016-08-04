//
//  BulletBoardCode2NSMutableAttributedStringParser.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/21/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit
import CoreText
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
    var regularExpressionForHeadOfTagOfMediaFile : NSRegularExpression = NSRegularExpression()
    var regularExpressionForTailOfTagOfMediaFile : NSRegularExpression = NSRegularExpression()
    var regularExpressionForLinkedText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForHeadOfTagOfLinkedText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForTailOfTagOfLinkedText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForEmbeddedImage : NSRegularExpression = NSRegularExpression()
    var regularExpressionForSizedText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForHeadOfTagOfSizedText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForTailOfTagOfSizedText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForColoredText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForHeadOfTagOfColoredText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForTailOfTagOfColoredText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForBackgoundColoredText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForHeadOfTagOfBackgroundColoredText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForTailOfTagOfBackgroundColoredText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForAlignment : NSRegularExpression = NSRegularExpression()
    var regularExpressionForHeadOfTagOfAlignment : NSRegularExpression = NSRegularExpression()
    var regularExpressionForTailOfTagOfAlignment : NSRegularExpression = NSRegularExpression()
    var regularExpressionForHeadOfTagOfParagraphMark : NSRegularExpression = NSRegularExpression()
    var regularExpressionForTailOfTagOfParagraphMark : NSRegularExpression = NSRegularExpression()
    var regularExpressionForSubscriptedText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForSuperscriptedText : NSRegularExpression = NSRegularExpression()
    var regularExpressionForEmbeddedIMLink : NSRegularExpression = NSRegularExpression()
    var regularExpressionForFlyoverContent : NSRegularExpression = NSRegularExpression()
    
    // Styles
    var fontRegularStyle : String = ""
    var fontBoldStyle : String = ""
    var fontSize : CGFloat = 0.0
    
    // Color Palatte
    let supportedColors = Colors()
    
    // List of Available Alignments
    let supportedAlignments = Alignments()
    
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
        
        // Convert All [sub][/sub] Tags to Subscripted Text
        while true {
            let matchedSubscriptedTextWithTag = regularExpressionForSubscriptedText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedSubscriptedTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedSubscriptedTextWithTag = matchedSubscriptedTextWithTag!.range
            
            convertedString.addAttributes([kCTSuperscriptAttributeName as String: -1], range: rangeOfMatchedSubscriptedTextWithTag)
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedSubscriptedTextWithTag.location + rangeOfMatchedSubscriptedTextWithTag.length - 6, 6))
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedSubscriptedTextWithTag.location, 5))
        }
        
        // Convert All [sup][sup] Tags to Superscripted Text
        while true {
            let matchedSuperscriptedTextWithTag = regularExpressionForSuperscriptedText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedSuperscriptedTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedSuperscriptedTextWithTag = matchedSuperscriptedTextWithTag!.range
            
            convertedString.addAttributes([kCTSuperscriptAttributeName as String: 1], range: rangeOfMatchedSuperscriptedTextWithTag)
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedSuperscriptedTextWithTag.location + rangeOfMatchedSuperscriptedTextWithTag.length - 6, 6))
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedSuperscriptedTextWithTag.location, 5))
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
        
        // Remove All [qq][/qq] Tags : Tag Not Supported
        while true {
            let matchedEmbeddedIMLinkWithTag = regularExpressionForEmbeddedIMLink.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedEmbeddedIMLinkWithTag == nil {
                break
            }
            
            let rangeOfMatchedEmbeddedIMLinkWithTag = matchedEmbeddedIMLinkWithTag!.range
            
            convertedString.deleteCharactersInRange(rangeOfMatchedEmbeddedIMLinkWithTag)
        }
        
        // Remove All [fly][/fly] Tags : Tag Not Supported
        while true {
            let matchedFlyoverContentWithTag = regularExpressionForFlyoverContent.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedFlyoverContentWithTag == nil {
                break
            }
            
            let rangeOfMatchedFlyoverContentWithTag = matchedFlyoverContentWithTag!.range
            
            convertedString.deleteCharactersInRange(rangeOfMatchedFlyoverContentWithTag)
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
        
        // Remove All [p][/p] Tags: Not Required in Parsing
        while true {
            let matchedHeadOfTagOfParagraphMark = regularExpressionForHeadOfTagOfParagraphMark.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            let matchedTailOfTagOfParagraphMark = regularExpressionForTailOfTagOfParagraphMark.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedHeadOfTagOfParagraphMark == nil || matchedTailOfTagOfParagraphMark == nil {
                break
            }
            
            let rangeOfMatchedHeadOfTagOfParagraphMark = matchedHeadOfTagOfParagraphMark!.range
            let rangeOfMatchedTailOfTagOfParagraphMark = matchedTailOfTagOfParagraphMark!.range
            
            convertedString.deleteCharactersInRange(rangeOfMatchedTailOfTagOfParagraphMark)
            convertedString.deleteCharactersInRange(rangeOfMatchedHeadOfTagOfParagraphMark)
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
        
        // Convert All [img][/img] Tags to Embedded Link
        while true {
            let matchedEmbeddedImageWithTag = regularExpressionForEmbeddedImage.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedEmbeddedImageWithTag == nil {
                break
            }
            
            let rangeOfMatchedEmbeddedImageWithTag = matchedEmbeddedImageWithTag!.range
            
            let extractedString = convertedString.mutableString.substringWithRange(rangeOfMatchedEmbeddedImageWithTag)
            let URLForEmbeddedImageAsString = extractedString[extractedString.startIndex.advancedBy(5)..<extractedString.endIndex.advancedBy(-6)]
            
            let URLForEmbeddedImage = NSAttributedString(string: "检测到的图像链接", attributes: [NSLinkAttributeName: NSURL(string: URLForEmbeddedImageAsString)!])
            
            convertedString.replaceCharactersInRange(rangeOfMatchedEmbeddedImageWithTag, withAttributedString: URLForEmbeddedImage)
        }
        
        // Convert All [media][/media] Tags to Embedded Link
        while true {
            let matchedEmbeddedMediaFileWithTag = regularExpressionForMediaFile.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedEmbeddedMediaFileWithTag == nil {
                break
            }
            
            let rangeOfMatchedEmbeddedMediaFileWithTag = matchedEmbeddedMediaFileWithTag!.range
            
            let extractedString = NSMutableString(string: convertedString.mutableString.substringWithRange(rangeOfMatchedEmbeddedMediaFileWithTag))
            let matchedHeadOfTagOfMediaFile = regularExpressionForHeadOfTagOfMediaFile.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            let matchedTailOfTagOfMediaFile = regularExpressionForTailOfTagOfMediaFile.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            
            let rangeOfMatchedHeadOfTagOfMediaFile = matchedHeadOfTagOfMediaFile!.range
            let rangeOfMatchedTailOfTagOfMediaFile = matchedTailOfTagOfMediaFile!.range
            
            let extractedStringInString = extractedString as String
            let URLForMediaFileAsString = extractedStringInString[extractedStringInString.startIndex.advancedBy(rangeOfMatchedHeadOfTagOfMediaFile.length)..<extractedStringInString.endIndex.advancedBy(-(rangeOfMatchedTailOfTagOfMediaFile.length))]
            
            let URLForMediaFile = NSAttributedString(string: "检测到的视频链接", attributes: [NSLinkAttributeName: NSURL(string: URLForMediaFileAsString)!])
            
            convertedString.replaceCharactersInRange(rangeOfMatchedEmbeddedMediaFileWithTag, withAttributedString: URLForMediaFile)
        }
        
        // Convert All [url][/url] Tags to Embedded Link
        while true {
            let matchedLinkedTextWithTag = regularExpressionForLinkedText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedLinkedTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedLinkedTextWithTag = matchedLinkedTextWithTag!.range
            
            let extractedString = NSMutableString(string: convertedString.mutableString.substringWithRange(rangeOfMatchedLinkedTextWithTag))
            let matchedHeadOfTagOfLinkedText = regularExpressionForHeadOfTagOfLinkedText.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            let matchedTailOfTagOfLinkedText = regularExpressionForTailOfTagOfLinkedText.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            
            let rangeOfMatchedHeadOfTagOfLinkedText = matchedHeadOfTagOfLinkedText!.range
            let rangeOfMatchedTailOfTagOfLinkedText = matchedTailOfTagOfLinkedText!.range
            
            let extractedHeadOfTag = extractedString.substringWithRange(rangeOfMatchedHeadOfTagOfLinkedText)
            let URLEmbeddedInLinkedText = extractedHeadOfTag[extractedHeadOfTag.startIndex.advancedBy(5)..<extractedHeadOfTag.endIndex.advancedBy(-1)]
            
            let extractedStringInString = extractedString as String
            let textWithLink = extractedStringInString[extractedStringInString.startIndex.advancedBy(rangeOfMatchedHeadOfTagOfLinkedText.length)..<extractedStringInString.endIndex.advancedBy(-(rangeOfMatchedTailOfTagOfLinkedText.length))]
            
            let linkedTextAsAttributedString = NSAttributedString(string: textWithLink, attributes: [NSLinkAttributeName: NSURL(string: URLEmbeddedInLinkedText)!])
            
            convertedString.replaceCharactersInRange(rangeOfMatchedLinkedTextWithTag, withAttributedString: linkedTextAsAttributedString)
        }
        
        // Resize Text with [size][/size] Tag
        while true {
            let matchedSizedTextWithTag = regularExpressionForSizedText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedSizedTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedSizedTextWithTag = matchedSizedTextWithTag!.range
            
            let extractedString = NSMutableString(string: convertedString.mutableString.substringWithRange(rangeOfMatchedSizedTextWithTag))
            let matchedHeadOfTagOfSizedText = regularExpressionForHeadOfTagOfSizedText.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            let matchedTailOfTagOfSizedText = regularExpressionForTailOfTagOfSizedText.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            
            let rangeOfMatchedHeadOfTagOfSizedText = matchedHeadOfTagOfSizedText!.range
            let rangeOfMatchedTailOfTagOfSizedText = matchedTailOfTagOfSizedText!.range
            
            let extractedHeadOfTag = extractedString.substringWithRange(rangeOfMatchedHeadOfTagOfSizedText)
            let RequestedSizeInString = extractedHeadOfTag[extractedHeadOfTag.startIndex.advancedBy(6)..<extractedHeadOfTag.endIndex.advancedBy(-1)]
            var RequestedSize = Int(RequestedSizeInString)
            
            if RequestedSize == nil || RequestedSize < 1 || RequestedSize > 7 {
                RequestedSize = Int(fontSize)
            }
            
            let updatedSize = CGFloat(Float(fontSize) - Float(3 - RequestedSize!))
            
            convertedString.addAttributes([NSFontAttributeName : UIFont(name: fontRegularStyle, size: updatedSize)!], range: NSMakeRange(rangeOfMatchedSizedTextWithTag.location + rangeOfMatchedHeadOfTagOfSizedText.length, rangeOfMatchedSizedTextWithTag.length - rangeOfMatchedHeadOfTagOfSizedText.length - rangeOfMatchedTailOfTagOfSizedText.length))
            
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedSizedTextWithTag.location + rangeOfMatchedTailOfTagOfSizedText.location, rangeOfMatchedTailOfTagOfSizedText.length))
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedSizedTextWithTag.location + rangeOfMatchedHeadOfTagOfSizedText.location, rangeOfMatchedHeadOfTagOfSizedText.length))
        }
        
        // Color Texts with [color][/color] Tag
        while true {
            let matchedColoredTextWithTag = regularExpressionForColoredText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedColoredTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedColoredTextWithTag = matchedColoredTextWithTag!.range
            let extractedString = NSMutableString(string: convertedString.mutableString.substringWithRange(rangeOfMatchedColoredTextWithTag))
            let matchedHeadOfTagOfColoredText = regularExpressionForHeadOfTagOfColoredText.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            let matchedTailOfTagOfColoredText = regularExpressionForTailOfTagOfColoredText.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            
            let rangeOfMatchedHeadOfTagOfColoredText = matchedHeadOfTagOfColoredText!.range
            let rangeOfMatchedTailOfTagOfColoredText = matchedTailOfTagOfColoredText!.range
            
            let extractedHeadOfTag = extractedString.substringWithRange(rangeOfMatchedHeadOfTagOfColoredText)
            let RequestedColorInString = extractedHeadOfTag[extractedHeadOfTag.startIndex.advancedBy(7)..<extractedHeadOfTag.endIndex.advancedBy(-1)]
            var RequestedColor = supportedColors.convertColorName2SupportedColor(RequestedColorInString)
            
            if RequestedColor == nil {
                RequestedColor = supportedColors.convertColorName2SupportedColor("Black")
            }
            
            convertedString.addAttributes([NSForegroundColorAttributeName: RequestedColor!], range: NSMakeRange(rangeOfMatchedColoredTextWithTag.location + rangeOfMatchedHeadOfTagOfColoredText.length, rangeOfMatchedColoredTextWithTag.length - rangeOfMatchedHeadOfTagOfColoredText.length - rangeOfMatchedTailOfTagOfColoredText.length))
            
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedColoredTextWithTag.location + rangeOfMatchedTailOfTagOfColoredText.location, rangeOfMatchedTailOfTagOfColoredText.length))
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedColoredTextWithTag.location + rangeOfMatchedHeadOfTagOfColoredText.location, rangeOfMatchedHeadOfTagOfColoredText.length))
        }
        
        // Color the Background of Texts with [backcolor][/backcolor] Tag
        while true {
            let matchedBackgroundColoredTextWithTag = regularExpressionForBackgoundColoredText.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
            
            if matchedBackgroundColoredTextWithTag == nil {
                break
            }
            
            let rangeOfMatchedBackgroundColoredTextWithTag = matchedBackgroundColoredTextWithTag!.range
            let extractedString = NSMutableString(string: convertedString.mutableString.substringWithRange(rangeOfMatchedBackgroundColoredTextWithTag))
            let matchedHeadOfTagOfColoredText = regularExpressionForHeadOfTagOfBackgroundColoredText.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            let matchedTailOfTagOfColoredText = regularExpressionForTailOfTagOfBackgroundColoredText.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            
            let rangeOfMatchedHeadOfTagOfBackgroundColoredText = matchedHeadOfTagOfColoredText!.range
            let rangeOfMatchedTailOfTagOfBackgroundColoredText = matchedTailOfTagOfColoredText!.range
            
            let extractedHeadOfTag = extractedString.substringWithRange(rangeOfMatchedHeadOfTagOfBackgroundColoredText)
            let RequestedColorInString = extractedHeadOfTag[extractedHeadOfTag.startIndex.advancedBy(11)..<extractedHeadOfTag.endIndex.advancedBy(-1)]
            var RequestedColor = supportedColors.convertColorName2SupportedColor(RequestedColorInString)
            
            if RequestedColor == nil {
                RequestedColor = supportedColors.convertColorName2SupportedColor("Black")
            }
            
            convertedString.addAttributes([NSForegroundColorAttributeName: RequestedColor!], range: NSMakeRange(rangeOfMatchedBackgroundColoredTextWithTag.location + rangeOfMatchedHeadOfTagOfBackgroundColoredText.length, rangeOfMatchedBackgroundColoredTextWithTag.length - rangeOfMatchedHeadOfTagOfBackgroundColoredText.length - rangeOfMatchedTailOfTagOfBackgroundColoredText.length))
            
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedBackgroundColoredTextWithTag.location + rangeOfMatchedTailOfTagOfBackgroundColoredText.location, rangeOfMatchedTailOfTagOfBackgroundColoredText.length))
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedBackgroundColoredTextWithTag.location + rangeOfMatchedHeadOfTagOfBackgroundColoredText.location, rangeOfMatchedHeadOfTagOfBackgroundColoredText.length))
        }
        
        // Adjust the Alignment of Texts with [align][/align] Tag
         while true {
            let matchedAlignedTextWithTag = regularExpressionForAlignment.firstMatchInString(convertedString.mutableString as String, options: NSMatchingOptions(), range: NSMakeRange(0, convertedString.mutableString.length))
         
            if matchedAlignedTextWithTag == nil {
                break
            }
         
            let rangeOfMatchedAlignedTextWithTag = matchedAlignedTextWithTag!.range
            let extractedString = NSMutableString(string: convertedString.mutableString.substringWithRange(rangeOfMatchedAlignedTextWithTag))
            let matchedHeadOfTagOfAlignedText = regularExpressionForHeadOfTagOfAlignment.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
            let matchedTailOfTagOfAlignedText = regularExpressionForTailOfTagOfAlignment.firstMatchInString(extractedString as String, options: NSMatchingOptions(), range: NSMakeRange(0, extractedString.length))
         
            let rangeOfMatchedHeadOfTagOfAlignedText = matchedHeadOfTagOfAlignedText!.range
            let rangeOfMatchedTailOfTagOfAlignedText = matchedTailOfTagOfAlignedText!.range
         
            let extractedHeadOfTag = extractedString.substringWithRange(rangeOfMatchedHeadOfTagOfAlignedText)
            let requestedAlignmentInString = extractedHeadOfTag[extractedHeadOfTag.startIndex.advancedBy(7)..<extractedHeadOfTag.endIndex.advancedBy(-1)]
            var requestedAlignment = supportedAlignments.convertNameOfSupportedAlignment2ParagraphStyle(requestedAlignmentInString)
         
            if requestedAlignment == nil {
                requestedAlignment = supportedAlignments.convertNameOfSupportedAlignment2ParagraphStyle("default")
            }
         
            convertedString.addAttributes([NSParagraphStyleAttributeName : requestedAlignment!], range: NSMakeRange(rangeOfMatchedAlignedTextWithTag.location + rangeOfMatchedHeadOfTagOfAlignedText.length, rangeOfMatchedAlignedTextWithTag.length - rangeOfMatchedHeadOfTagOfAlignedText.length - rangeOfMatchedTailOfTagOfAlignedText.length))
         
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedAlignedTextWithTag.location + rangeOfMatchedTailOfTagOfAlignedText.location, rangeOfMatchedTailOfTagOfAlignedText.length))
            convertedString.deleteCharactersInRange(NSMakeRange(rangeOfMatchedAlignedTextWithTag.location + rangeOfMatchedHeadOfTagOfAlignedText.location, rangeOfMatchedHeadOfTagOfAlignedText.length))
        }
        
        return convertedString
    }
}