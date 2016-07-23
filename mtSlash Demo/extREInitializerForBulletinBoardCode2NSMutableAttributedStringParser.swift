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
        } catch {
            fatalError("An error has occurred: Unable to set up REs for parsing Bulletin Board Code.")
        }
    }
}