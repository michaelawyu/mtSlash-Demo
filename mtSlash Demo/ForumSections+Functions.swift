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
    
    static func getAvailabilityOfSubSections(sections: Sections) -> (Bool, String?, UIImage?, Bool, String?, UIImage?) {
        return (false, nil, nil, false, nil, nil)
    }
}