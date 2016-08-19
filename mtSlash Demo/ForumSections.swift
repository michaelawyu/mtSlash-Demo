//
//  ForumSections.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/15/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit

class ForumSections {
    
    enum Sections : Int {
        case Unavailable = 0
        case General_Reserved = 1
        case MovieFanfic_General = 2
        case MovieFanfic_OriginalWork_NotUsed = 3
        case MovieFanfic_Translation_NotUsed = 4
        case MovieFanfic_Reprint_NotUsed = 5
        case MovieFanfic_Avengers_General_Reserved = 6
        case MovieFanfic_Avengers_Avengers = 7
        case MovieFanfic_Avengers_Ironman = 8
        case MovieFanfic_Avengers_Thor = 9
        case MovieFanfic_Avengers_CaptainAmerica = 10
        case MovieFanfic_Avengers_GuardiansOfTheGalaxy = 11
        case MovieFanfic_Avengers_Antman = 12
        case MovieFanfic_Avengers_TheIncredibleHulk = 13
        case MovieFanfic_Avengers_OriginalWork_NotUsed = 14
        case MovieFanfic_Avengers_Translation_NotUsed = 15
        case MovieFanfic_Avengers_Reprint_NotUsed = 16
        case MovieFanfic_PopularFandoms_General_Reserved = 17
        case MovieFanfic_PopularFandoms_DCUniverse = 18
        case MovieFanfic_PopularFandoms_Inception = 19
        case MovieFanfic_PopularFandoms_TheSocialNetwork = 20
        case MovieFanfic_PopularFandoms_XMen = 21
        case MovieFanfic_PopularFandoms_MissionImpossible = 22
        case MovieFanfic_PopularFandoms_StarTrekUniverse = 23
        case MovieFanfic_PopularFandoms_007Series = 24
        case MovieFanfic_PopularFandoms_TolkienUniverse = 25
        case MovieFanfic_PopularFandoms_PacificRim = 26
        case MovieFanfic_PopularFandoms_HarryPotter = 27
        case MovieFanfic_PopularFandoms_SpiderMan = 28
        case MovieFanfic_PopularFandoms_Kingsman = 29
        case MovieFanfic_PopularFandoms_LesMiserables = 30
        case MovieFanfic_PopularFandoms_OriginalWork_NotUsed = 31
        case MovieFanfic_PopularFandoms_Translation_NotUsed = 32
        case MovieFanfic_PopularFandoms_Reprint_NotUsed = 33
        case TVFanfic_General = 34
        case TVFanfic_OriginalWork_NotUsed = 35
        case TVFanfic_Translation_NotUsed = 36
        case TVFanfic_Reprint_NotUsed = 37
        case TVFanfic_Sherlock_General_Reserved = 83
        case TVFanfic_Sherlock_SherlockTVSeries2012 = 38
        case TVFanfic_Sherlock_SherlockHolmesCollection = 39
        case TVFanfic_Sherlock_SherlockHolmesFilmSeries = 40
        case TVFanfic_Sherlock_ElementaryTVSeries2012 = 41
        case TVFanfic_Sherlock_SherlockHolmesTVSeries1984 = 42
        case TVFanfic_Sherlock_Crossovers = 43
        case TVFanfic_Sherlock_OriginalWork_NotUsed = 44
        case TVFanfic_Sherlock_Translation_NotUsed = 45
        case TVFanfic_Sherlock_Reprint_NotUsed = 46
        case TVFanfic_PopularFandoms_CSISeries = 47
        case TVFanfic_PopularFandoms_Supernatural = 48
        case TVFanfic_PopularFandoms_NCIS = 49
        case TVFanfic_PopularFandoms_Merlin = 50
        case TVFanfic_PopularFandoms_Suits = 51
        case TVFanfic_PopularFandoms_CommonLaw = 52
        case TVFanfic_PopularFandoms_POI = 53
        case TVFanfic_PopularFandoms_House = 54
        case TVFanfic_PopularFandoms_Hannibal = 55
        case TVFanfic_PopularFandoms_WhiteCollar = 56
        case TVFanfic_PopularFandoms_TeenWolf = 57
        case TVFanfic_PopularFandoms_H5O = 58
        case TVFanfic_PopularFandoms_DoctorWho = 59
        case TVFanfic_PopularFandoms_OriginalWork_NotUsed = 60
        case TVFanfic_PopularFandoms_Translation_NotUsed = 61
        case TVFanfic_PopularFandoms_Reprint_NotUsed = 62
        case TVFanfic_PopularFandoms_General_Reserved = 82
        case FanArt_General = 63
        case FanVid_General = 64
        case FanVid_TenicalIssues = 65
        case FanVid_SpecialEvents = 66
        case FanVid_CoverVersions = 67
        case FanBook_General = 68
        case FanBook_FleaMarket = 69
        case Discussion_General = 70
        case Song_General = 71
        case HelpCenter_General = 72
        case CheckIn_General = 73
        case SecretGiftsInHolidaySeason_General_Reserved = 74
        case SecretGiftsInHolidaySeason_TVFanfic = 75
        case SecretGiftsInHolidaySeason_MovieFanfic = 76
        case SecretGiftsInHolidaySeason_Others = 77
        case GiftsInThePast_General_Reserved = 78
        case GiftsInThePast_TVFanfic = 79
        case GiftsInThePast_MovieFanfic = 80
        case GiftsInThePast_Others = 81
        case PopularFandomsInBothMovieFanficAndTVFanfic_General_Reserved = 84
    }
    
    static func getPanelBackgroundImageOfGivenSection(section: Sections) -> UIImage {
        switch section {
        case Sections.General_Reserved:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("GeneralPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_General:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("GeneralPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_Avengers_Avengers:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("AvengersPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_Avengers_Ironman:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("IronmanPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_Avengers_Thor:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("ThorPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_Avengers_CaptainAmerica:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("CaptainAmericPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_Avengers_GuardiansOfTheGalaxy:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("GuardiansOfTheGalaxyPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_Avengers_Antman:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("AntmanPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_Avengers_TheIncredibleHulk:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("TheIncredibleHulkPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_DCUniverse:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("DCUniversePanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_Inception:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("InceptionPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_TheSocialNetwork:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("TheSocialNetworkPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_XMen:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("XMenPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_MissionImpossible:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("MissionImpossiblePanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_StarTrekUniverse:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("StarTrekUniversePanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_007Series:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("007SeriesPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_TolkienUniverse:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("TolkienUniversePanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_PacificRim:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("PacificRimPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_HarryPotter:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("HarryPotterPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_SpiderMan:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("SpiderManPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_Kingsman:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("KingsmanPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.MovieFanfic_PopularFandoms_LesMiserables:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("LesMiserablesPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_General:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("GeneralPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_Sherlock_SherlockTVSeries2012:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("SherlockTVSeries2012PanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_Sherlock_SherlockHolmesCollection:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("SherlockHolmesCollectionPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_Sherlock_SherlockHolmesFilmSeries:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("SherlockHolmesFilmSeriesPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_Sherlock_ElementaryTVSeries2012:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("ElementaryTVSeries2012PanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_Sherlock_SherlockHolmesTVSeries1984:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("SherlockHolmesTVSeries1984PanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_Sherlock_Crossovers:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("GeneralPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_CSISeries:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("CSISeriesPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_Supernatural:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("SupernaturalPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_NCIS:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("NCISPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_Merlin:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("MerlinPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_Suits:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("SuitsPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_CommonLaw:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("CommonLawPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_POI:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("POIPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_House:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("HousePanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_Hannibal:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("HannibalPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_WhiteCollar:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("WhiteCollarPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_TeenWolf:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("TeenWolfPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_H5O:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("H5OPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        case Sections.TVFanfic_PopularFandoms_DoctorWho:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("DoctorWhoPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        default:
            let panelBackgroundImagePath = NSBundle.mainBundle().pathForResource("GeneralPanelBackground.prototype", ofType: "jpg")
            return UIImage(named: panelBackgroundImagePath!)!
        }
    }
}