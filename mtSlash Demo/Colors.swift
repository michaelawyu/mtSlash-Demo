//
//  Colors.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/2/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    enum SupportedColors {
        case Black
        case Sienna
        case DarkOliveGreen
        case DarkGreen
        case DarkSlateBlue
        case Navy
        case Indigo
        case DarkSlateGray
        case DarkRed
        case DarkOrange
        case Olive
        case Green
        case Teal
        case Blue
        case SlateGray
        case DimGray
        case Red
        case SandyBrown
        case YellowGreen
        case SeaGreen
        case MediumTurquoise
        case RoyalBlue
        case Purple
        case Gray
        case Magenta
        case Orange
        case Yellow
        case Lime
        case Cyan
        case DeepSkyBlue
        case DarkOrchid
        case Silver
        case Pink
        case Wheat
        case LemonChiffon
        case PaleGreen
        case PaleTurquoise
        case LightBlue
        case Plum
    }
    
    var RGBValuesOfSupportedColorsDict = [SupportedColors : UIColor]()
    var NamesOfSupportedColorsDict = [String : SupportedColors]()
    
    init() {
        RGBValuesOfSupportedColorsDict[SupportedColors.Black] = UIColor.convFromRGBValues(255, green: 255, blue: 255)
        RGBValuesOfSupportedColorsDict[SupportedColors.Sienna] = UIColor.convFromRGBValues(162, green: 82, blue: 45)
        RGBValuesOfSupportedColorsDict[SupportedColors.DarkOliveGreen] = UIColor.convFromRGBValues(85, green: 107, blue: 47)
        RGBValuesOfSupportedColorsDict[SupportedColors.DarkGreen] = UIColor.convFromRGBValues(0, green: 100, blue: 0)
        RGBValuesOfSupportedColorsDict[SupportedColors.DarkSlateBlue] = UIColor.convFromRGBValues(72, green: 61, blue: 139)
        RGBValuesOfSupportedColorsDict[SupportedColors.Navy] = UIColor.convFromRGBValues(0, green: 0, blue: 128)
        RGBValuesOfSupportedColorsDict[SupportedColors.Indigo] = UIColor.convFromRGBValues(75, green: 0, blue: 130)
        RGBValuesOfSupportedColorsDict[SupportedColors.DarkSlateGray] = UIColor.convFromRGBValues(47, green: 79, blue: 79)
        RGBValuesOfSupportedColorsDict[SupportedColors.DarkRed] = UIColor.convFromRGBValues(139, green: 0, blue: 0)
        RGBValuesOfSupportedColorsDict[SupportedColors.DarkOrange] = UIColor.convFromRGBValues(255, green: 140, blue: 0)
        RGBValuesOfSupportedColorsDict[SupportedColors.Olive] = UIColor.convFromRGBValues(128, green: 128, blue: 0)
        RGBValuesOfSupportedColorsDict[SupportedColors.Green] = UIColor.convFromRGBValues(0, green: 128, blue: 0)
        RGBValuesOfSupportedColorsDict[SupportedColors.Teal] = UIColor.convFromRGBValues(0, green: 128, blue: 128)
        RGBValuesOfSupportedColorsDict[SupportedColors.Blue] = UIColor.convFromRGBValues(0, green: 0, blue: 255)
        RGBValuesOfSupportedColorsDict[SupportedColors.SlateGray] = UIColor.convFromRGBValues(112, green: 128, blue: 144)
        RGBValuesOfSupportedColorsDict[SupportedColors.DimGray] = UIColor.convFromRGBValues(105, green: 105, blue: 105)
        RGBValuesOfSupportedColorsDict[SupportedColors.Red] = UIColor.convFromRGBValues(255, green: 0, blue: 0)
        RGBValuesOfSupportedColorsDict[SupportedColors.SandyBrown] = UIColor.convFromRGBValues(244, green: 164, blue: 96)
        RGBValuesOfSupportedColorsDict[SupportedColors.YellowGreen] = UIColor.convFromRGBValues(154, green: 205, blue: 50)
        RGBValuesOfSupportedColorsDict[SupportedColors.SeaGreen] = UIColor.convFromRGBValues(46, green: 139, blue: 87)
        RGBValuesOfSupportedColorsDict[SupportedColors.MediumTurquoise] = UIColor.convFromRGBValues(72, green: 209, blue: 204)
        RGBValuesOfSupportedColorsDict[SupportedColors.RoyalBlue] = UIColor.convFromRGBValues(65, green: 105, blue: 225)
        RGBValuesOfSupportedColorsDict[SupportedColors.Purple] = UIColor.convFromRGBValues(128, green: 0, blue: 128)
        RGBValuesOfSupportedColorsDict[SupportedColors.Gray] = UIColor.convFromRGBValues(128, green: 128, blue: 128)
        RGBValuesOfSupportedColorsDict[SupportedColors.Magenta] = UIColor.convFromRGBValues(255, green: 0, blue: 255)
        RGBValuesOfSupportedColorsDict[SupportedColors.Orange] = UIColor.convFromRGBValues(255, green: 165, blue: 0)
        RGBValuesOfSupportedColorsDict[SupportedColors.Yellow] = UIColor.convFromRGBValues(255, green: 255, blue: 0)
        RGBValuesOfSupportedColorsDict[SupportedColors.Lime] = UIColor.convFromRGBValues(0, green: 255, blue: 0)
        RGBValuesOfSupportedColorsDict[SupportedColors.Cyan] = UIColor.convFromRGBValues(0, green: 255, blue: 255)
        RGBValuesOfSupportedColorsDict[SupportedColors.DeepSkyBlue] = UIColor.convFromRGBValues(0, green: 191, blue: 255)
        RGBValuesOfSupportedColorsDict[SupportedColors.DarkOrchid] = UIColor.convFromRGBValues(153, green: 50, blue: 204)
        RGBValuesOfSupportedColorsDict[SupportedColors.Silver] = UIColor.convFromRGBValues(192, green: 192, blue: 192)
        RGBValuesOfSupportedColorsDict[SupportedColors.Pink] = UIColor.convFromRGBValues(255, green: 192, blue: 203)
        RGBValuesOfSupportedColorsDict[SupportedColors.Wheat] = UIColor.convFromRGBValues(245, green: 222, blue: 179)
        RGBValuesOfSupportedColorsDict[SupportedColors.LemonChiffon] = UIColor.convFromRGBValues(255, green: 250, blue: 205)
        RGBValuesOfSupportedColorsDict[SupportedColors.PaleGreen] = UIColor.convFromRGBValues(152, green: 251, blue: 152)
        RGBValuesOfSupportedColorsDict[SupportedColors.PaleTurquoise] = UIColor.convFromRGBValues(175, green: 238, blue: 238)
        RGBValuesOfSupportedColorsDict[SupportedColors.LightBlue] = UIColor.convFromRGBValues(173, green: 216, blue: 230)
        RGBValuesOfSupportedColorsDict[SupportedColors.Plum] = UIColor.convFromRGBValues(221, green: 160, blue: 221)
        
        NamesOfSupportedColorsDict["Black"] = SupportedColors.Black
        NamesOfSupportedColorsDict["Sienna"] = SupportedColors.Sienna
        NamesOfSupportedColorsDict["DarkOliveGreen"] = SupportedColors.DarkOliveGreen
        NamesOfSupportedColorsDict["DarkGreen"] = SupportedColors.DarkGreen
        NamesOfSupportedColorsDict["DarkSlateBlue"] = SupportedColors.DarkSlateBlue
        NamesOfSupportedColorsDict["Navy"] = SupportedColors.Navy
        NamesOfSupportedColorsDict["Indigo"] = SupportedColors.Indigo
        NamesOfSupportedColorsDict["DarkSlateGray"] = SupportedColors.DarkSlateGray
        NamesOfSupportedColorsDict["DarkRed"] = SupportedColors.DarkRed
        NamesOfSupportedColorsDict["DarkOrange"]  = SupportedColors.DarkOrange
        NamesOfSupportedColorsDict["Olive"] = SupportedColors.Olive
        NamesOfSupportedColorsDict["Green"] = SupportedColors.Green
        NamesOfSupportedColorsDict["Teal"] = SupportedColors.Teal
        NamesOfSupportedColorsDict["Blue"] = SupportedColors.Blue
        NamesOfSupportedColorsDict["SlateGray"] = SupportedColors.SlateGray
        NamesOfSupportedColorsDict["DimGray"] = SupportedColors.DimGray
        NamesOfSupportedColorsDict["Red"] = SupportedColors.Red
        NamesOfSupportedColorsDict["SandyBrown"] = SupportedColors.SandyBrown
        NamesOfSupportedColorsDict["YellowGreen"] = SupportedColors.YellowGreen
        NamesOfSupportedColorsDict["MediumTurquoise"] = SupportedColors.MediumTurquoise
        NamesOfSupportedColorsDict["RoyalBlue"] = SupportedColors.RoyalBlue
        NamesOfSupportedColorsDict["Purple"] = SupportedColors.Purple
        NamesOfSupportedColorsDict["Gray"] = SupportedColors.Gray
        NamesOfSupportedColorsDict["Magenta"] = SupportedColors.Magenta
        NamesOfSupportedColorsDict["Orange"] = SupportedColors.Orange
        NamesOfSupportedColorsDict["Yellow"] = SupportedColors.Yellow
        NamesOfSupportedColorsDict["Lime"] = SupportedColors.Lime
        NamesOfSupportedColorsDict["Cyan"] = SupportedColors.Cyan
        NamesOfSupportedColorsDict["DeepSkyBlue"] = SupportedColors.DeepSkyBlue
        NamesOfSupportedColorsDict["DarkOrchid"] = SupportedColors.DarkOrchid
        NamesOfSupportedColorsDict["Silver"] = SupportedColors.Silver
        NamesOfSupportedColorsDict["Pink"] = SupportedColors.Pink
        NamesOfSupportedColorsDict["Wheat"] = SupportedColors.Wheat
        NamesOfSupportedColorsDict["LemonChiffon"] = SupportedColors.LemonChiffon
        NamesOfSupportedColorsDict["PaleGreen"] = SupportedColors.PaleGreen
        NamesOfSupportedColorsDict["PaleTurquoise"] = SupportedColors.PaleTurquoise
        NamesOfSupportedColorsDict["LightBlue"] = SupportedColors.LightBlue
        NamesOfSupportedColorsDict["Plum"] = SupportedColors.Plum
    }
    
    func convertColorName2SupportedColor(name: String) -> UIColor? {
        let color = NamesOfSupportedColorsDict[name]
        
        if color == nil {
            return nil
        }
        
        return RGBValuesOfSupportedColorsDict[color!]
        
    }
}

extension UIColor {
    static func convFromRGBValues(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
}