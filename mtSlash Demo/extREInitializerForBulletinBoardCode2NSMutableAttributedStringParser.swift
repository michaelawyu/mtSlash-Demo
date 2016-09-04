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
            regularExpressionForBoldText = try NSRegularExpression(pattern: "(?s)\\[b\\].*?\\[/b\\]", options: NSRegularExpressionOptions())
            regularExpressionForItalicText = try NSRegularExpression(pattern: "(?s)\\[i\\].*?\\[/i\\]", options: NSRegularExpressionOptions())
            regularExpressionForUnderlinedText = try NSRegularExpression(pattern: "(?s)\\[u\\].*?\\[/u\\]", options: NSRegularExpressionOptions())
            regularExpressionForFontalText = try NSRegularExpression(pattern: "(?s)\\[font.+?\\].*?\\[/font\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfFontalText = try NSRegularExpression(pattern: "\\[font.+?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfFontalText = try NSRegularExpression(pattern: "\\[/font\\]", options: NSRegularExpressionOptions())
            regularExpressionForEmbeddedTable = try NSRegularExpression(pattern: "(?s)\\[table\\].*?\\[/table\\]", options: NSRegularExpressionOptions())
            regularExpressionForFloatingContent = try NSRegularExpression(pattern: "(?s)\\[float\\].*?\\[/float\\]", options: NSRegularExpressionOptions())
            regularExpressionForFlashContent = try NSRegularExpression(pattern: "(?s)\\[flash\\].*?\\[/flash\\]", options: NSRegularExpressionOptions())
            regularExpressionForBackgroundImage = try NSRegularExpression(pattern: "(?s)\\[postbg\\].*?\\[/postbg\\]", options: NSRegularExpressionOptions())
            regularExpressionForList = try NSRegularExpression(pattern: "(?s)\\[list.*?\\].*?\\[/list\\]", options: NSRegularExpressionOptions())
            regularExpressionForAudioFile = try NSRegularExpression(pattern: "(?s)\\[audio\\].*?\\[/audio\\]", options: NSRegularExpressionOptions())
            regularExpressionForMediaFile = try NSRegularExpression(pattern: "(?s)\\[media.*?\\].*?\\[/media\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfMediaFile = try NSRegularExpression(pattern:  "\\[media.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfMediaFile = try NSRegularExpression(pattern: "\\[/media\\]", options: NSRegularExpressionOptions())
            regularExpressionForLinkedText = try NSRegularExpression(pattern: "(?s)\\[url.*?\\].*?\\[/url\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfLinkedText = try NSRegularExpression(pattern: "\\[url.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfLinkedText = try NSRegularExpression(pattern: "\\[/url\\]", options: NSRegularExpressionOptions())
            regularExpressionForEmbeddedImage = try NSRegularExpression(pattern: "(?s)\\[img.*?\\].*?\\[/img\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfEmbeddedImage = try NSRegularExpression(pattern: "\\[img.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfEmbeddedImage = try NSRegularExpression(pattern: "\\[/img\\]", options: NSRegularExpressionOptions())
            regularExpressionForSizedText = try NSRegularExpression(pattern: "(?s)\\[size.*?\\].*?\\[/size\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfSizedText = try NSRegularExpression(pattern: "\\[size.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfSizedText = try NSRegularExpression(pattern: "\\[/size\\]", options: NSRegularExpressionOptions())
            regularExpressionForColoredText = try NSRegularExpression(pattern: "(?s)\\[color.*?\\].*?\\[/color\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfColoredText = try NSRegularExpression(pattern: "\\[color.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfColoredText = try NSRegularExpression(pattern: "\\[/color\\]", options: NSRegularExpressionOptions())
            regularExpressionForBackgoundColoredText = try NSRegularExpression(pattern: "(?s)\\[backcolor.*?\\].*?\\[/backcolor\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfBackgroundColoredText = try NSRegularExpression(pattern: "\\[backcolor.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfBackgroundColoredText = try NSRegularExpression(pattern: "\\[/backcolor\\]", options: NSRegularExpressionOptions())
            //regularExpressionForParagraphMark = try NSRegularExpression(pattern: "\\[p*?\\].*?\\[/p\\]", options: NSRegularExpressionOptions())
            regularExpressionForAlignment = try NSRegularExpression(pattern: "(?s)\\[align.*?\\].*?\\[/align\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfAlignment = try NSRegularExpression(pattern: "\\[align.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfAlignment = try NSRegularExpression(pattern: "\\[/align\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfParagraphMark = try NSRegularExpression(pattern: "\\[p.*?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfParagraphMark = try NSRegularExpression(pattern: "\\[/p\\]", options: NSRegularExpressionOptions())
            regularExpressionForSubscriptedText = try NSRegularExpression(pattern: "(?s)\\[sub\\].*?\\[/sub\\]", options: NSRegularExpressionOptions())
            regularExpressionForSuperscriptedText = try NSRegularExpression(pattern: "(?s)\\[sup\\].*?\\[/sup\\]", options: NSRegularExpressionOptions())
            regularExpressionForEmbeddedIMLink = try NSRegularExpression(pattern: "(?s)\\[qq\\].*?\\[/qq\\]", options: NSRegularExpressionOptions())
            regularExpressionForFlyoverContent = try NSRegularExpression(pattern: "(?s)\\[fly\\].*?\\[/fly\\]", options: NSRegularExpressionOptions())
        } catch {
            fatalError("An error has occurred: Unable to set up REs for parsing Bulletin Board Code.")
        }
    }
}