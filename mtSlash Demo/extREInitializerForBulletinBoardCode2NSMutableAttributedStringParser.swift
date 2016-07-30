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
            regularExpressionForBoldText = try NSRegularExpression(pattern: "\\[b\\].*\\[/b\\]", options: NSRegularExpressionOptions())
            regularExpressionForItalicText = try NSRegularExpression(pattern: "\\[i\\].*\\[/i\\]", options: NSRegularExpressionOptions())
            regularExpressionForUnderlinedText = try NSRegularExpression(pattern: "\\[u\\].*\\[/u\\]", options: NSRegularExpressionOptions())
            regularExpressionForFontalText = try NSRegularExpression(pattern: "\\[font.+?\\].*\\[/font\\]", options: NSRegularExpressionOptions())
            regularExpressionForHeadOfTagOfFontalText = try NSRegularExpression(pattern: "\\[font.+?\\]", options: NSRegularExpressionOptions())
            regularExpressionForTailOfTagOfFontalText = try NSRegularExpression(pattern: "\\[/font\\]", options: NSRegularExpressionOptions())
            regularExpressionForEmbeddedTable = try NSRegularExpression(pattern: "\\[table\\].*\\[/table\\]", options: NSRegularExpressionOptions())
            regularExpressionForFloatingContent = try NSRegularExpression(pattern: "\\[float\\].*\\[/float\\]", options: NSRegularExpressionOptions())
            regularExpressionForFlashContent = try NSRegularExpression(pattern: "\\[flash\\].*\\[/flash\\]", options: NSRegularExpressionOptions())
            regularExpressionForBackgroundImage = try NSRegularExpression(pattern: "\\[postbg\\].*\\[/postbg\\]", options: NSRegularExpressionOptions())
            regularExpressionForList = try NSRegularExpression(pattern: "\\[list.*?\\].*\\[/list\\]", options: NSRegularExpressionOptions())
            regularExpressionForAudioFile = try NSRegularExpression(pattern: "\\[audio\\].*\\[/audio\\]", options: NSRegularExpressionOptions())
            regularExpressionForMediaFile = try NSRegularExpression(pattern: "\\[media.*?\\].*\\[/media\\]", options: NSRegularExpressionOptions())
        } catch {
            fatalError("An error has occurred: Unable to set up REs for parsing Bulletin Board Code.")
        }
    }
}