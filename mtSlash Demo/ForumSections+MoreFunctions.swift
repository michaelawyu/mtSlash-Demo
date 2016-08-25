//
//  ForumSections+MoreFunctions.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/19/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit

extension ForumSections {
    static func getSectionBackgroundImageOfGivenSection(section: Sections) -> UIImage {
        
        if section == Sections.MovieFanfic_General {
            // Background images (8) reserved for MovieFanfic_General and its sub-sections:
            // Avengers, DC Universe, The Social Network, X-Men, Star Trek Universe, 007 Series, Tolkien Universe, Kingsman
            
            let randomRefNumberForBackgroundImage = arc4random_uniform(8)
            
            switch randomRefNumberForBackgroundImage {
            case 0:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("avengersDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 1:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("dcUniverseDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 2:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("theSocialNetworkDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 3:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("xMenDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 4:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("starTrekDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 5:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("007SeriesDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 6:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("tolkienUniverseDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 7:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("kingsmanDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            default:
                return UIImage()
            }
        }
        
        if section == Sections.TVFanfic_General {
            // Background images (8) reserved for TVFanfic_General and its sub-sections:
            // Sherlock, Supernatural, NCIS, Merlin, POI, House, Hannibal, Doctor Who
            
            let randomRefNumberForBackgroundImage = arc4random_uniform(8)
            
            switch randomRefNumberForBackgroundImage {
            case 0:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("sherlockDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 1:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("supernaturalDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 2:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("ncisDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 3:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("merlinDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 4:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("poiDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 5:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("houseDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 6:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("hannibalDiscoverScreenBackground", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            case 7:
                let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("doctorWhoDiscoverScreenBackground.prototype", ofType: "jpg")
                return UIImage(named: sectionBackgroundImagePath!)!
            default:
                return UIImage()
            }
        }
        
        let randomRefNumberForBackgroundImage = arc4random_uniform(12)
        
        // Background images (12) reserved for other sections
        // excluding Avengers, DC Universe, The Social Network, X-Men, Star Trek Universe, 007 Series, Tolkien Universe, Kingsman
        // excluding Sherlock, Supernatural, NCIS, Merlin, POI, House, Hannibal, Doctor Who
        switch randomRefNumberForBackgroundImage {
        case 0:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("inceptionDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 1:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("missionImpossibleWhoDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 2:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("pacificRimDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 3:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("harryPotterDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 4:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("spiderManDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 5:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("lesMiserablesDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 6:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("teenWolfDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 7:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("hawaiiFiveODiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 8:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("whiteCollarDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 9:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("commonLawDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 10:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("suitsDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 11:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("csiSeriesDiscoverScreenBackground.prototype", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        default:
            return UIImage()
        }
        
        //return UIImage()
    }
    
    static func getPanelBackgroundInUpperRegionOfTopicsViewScreen() -> UIImage {
        let randomRefNumberForBackgroundImage = arc4random_uniform(5)
        
        switch randomRefNumberForBackgroundImage {
        case 0:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("sampleBackground_Circles", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 1:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("sampleBackground_IrregularShapes", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 2:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("sampleBackground_Triangles", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 3:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("sampleBackground_Pentagons", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        case 4:
            let sectionBackgroundImagePath = NSBundle.mainBundle().pathForResource("sampleBackground_Hexagons", ofType: "jpg")
            return UIImage(named: sectionBackgroundImagePath!)!
        default:
            return UIImage()
        }
        //return UIImage()
    }
}