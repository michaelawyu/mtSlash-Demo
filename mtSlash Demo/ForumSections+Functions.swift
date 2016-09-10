//
//  ForumSections+Functions.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/18/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit

extension ForumSections {
    // format: (forum id, content id)
    // forum id -1 is reserved
    // content id -1 is reserved
    static func convertInAppSectionDef2WebEndSectionNumber(inAppSection: Sections) -> (Int, Int) {
        switch inAppSection {
        case Sections.General_Reserved:
            return (-1,-1)
        case Sections.MovieFanfic_General:
            return (2,-1)
        case Sections.MovieFanfic_Avengers_General_Reserved:
            return (37,-1)
        case Sections.MovieFanfic_Avengers_Avengers:
            return (37,4)
        case Sections.MovieFanfic_Avengers_Ironman:
            return (37,5)
        case Sections.MovieFanfic_Avengers_Thor:
            return (37,6)
        case Sections.MovieFanfic_Avengers_CaptainAmerica:
            return (37,7)
        case Sections.MovieFanfic_Avengers_GuardiansOfTheGalaxy:
            return (37,8)
        case Sections.MovieFanfic_Avengers_Antman:
            return (37,9)
        case Sections.MovieFanfic_Avengers_TheIncredibleHulk:
            return (37,10)
        case Sections.MovieFanfic_PopularFandoms_General_Reserved:
            return (38,-1)
        case Sections.MovieFanfic_PopularFandoms_DCUniverse:
            return (38,11)
        case Sections.MovieFanfic_PopularFandoms_Inception:
            return (38,12)
        case Sections.MovieFanfic_PopularFandoms_TheSocialNetwork:
            return (38,13)
        case Sections.MovieFanfic_PopularFandoms_XMen:
            return (38,14)
        case Sections.MovieFanfic_PopularFandoms_MissionImpossible:
            return (38,15)
        case Sections.MovieFanfic_PopularFandoms_StarTrekUniverse:
            return (38,16)
        case Sections.MovieFanfic_PopularFandoms_007Series:
            return (38,17)
        case Sections.MovieFanfic_PopularFandoms_TolkienUniverse:
            return (38,18)
        case Sections.MovieFanfic_PopularFandoms_PacificRim:
            return (38,19)
        case Sections.MovieFanfic_PopularFandoms_HarryPotter:
            return (38,20)
        case Sections.MovieFanfic_PopularFandoms_SpiderMan:
            return (38,21)
        case Sections.MovieFanfic_PopularFandoms_Kingsman:
            return (38,22)
        case Sections.MovieFanfic_PopularFandoms_LesMiserables:
            return (38,23)
        case Sections.TVFanfic_General:
            return (36,-1)
        case Sections.TVFanfic_Sherlock_General_Reserved:
            return (50,-1)
        case Sections.TVFanfic_Sherlock_SherlockTVSeries2012:
            return (50,27)
        case Sections.TVFanfic_Sherlock_SherlockHolmesCollection:
            return (50,28)
        case Sections.TVFanfic_Sherlock_SherlockHolmesFilmSeries:
            return (50,29)
        case Sections.TVFanfic_Sherlock_ElementaryTVSeries2012:
            return (50,30)
        case Sections.TVFanfic_Sherlock_SherlockHolmesTVSeries1984:
            return (50,31)
        case Sections.TVFanfic_Sherlock_Crossovers:
            return (50,32)
        case Sections.TVFanfic_PopularFandoms_General_Reserved:
            return (49,-1)
        case Sections.TVFanfic_PopularFandoms_CSISeries:
            return (49,33)
        case Sections.TVFanfic_PopularFandoms_Supernatural:
            return (49,34)
        case Sections.TVFanfic_PopularFandoms_NCIS:
            return (49,35)
        case Sections.TVFanfic_PopularFandoms_Merlin:
            return (49,36)
        case Sections.TVFanfic_PopularFandoms_Suits:
            return (49,37)
        case Sections.TVFanfic_PopularFandoms_CommonLaw:
            return (49,38)
        case Sections.TVFanfic_PopularFandoms_POI:
            return (49,39)
        case Sections.TVFanfic_PopularFandoms_House:
            return (49,40)
        case Sections.TVFanfic_PopularFandoms_Hannibal:
            return (49,41)
        case Sections.TVFanfic_PopularFandoms_WhiteCollar:
            return (49,42)
        case Sections.TVFanfic_PopularFandoms_TeenWolf:
            return (49,43)
        case Sections.TVFanfic_PopularFandoms_H5O:
            return (49,44)
        case Sections.TVFanfic_PopularFandoms_DoctorWho:
            return (49,45)
        case Sections.FanArt_General:
            return (42,-1)
        case Sections.FanVid_General:
            return (43,-1)
        case Sections.FanVid_TenicalIssues:
            return (43,46)
        case Sections.FanVid_SpecialEvents:
            return (43,47)
        case Sections.FanVid_CoverVersions:
            return (43,48)
        case Sections.FanBook_General:
            return (44,-1)
        case Sections.FanBook_FleaMarket:
            return (51,-1)
        case Sections.Discussion_General:
            return (45,-1)
        case Sections.Song_General:
            return (46,-1)
        case Sections.HelpCenter_General:
            return (47,-1)
        case Sections.SecretGiftsInHolidaySeason_General_Reserved:
            return (41,-1)
        case Sections.SecretGiftsInHolidaySeason_TVFanfic:
            return (41,51)
        case Sections.SecretGiftsInHolidaySeason_MovieFanfic:
            return (41,52)
        case Sections.SecretGiftsInHolidaySeason_Others:
            return (41,53)
        case Sections.GiftsInThePast_General_Reserved:
            return (48,-1)
        case Sections.GiftsInThePast_TVFanfic:
            return (48,54)
        case Sections.GiftsInThePast_MovieFanfic:
            return (48,55)
        case Sections.GiftsInThePast_Others:
            return (48,56)
        default:
            return (-1,-1)
        }
        //return (0,0)
    }
    
    static func convertWebEndSectionNumber2InAppSectionDef(webEndSectionNumber: (Int, Int)) -> Sections {
        switch webEndSectionNumber {
        case (-1,-1):
            return Sections.General_Reserved
        case (2,-1):
            return Sections.MovieFanfic_General
        case (37,-1):
            return Sections.MovieFanfic_Avengers_General_Reserved
        case (37,4):
            return Sections.MovieFanfic_Avengers_Avengers
        case (37,5):
            return Sections.MovieFanfic_Avengers_Ironman
        case (37,6):
            return Sections.MovieFanfic_Avengers_Thor
        case (37,7):
            return Sections.MovieFanfic_Avengers_CaptainAmerica
        case (37,8):
            return Sections.MovieFanfic_Avengers_GuardiansOfTheGalaxy
        case (37,9):
            return Sections.MovieFanfic_Avengers_Antman
        case (37,10):
            return Sections.MovieFanfic_Avengers_TheIncredibleHulk
        case (38,-1):
            return Sections.MovieFanfic_PopularFandoms_General_Reserved
        case (38,11):
            return Sections.MovieFanfic_PopularFandoms_DCUniverse
        case (38,12):
            return Sections.MovieFanfic_PopularFandoms_Inception
        case (38,13):
            return Sections.MovieFanfic_PopularFandoms_TheSocialNetwork
        case (38,14):
            return Sections.MovieFanfic_PopularFandoms_XMen
        case (38,15):
            return Sections.MovieFanfic_PopularFandoms_MissionImpossible
        case (38,16):
            return Sections.MovieFanfic_PopularFandoms_StarTrekUniverse
        case (38,17):
            return Sections.MovieFanfic_PopularFandoms_007Series
        case (38,18):
            return Sections.MovieFanfic_PopularFandoms_TolkienUniverse
        case (38,19):
            return Sections.MovieFanfic_PopularFandoms_PacificRim
        case (38,20):
            return Sections.MovieFanfic_PopularFandoms_HarryPotter
        case (38,21):
            return Sections.MovieFanfic_PopularFandoms_SpiderMan
        case (38,22):
            return Sections.MovieFanfic_PopularFandoms_Kingsman
        case (38,23):
            return Sections.MovieFanfic_PopularFandoms_LesMiserables
        case (36,-1):
            return Sections.TVFanfic_General
        case (50,-1):
            return Sections.TVFanfic_Sherlock_General_Reserved
        case (50,27):
            return Sections.TVFanfic_Sherlock_SherlockTVSeries2012
        case (50,28):
            return Sections.TVFanfic_Sherlock_SherlockHolmesCollection
        case (50,29):
            return Sections.TVFanfic_Sherlock_SherlockHolmesFilmSeries
        case (50,30):
            return Sections.TVFanfic_Sherlock_ElementaryTVSeries2012
        case (50,31):
            return Sections.TVFanfic_Sherlock_SherlockHolmesTVSeries1984
        case (50,32):
            return Sections.TVFanfic_Sherlock_Crossovers
        case (49,-1):
            return Sections.TVFanfic_PopularFandoms_General_Reserved
        case (49,33):
            return Sections.TVFanfic_PopularFandoms_CSISeries
        case (49,34):
            return Sections.TVFanfic_PopularFandoms_Supernatural
        case (49,35):
            return Sections.TVFanfic_PopularFandoms_NCIS
        case (49,36):
            return Sections.TVFanfic_PopularFandoms_Merlin
        case (49,37):
            return Sections.TVFanfic_PopularFandoms_Suits
        case (49,38):
            return Sections.TVFanfic_PopularFandoms_CommonLaw
        case (49,39):
            return Sections.TVFanfic_PopularFandoms_POI
        case (49,40):
            return Sections.TVFanfic_PopularFandoms_House
        case (49,41):
            return Sections.TVFanfic_PopularFandoms_Hannibal
        case (49,42):
            return Sections.TVFanfic_PopularFandoms_WhiteCollar
        case (49,43):
            return Sections.TVFanfic_PopularFandoms_TeenWolf
        case (49,44):
            return Sections.TVFanfic_PopularFandoms_H5O
        case (49,45):
            return Sections.TVFanfic_PopularFandoms_DoctorWho
        case (42,-1):
            return Sections.FanArt_General
        case (43,-1):
            return Sections.FanVid_General
        case (43,46):
            return Sections.FanVid_TenicalIssues
        case (43,47):
            return Sections.FanVid_SpecialEvents
        case (43,48):
            return Sections.FanVid_CoverVersions
        case (44,-1):
            return Sections.FanBook_General
        case (51,-1):
            return Sections.FanBook_FleaMarket
        case (45,-1):
            return Sections.Discussion_General
        case (46,-1):
            return Sections.Song_General
        case (47,-1):
            return Sections.HelpCenter_General
        case (41,-1):
            return Sections.SecretGiftsInHolidaySeason_General_Reserved
        case (41,51):
            return Sections.SecretGiftsInHolidaySeason_TVFanfic
        case (41,52):
            return Sections.SecretGiftsInHolidaySeason_MovieFanfic
        case (41,53):
            return Sections.SecretGiftsInHolidaySeason_Others
        case (48,-1):
            return Sections.GiftsInThePast_General_Reserved
        case (48,54):
            return Sections.GiftsInThePast_TVFanfic
        case (48,55):
            return Sections.GiftsInThePast_MovieFanfic
        case (48,56):
            return Sections.GiftsInThePast_Others
        default:
            return Sections.General_Reserved
        }
    }
    
    static func getAvailabilityOfSubSections(section: Sections) -> (String?, String?, Bool, String?, Int?, UIImage?, Bool, String?, Int?, UIImage?) {
        //format: (introOfCurrentSubSection, ifHaveFirstSubSection, nameOfFirstSubSection, refOfFirstSubSection, logoOfFirstSubSection, ifHaveSecondSubSection, nameOfSecondSubSection, refOfSecondSubSection, logoOfSecondSubSection)
        switch section {
        case Sections.MovieFanfic_General:
            let firstSubSectionImagePath = NSBundle.mainBundle().pathForResource("AvengersIcon(Large)", ofType: "png")
            let firstSubSectionImage = UIImage(named: firstSubSectionImagePath!)!
            let secondSubSectionImagePath = NSBundle.mainBundle().pathForResource("PopularFandomsIcon(Large)", ofType: "png")
            let secondSubSectionImage = UIImage(named: secondSubSectionImagePath!)!
            return ("欧美电影同人区", "欢迎各类电影相关同人文，涵盖小说、动漫、音乐剧等杂类", true, "复仇者联盟专区", 6, firstSubSectionImage, true, "热门同人区", 17 ,secondSubSectionImage)
        case Sections.TVFanfic_General:
            let firstSubSectionImagePath = NSBundle.mainBundle().pathForResource("SherlockHolmesIcon(Large)", ofType: "png")
            let firstSubSectionImage = UIImage(named: firstSubSectionImagePath!)!
            let secondSubSectionImagePath = NSBundle.mainBundle().pathForResource("PopularFandomsIcon(Large)", ofType: "png")
            let secondSubSectionImage = UIImage(named: secondSubSectionImagePath!)!
            return ("欧美电视剧同人区", "欢迎各类电视剧相关同人文", true, "福尔摩斯专区", 83, firstSubSectionImage, true, "热门同人区", 82, secondSubSectionImage)
        case Sections.FanBook_General:
            let firstSubSectionImagePath = NSBundle.mainBundle().pathForResource("FleaMarketIcon(Large)", ofType: "png")
            let firstSubSectionImage = UIImage(named: firstSubSectionImagePath!)!
            return ("同人志区", "同人志宣传、交流区", true, "求本转本专区", 69, firstSubSectionImage, false, nil, nil, nil)
        case Sections.SecretGiftsInHolidaySeason_General_Reserved:
            let firstSubSectionImagePath = NSBundle.mainBundle().pathForResource("GiftsInThePastIcon(Large)", ofType: "png")
            let firstSubSectionImage = UIImage(named: firstSubSectionImagePath!)!
            return ("新年神秘礼物季", "跨年版庆活动", true, "历年礼物储藏处", 78, firstSubSectionImage, false, nil, nil, nil)
        case Sections.FanArt_General:
            return ("欧美影视同人图区", "支持各种同人性质的图片创作，欢迎自创作品或推荐其他作品", false, nil, nil, nil, false, nil, nil, nil)
        case Sections.FanVid_General:
            return ("欧美影视同人MV区", "支持各种原创MV创作或推荐其他MV，希望玩视频剪辑的人会越来越多", false, nil, nil, nil, false, nil, nil, nil)
        case Sections.Discussion_General:
            return ("讨论区", "灌水、花痴，萌字第一！请随心所欲的玩耍吧！", false, nil, nil, nil, false, nil, nil, nil)
        case Sections.Song_General:
            return ("音乐区", "分享旋律起伏带来的快乐", false, nil, nil, nil, false, nil, nil, nil)
        case Sections.HelpCenter_General:
            return ("求助区", "寻文、求资源、找帮助，当使用搜索无能时，来这里求助", false, nil, nil, nil, false, nil, nil, nil)
        default:
            return (nil, nil, false, nil, nil, nil, false, nil, nil, nil)
        }
        //return (nil, false, nil, nil, nil, false, nil, nil, nil)
    }
}