//
//  TextParser.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/19/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation

class TextParser {
    var parsedText : [String] = []
    var textToParse : [String] = []
    let REForGeneralTag : NSRegularExpression
    
    init(textToParse: [String]) {
        self.textToParse = textToParse
        
        do {
            REForGeneralTag = try NSRegularExpression(pattern: "\\[[a-z]+[=0-9a-z, ]*\\]", options: NSRegularExpressionOptions.AnchorsMatchLines)
        } catch {
            fatalError("An error has occurred: Unable to set up the RE for identifying general tag.")
        }
    }
    
    func iterativeParse() -> [String]? {
        let workload = textToParse.popLast()
        
        // Terminate Parsing if There Leaves Nothing to Parse
        if workload == nil {
            return nil
        }
        
        // Locate the First General Tag
        let rangeOfAGeneralTag = REForGeneralTag.firstMatchInString(workload!, options: NSMatchingOptions.ReportCompletion, range: NSRange(location: 0, length: (workload! as NSString).length))
        
        // Case A: There are no Tags Available Anymore
        if rangeOfAGeneralTag == nil {
            parsedText.append(workload!)
        }
        
        let locationOfTag = rangeOfAGeneralTag!.range.location
        // Case B: A Tag has been Found in a Non-Zero Location
        if locationOfTag != 0 {
            parsedText.append(workload![workload!.startIndex..<workload!.startIndex.advancedBy(locationOfTag)])
        }
        return textToParse
    }
}