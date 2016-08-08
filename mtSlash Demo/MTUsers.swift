//
//  MTUsers.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/8/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import CoreData


class MTUsers: NSManagedObject {

    func setValuesOfUser(username: String, uid: Int, password: String, groupid: Int, email: String) {
        self.username = username
        self.uid = uid
        self.password = password
        self.groupid = groupid
        self.email = email
        self.ifActive = false
    }
    
}
