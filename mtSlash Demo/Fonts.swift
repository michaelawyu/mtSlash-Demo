//
//  SupportedFonts.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/21/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation

class Fonts {

    // Supported Fonts
    enum SupportedFonts : String {
        case PingFangSC = "PingFangSC-Regular"
        case Hiragino_Mincho_ProN = "HiraMinProN-W3"
        case Hiragino_Sans = "HiraginoSans-W3"
    }
    
    static let listOfSupportedFonts = [SupportedFonts.PingFangSC, SupportedFonts.Hiragino_Sans, SupportedFonts.Hiragino_Mincho_ProN]
    
    // Supported Font Sizes
    enum SupportedFontSizes : Float {
        case Largest = 20.0
        case Larger = 18.0
        case Standard = 16.0
        case Smaller = 14.0
        case Smallest = 12.0
    }
    
    static let listOfSupportedSizes : [SupportedFontSizes] = [.Largest, .Larger, .Standard, .Smaller, .Smallest]
    
    // SupportedFonts -> String Descriptor of Bold Version of Font
    static func getStringDescriptorOfBoldVersionOfSupportedFonts(font: SupportedFonts) -> String {
        switch font {
        case SupportedFonts.PingFangSC:
            return "PingFangSC-Semibold"
        case SupportedFonts.Hiragino_Mincho_ProN:
            return "HiraMinProN-W6"
        case SupportedFonts.Hiragino_Sans:
            return "HiraginoSans-W6"
        }
    }
    
    // SupportedFonts -> Font Description
    static func getDescriptionOfSupportedFonts(font: SupportedFonts) -> String {
        switch font {
        case .PingFangSC:
            return "苹方(标准)"
        case .Hiragino_Mincho_ProN:
            return "苹果明朝体"
        case .Hiragino_Sans:
            return "苹果丽黑体"
        }
    }
    
    // SupportedFontSizes -> Size Description
    static func getDescriptionOfSupportedFontSizes(fontSize: SupportedFontSizes) -> String {
        switch fontSize {
        case .Standard:
            return "标准"
        case .Largest:
            return "最大"
        case .Larger:
            return "较大"
        case .Smallest:
            return "最小"
        case .Smaller:
            return "较小"
        }
    }
}