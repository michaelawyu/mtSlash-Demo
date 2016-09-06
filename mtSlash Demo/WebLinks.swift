//
//  WebLinks.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/16/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation

// URL for backend server
let backendServerURL : String = "http://mtslashmobileappdeploymenttestbed.southeastasia.cloudapp.azure.com:8000/"

// URL for Discuz Forum
let backendForumURL : String = "http://mtslashmobileappdeploymenttestbed.southeastasia.cloudapp.azure.com/bbs/"

enum WebLinks {
    // UCenter Avatar Profile Image Base URL
    case UCenterAvatarProfileImage
    // Server Status
    case ServerStatus
    // Registration
    case Registration
    // User Notice
    case UserNotice
    // Privacy Policy
    case PrivacyPolicy
    // User Authentication
    case UserAuthentication
    // What's New
    case WhatsNew
    // User Experience Improvement Project
    case UserExpImprovProj
    // Section Info
    case SectionInfo
    // Retrieval of Threads
    case RetrieveThreads
    // Retrieval of Posts
    case RetrievePosts
    // Sharing Threads
    case ShareThreads
    // Basic Search
    case BasicSearch
    
    // Function: Return corresponding URL for requested link
    static func getAddressOfWebLink (weblink: WebLinks) -> NSURL {
        switch weblink {
        case .ServerStatus:
                return NSURL(string: backendServerURL + "serverstatus")!
        case .Registration:
                return NSURL(string: backendServerURL + "registration")!
        case .PrivacyPolicy:
                return NSURL(string: backendServerURL + "privacypolicy")!
        case .UserNotice:
                return NSURL(string: backendServerURL + "usernotice")!
        case .UserAuthentication:
                return NSURL(string: backendServerURL + "userauthentication")!
        case .WhatsNew:
                return NSURL(string: backendServerURL + "whatsnew")!
        case .UserExpImprovProj:
                return NSURL(string: backendServerURL + "userexpimprovproj")!
        case .SectionInfo:
                return NSURL(string: backendServerURL + "sectioninfo")!
        case .RetrieveThreads:
                return NSURL(string: backendServerURL + "retrievethreads")!
        case .UCenterAvatarProfileImage:
                return NSURL(string: backendForumURL + "uc_server/avatar.php?")!
        case .RetrievePosts:
                return NSURL(string: backendServerURL + "retrieveposts")!
        case .ShareThreads:
                return NSURL(string: backendForumURL + "forum.php?mod=viewthread&tid=\(threadID!)")!
        case .BasicSearch:
                return NSURL(string: backendServerURL + "basicsearch")!
        }
    }
    
    // Function: Return the name(description) for requested link
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
        case .UserAuthentication:
            return "用户身份验证"
        case .WhatsNew:
            return "更新说明"
        case .UserExpImprovProj:
            return "用户体验改进计划"
        case .SectionInfo:
            return "板块基本信息"
        case .RetrieveThreads:
            return "返回主题列表"
        case .UCenterAvatarProfileImage:
            return "UCenter用户头像基本路径"
        case .RetrievePosts:
            return "返回帖子列表"
        case .ShareThreads:
            return "分享帖子"
        case .BasicSearch:
            return "基本搜索功能"
        }
    }
    
}