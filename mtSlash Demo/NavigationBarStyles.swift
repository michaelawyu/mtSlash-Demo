//
//  NavigationBarStyles.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/26/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.

import Foundation
import UIKit

class NavigationBarStylesInTopicsAndPostsViewScreen {
    enum availableStyles {
        case DarkStyle
        case LightStyle
        case TranslucentStyle
    }

    static func setStyleOfNavigationBarToLightStyle(navigationBar: UINavigationBar) {
        navigationBar.setBackgroundImage(UIImage.fromColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)), forBarMetrics: UIBarMetrics.Default)
        navigationBar.tintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
    }
    
    static func setStyleOfNavigationBarToDarkStyle(navigationBar: UINavigationBar) {
        navigationBar.setBackgroundImage(UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)), forBarMetrics: UIBarMetrics.Default)
        navigationBar.tintColor = UIColor.whiteColor()
    }
    
    static func setStyleOfNavigationBarToTranslucentStyle(navigationBar: UINavigationBar) {
        navigationBar.setBackgroundImage(UIImage.fromColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)), forBarMetrics: UIBarMetrics.Default)
        navigationBar.tintColor = UIColor.whiteColor()
    }
    
    static func getCurrentStyleOfNaviationBar(navigationItem: UINavigationItem) -> availableStyles {
        if navigationItem.title == "" || navigationItem.title == nil {
            return availableStyles.TranslucentStyle
        } else {
            return availableStyles.DarkStyle
        }
    }
}