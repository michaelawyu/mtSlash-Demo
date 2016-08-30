//
//  extREInitializerForBulletinBoardCode2NSMutableAttributedStringParser.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/21/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
// Extended BulletinBoardCode2NSMutableAttributedStringParser

extension BulletinBoardCode2NSMutableAttributedStringParser {
    
    func initializeRE() {
        
        do {
            regularExpressionForBoldText = try NSRegularExpression(pattern: "\\[b\\].*?\\[/b\\]", options: NSRegularExpressionOptions())
            regularExpressionForItalicText = try NSRegularExpression(pattern: "\\[i\\].*?\\[/i\\]", options: NSRegularExpressionOptions())
            regularExpressionForUnderlinedText = try NSRegularExpression(pattern: "\\[u\\].*?\\[/u\\]", options: NSRegularExpressionOptions())
            regularExpressionForFontalText = try NSRegularExpression(pattern: "\\(?s)[font.+?\\].*?\\[/font\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfFontalText = try NSRegularExpression(pattern: "\\[font.+?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfFontalText = try NSRegularExpression(pattern: "\\[/font\\]", options: NSRegularExpressionOptions())
            regularExpressionForEmbeddedTable = try NSRegularExpression(pattern: "\\[table\\].*?\\[/table\\]", options: NSRegularExpressionOptions())
            regularExpressionForFloatingContent = try NSRegularExpression(pattern: "\\[float\\].*?\\[/float\\]", options: NSRegularExpressionOptions())
            regularExpressionForFlashContent = try NSRegularExpression(pattern: "\\[flash\\].*?\\[/flash\\]", options: NSRegularExpressionOptions())
            regularExpressionForBackgroundImage = try NSRegularExpression(pattern: "\\[postbg\\].*?\\[/postbg\\]", options: NSRegularExpressionOptions())
            regularExpressionForList = try NSRegularExpression(pattern: "\\[list.*?\\].*?\\[/list\\]", options: NSRegularExpressionOptions())
            regularExpressionForAudioFile = try NSRegularExpression(pattern: "\\[audio\\].*?\\[/audio\\]", options: NSRegularExpressionOptions())
            regularExpressionForMediaFile = try NSRegularExpression(pattern: "\\[media.*?\\].*?\\[/media\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfMediaFile = try NSRegularExpression(pattern:  "\\[media.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfMediaFile = try NSRegularExpression(pattern: "\\[/media\\]", options: NSRegularExpressionOptions())
            regularExpressionForLinkedText = try NSRegularExpression(pattern: "\\[url.*?\\].*?\\[/url\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfLinkedText = try NSRegularExpression(pattern: "\\[url.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfLinkedText = try NSRegularExpression(pattern: "\\[/url\\]", options: NSRegularExpressionOptions())
            regularExpressionForEmbeddedImage = try NSRegularExpression(pattern: "\\[img\\].*?\\[/img\\]", options: NSRegularExpressionOptions())
            regularExpressionForSizedText = try NSRegularExpression(pattern: "\\[size.*?\\].*?\\[/size\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfSizedText = try NSRegularExpression(pattern: "\\[size.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfSizedText = try NSRegularExpression(pattern: "\\[/size\\]", options: NSRegularExpressionOptions())
            regularExpressionForColoredText = try NSRegularExpression(pattern: "\\[color.*?\\].*?\\[/color\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfColoredText = try NSRegularExpression(pattern: "\\[color.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfColoredText = try NSRegularExpression(pattern: "\\[/color\\]", options: NSRegularExpressionOptions())
            regularExpressionForBackgoundColoredText = try NSRegularExpression(pattern: "\\[backcolor.*?\\].*?\\[/backcolor\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfBackgroundColoredText = try NSRegularExpression(pattern: "\\[backcolor.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfBackgroundColoredText = try NSRegularExpression(pattern: "\\[/backcolor\\]", options: NSRegularExpressionOptions())
            //regularExpressionForParagraphMark = try NSRegularExpression(pattern: "\\[p*?\\].*?\\[/p\\]", options: NSRegularExpressionOptions())
            regularExpressionForAlignment = try NSRegularExpression(pattern: "\\[align.*?\\].*?\\[/align\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfAlignment = try NSRegularExpression(pattern: "\\[align.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfAlignment = try NSRegularExpression(pattern: "\\[/align\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfParagraphMark = try NSRegularExpression(pattern: "\\[p.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfParagraphMark = try NSRegularExpression(pattern: "\\[/p\\]", options: NSRegularExpressionOptions())
            regularExpressionForSubscriptedText = try NSRegularExpression(pattern: "\\[sub\\].*?\\[/sub\\]", options: NSRegularExpressionOptions())
            regularExpressionForSuperscriptedText = try NSRegularExpression(pattern: "\\[sup\\].*?\\[/sup\\]", options: NSRegularExpressionOptions())
            regularExpressionForEmbeddedIMLink = try NSRegularExpression(pattern: "\\[qq\\].*?\\[/qq\\]", options: NSRegularExpressionOptions())
            regularExpressionForFlyoverContent = try NSRegularExpression(pattern: "\\[fly\\].*?\\[/fly\\]", options: NSRegularExpressionOptions())
        } catch {
            fatalError("An error has occurred: Unable to set up REs for parsing Bulletin Board Code.")
        }
    }
}