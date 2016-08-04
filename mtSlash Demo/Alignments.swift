//
//  Alignments.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/4/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit

class Alignments {
    enum SupportedAlignments {
        case Left
        case Center
        case Right
        case Default
    }
    
    var paragraphStylesOfSupportedAlignmentsDict = [ SupportedAlignments : NSMutableParagraphStyle ]()
    var namesOfSupportedAlignmentsDict = [ String : SupportedAlignments ]()
    
    init() {
        let leftAlignedParagraphStyle = NSMutableParagraphStyle()
        leftAlignedParagraphStyle.setParagraphStyle(NSParagraphStyle.defaultParagraphStyle())
        leftAlignedParagraphStyle.alignment = NSTextAlignment.Left
        leftAlignedParagraphStyle.lineHeightMultiple = 1.2
        
        let centerAlignedParagraphStyle = NSMutableParagraphStyle()
        centerAlignedParagraphStyle.setParagraphStyle(NSParagraphStyle.defaultParagraphStyle())
        centerAlignedParagraphStyle.alignment = NSTextAlignment.Center
        centerAlignedParagraphStyle.lineHeightMultiple = 1.2
        
        let rightAlignedParagraphStyle = NSMutableParagraphStyle()
        rightAlignedParagraphStyle.setParagraphStyle(NSParagraphStyle.defaultParagraphStyle())
        rightAlignedParagraphStyle.alignment = NSTextAlignment.Right
        rightAlignedParagraphStyle.lineHeightMultiple = 1.2
        
        let defaultParagraphStyle = NSMutableParagraphStyle()
        defaultParagraphStyle.setParagraphStyle(NSParagraphStyle.defaultParagraphStyle())
        
        paragraphStylesOfSupportedAlignmentsDict[SupportedAlignments.Left] = leftAlignedParagraphStyle
        paragraphStylesOfSupportedAlignmentsDict[SupportedAlignments.Center] = centerAlignedParagraphStyle
        paragraphStylesOfSupportedAlignmentsDict[SupportedAlignments.Right] = rightAlignedParagraphStyle
        paragraphStylesOfSupportedAlignmentsDict[SupportedAlignments.Default] = defaultParagraphStyle
        
        namesOfSupportedAlignmentsDict["left"] = SupportedAlignments.Left
        namesOfSupportedAlignmentsDict["center"] = SupportedAlignments.Center
        namesOfSupportedAlignmentsDict["right"] = SupportedAlignments.Right
        namesOfSupportedAlignmentsDict["default"] = SupportedAlignments.Default
    }
    
    func convertNameOfSupportedAlignment2ParagraphStyle(name : String) -> NSMutableParagraphStyle? {
        let alignment = namesOfSupportedAlignmentsDict[name]
        
        if alignment == nil {
            return nil
        }
        
        return paragraphStylesOfSupportedAlignmentsDict[alignment!]
    }
}