//
//  SupportedFonts.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/21/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation

class Fonts {
    
    enum SupportedFonts {
        case PingFangSC
    }
    
    static func convertFontName2SupportedFonts(name: String) -> SupportedFonts? {
        switch name {
        case "PingFangSC-Regular":
            return SupportedFonts.PingFangSC
        default:
            return nil
        }
    }
    
    static func getBoldVersionOfSupportedFonts(font: SupportedFonts) -> String {
        switch font {
        case SupportedFonts.PingFangSC:
            return "PingFangSC-Semibold"
        }
    }
}