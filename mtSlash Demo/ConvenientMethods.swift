//
//  ConvenientMethods.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/28/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ConvenientMethods {
    static func getDataControllerInAppDelegate() -> DefaultDataController {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).dataController
    }
}