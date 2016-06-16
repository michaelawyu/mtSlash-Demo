//
//  WebLinks.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/16/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation

enum WebLinks {
    case ServerStatus
    case Registration
    case UserNotice
    case PrivacyPolicy
    
    static func getAddressOfWebLink (weblink: WebLinks) -> NSURL {
        switch weblink {
        case .ServerStatus:
                return NSURL(string: "http://52.175.20.188:8000/serverstatus")!
        case .Registration:
                return NSURL(string: "http://52.175.20.188:8000/registration")!
        case .PrivacyPolicy:
                return NSURL(string: "http://52.175.20.188:8000/privacypolicy")!
        case .UserNotice:
                return NSURL(string: "http://52.175.20.188:8000/usernotice")!
        }
    }
    
    static func getNameOfWebLink (weblink: WebLinks) -> String {
        switch weblink {
        case .ServerStatus:
            return "服务器状态"
        case .Registration:
            return "注册新账号"
        case .PrivacyPolicy:
            return "隐私保护声明"
        case .UserNotice:
            return "使用须知"
        }
    }
    
}