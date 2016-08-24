//
//  ForumSections+AnotherGroupOfFunctions.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/23/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation

extension ForumSections {
    static func getListOfAvailableCategories(section: Sections) -> [(String, Int)] {
        switch section {
        case Sections.MovieFanfic_General:
            return [("全部", 2)]
        case Sections.MovieFanfic_Avengers_General_Reserved:
            return [("复仇者联盟", 7), ("钢铁侠", 8), ("雷神", 9), ("美国队长", 10), ("银河护卫队", 11), ("蚁人", 12), ("无敌浩克", 13)]
        case Sections.MovieFanfic_PopularFandoms_General_Reserved:
            return [("DC", 18), ("Inception", 19), ("TSN", 20), ("X-Men", 21), ("MI4", 22), ("ST", 23), ("007", 24), ("Tolkien", 25), ("Pacific Rim", 26), ("HP", 27), ("Spider-Man", 28), ("Kingsman", 29)]
        case Sections.TVFanfic_General:
            return [("全部", 34)]
        case Sections.TVFanfic_Sherlock_General_Reserved:
            return [("神探夏洛克", 38), ("原著小说向", 39), ("大侦探福尔摩斯", 40), ("基本演绎法", 41), ("Jeremy Brett版", 42), ("混合同人或其他", 43)]
        case Sections.TVFanfic_PopularFandoms_General_Reserved:
            return [("CSI", 47), ("Supernatrual", 48), ("NCIS", 49), ("Merlin", 50), ("Suits", 51), ("Common Law", 52), ("POI", 53), ("House", 54), ("Hannibal", 55), ("White Collar", 56), ("Teen Wolf", 57), ("H5O", 58), ("Doctor Who", 59)]
        case Sections.FanArt_General:
            return [("全部", 63)]
        case Sections.FanVid_General:
            return [("全部", 64), ("技术交流", 65), ("MV区活动", 66), ("填词翻唱", 67)]
        case Sections.FanBook_General:
            return [("全部", 68)]
        case Sections.FanBook_FleaMarket:
            return [("全部", 69)]
        case Sections.Discussion_General:
            return [("全部", 70)]
        case Sections.Song_General:
            return [("全部", 71)]
        case Sections.HelpCenter_General:
            return [("全部", 72)]
        case Sections.SecretGiftsInHolidaySeason_General_Reserved:
            return [("TV Fanfic", 75), ("Movie Fanfic", 76), ("Others", 77)]
        case Sections.GiftsInThePast_Others:
            return [("TV Fanfic", 79), ("Movie Fanfic", 80), ("Others", 81)]
        default:
            return []
        }
        //return []
    }
    
    static func getTitlesAndNotesOfCurrentSubSection(section: Sections) -> [String] {
        //[Name(Title) of the Section (EN), Name(Subtitle) of the Section (CH), Note of the Section]
        switch section {
        case Sections.MovieFanfic_General:
            return ["MOVIE FANFIC", "欧美电影同人区", ""]
        case Sections.MovieFanfic_Avengers_General_Reserved:
            return ["MOVIE FANFIC", "欧美电影同人区", "复仇者联盟专区"]
        case Sections.MovieFanfic_PopularFandoms_General_Reserved:
            return ["MOVIE FANFIC", "欧美电影同人区", "热门同人区"]
        case Sections.TVFanfic_General:
            return ["TV FANFIC", "欧美电视剧同人区", ""]
        case Sections.TVFanfic_Sherlock_General_Reserved:
            return ["TV FANFIC", "欧美电视剧同人区", "福尔摩斯同人专区"]
        case Sections.TVFanfic_PopularFandoms_General_Reserved:
            return ["TV FANFIC", "欧美电视剧同人区", "热门同人区"]
        case Sections.FanArt_General:
            return ["FANART", "欧美影视同人图区", ""]
        case Sections.FanVid_General:
            return ["FANVID", "欧美影视同人MV区", ""]
        case Sections.FanBook_General:
            return ["FANBOOK", "同人志宣传交流区", ""]
        case Sections.FanBook_FleaMarket:
            return ["FANBOOK", "同人志宣传交流区", "求本转本区"]
        case Sections.Discussion_General:
            return ["DISCUSSION", "讨论区", ""]
        case Sections.Song_General:
            return ["SONG", "音乐区", ""]
        case Sections.HelpCenter_General:
            return ["HELP CENTER", "求助区", ""]
        case Sections.SecretGiftsInHolidaySeason_General_Reserved:
            return ["SECRET GIFTS IN HOLIDAY SEASON", "新年神秘礼物季", ""]
        case Sections.GiftsInThePast_General_Reserved:
            return ["SECRET GIFTS IN HOLIDAY SEASON", "新年神秘礼物季", "历年礼物储藏处"]
        default:
            return []
        }
        //return []
    }
    
}