//
//  HomeScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/20/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit
import CoreData

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var samplePanel: homePageShowcasePanel!
    @IBOutlet weak var showcase: homePageShowcase!
    @IBOutlet weak var monthAndDayLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var centerPanel : homePageShowcasePanel!
    var leftPanel : homePageShowcasePanel!
    var rightPanel : homePageShowcasePanel!
    
    var fetchedReadingListItems : [MTReadingList] = []
    var currentReadingListPt : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let showcaseWidthAfterInitialization = self.view.frame.width + 5.0
        
        // Get the reading list contents from data model (as described in Data Model group).
        // Wait until the framework is initialized.
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController : DefaultDataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Set up fetch request
        let readingListItemsFetchRequest = NSFetchRequest(entityName: "MTReadingList")
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        let predicateForFetchingSpecificReadingListWithAllItems = NSPredicate(format: "(belongTo == %@)", argumentArray: [currentUser])
        readingListItemsFetchRequest.predicate = predicateForFetchingSpecificReadingListWithAllItems
        var readingListItems : [MTReadingList]? = nil
        
        // Fetch user-specific reading list from the data framework
        do {
            readingListItems = try managedObjectContextInUse.executeFetchRequest(readingListItemsFetchRequest) as? [MTReadingList]
        } catch {
            fatalError("An error has occurred: Failed to fetch reading list items from the database.")
        }
        
        // Append default items to the reading list when it is empty
        if readingListItems!.count == 0 {
            Initialization.incorporateDefaultReadingList(dataController, user: currentUser)
            
            // Reload the reading list
            do {
                readingListItemsFetchRequest.predicate = predicateForFetchingSpecificReadingListWithAllItems
                readingListItems = try managedObjectContextInUse.executeFetchRequest(readingListItemsFetchRequest) as? [MTReadingList]
            } catch {
                fatalError("An error has occurred: Failed to fetch reading list items from the database.")
            }
        }
        
        // Sort the reading list by time added and then expose it
        let timeAddedSortDescriptor : NSSortDescriptor = NSSortDescriptor(key: "timeAdded", ascending: false)
        let sortedReadingListItems = NSArray(array: readingListItems!).sortedArrayUsingDescriptors([timeAddedSortDescriptor])
        fetchedReadingListItems = sortedReadingListItems as! [MTReadingList]

        // Set up the gesture recognizer
        let rightToLeftSwipeGestureRecognizerInShowcaseView = UISwipeGestureRecognizer(target: self, action: #selector(self.rightToLeftSwipedInShowcaseView))
        rightToLeftSwipeGestureRecognizerInShowcaseView.direction = UISwipeGestureRecognizerDirection.Left
        showcase.addGestureRecognizer(rightToLeftSwipeGestureRecognizerInShowcaseView)
        
        let leftToRightSwipeGestureRecognizerInShowcaseView = UISwipeGestureRecognizer(target: self, action: #selector(self.leftToRightSwipedInShowcaseView))
        leftToRightSwipeGestureRecognizerInShowcaseView.direction = UISwipeGestureRecognizerDirection.Right
        showcase.addGestureRecognizer(leftToRightSwipeGestureRecognizerInShowcaseView)
        
        // Initialize the panels in homePageShowcase
        // Note: centerPanel is already initialized in IB
        centerPanel = samplePanel
        
        leftPanel = homePageShowcasePanel(frame: CGRect(x: 0.0, y: 0.0, width: showcaseWidthAfterInitialization - 60.0, height: showcase.frame.height))
        leftPanel.alpha = 0.0
        showcase.addSubview(leftPanel)
        showcase.setConstraintsForLeftPanel(leftPanel, showcaseWidth: showcaseWidthAfterInitialization)
        
        rightPanel = homePageShowcasePanel(frame: CGRect(x: 0.0, y: 0.0, width: showcaseWidthAfterInitialization - 60.0, height: showcase.frame.height))
        if fetchedReadingListItems.count > 1 {
            rightPanel.alpha = 0.1
        } else {
            rightPanel.alpha = 0.0
        }
        showcase.addSubview(rightPanel)
        showcase.setConstraintsForRightPanel(rightPanel, showcaseWidth: showcaseWidthAfterInitialization)
        
        // Set the background image, title and last updated time in panels
        // Note: Consider reconstructing the code for better clarity
        let sectionOfCenteredItem = ForumSections.Sections(rawValue: fetchedReadingListItems[currentReadingListPt].category!.longValue)!
        let backgroundImageOfCenteredItem = ForumSections.getPanelBackgroundImageOfGivenSection(sectionOfCenteredItem)
        let titleOfCenteredItem = fetchedReadingListItems[currentReadingListPt].title!
        let lastUpdatedTimeOfCenteredItem = fetchedReadingListItems[currentReadingListPt].timeAdded!
        let baseCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let numberOfDaysAfterLastUpdatedTimeOfCenteredItemInComponent = baseCalendar.components(NSCalendarUnit.Day, fromDate: lastUpdatedTimeOfCenteredItem, toDate: NSDate(), options: NSCalendarOptions())
        let numberOfDaysAfterLastUpdatedTimeOfCenteredItem = numberOfDaysAfterLastUpdatedTimeOfCenteredItemInComponent.day
        let lastUpdatedTimeOfCenteredItemInString = "上次更新于\(numberOfDaysAfterLastUpdatedTimeOfCenteredItem)天前"
        
        centerPanel.setUpContentsInPanel(backgroundImageOfCenteredItem, updateLabelContent: lastUpdatedTimeOfCenteredItemInString, itemTitleContent: titleOfCenteredItem)
        
        if fetchedReadingListItems.count > 0 {
            let sectionOfRightItem = ForumSections.Sections(rawValue: fetchedReadingListItems[currentReadingListPt + 1].category!.longValue)!
            let backgroundImageOfRightItem = ForumSections.getPanelBackgroundImageOfGivenSection(sectionOfRightItem)
            let titleOfRightItem = fetchedReadingListItems[currentReadingListPt + 1].title!
            let lastUpdatedTimeOfRightItem = fetchedReadingListItems[currentReadingListPt + 1].timeAdded!
            let numberOfDaysAfterLastUpdatedTimeOfRightItemInComponent = baseCalendar.components(NSCalendarUnit.Day, fromDate: lastUpdatedTimeOfRightItem, toDate: NSDate(), options: NSCalendarOptions())
            let numberOfDaysAfterLastUpdatedTimeOfRightItem = numberOfDaysAfterLastUpdatedTimeOfRightItemInComponent.day
            let lastUpdatedTimeOfRightItemInString = "上次更新于\(numberOfDaysAfterLastUpdatedTimeOfRightItem)天前"
            
            rightPanel.setUpContentsInPanel(backgroundImageOfRightItem, updateLabelContent: lastUpdatedTimeOfRightItemInString, itemTitleContent: titleOfRightItem)
        }
        
        // Update the time label
        // Note: Consider reconstructing the code for better clarity
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        let monthOnlyDateFormat = NSDateFormatter.dateFormatFromTemplate("MMMM", options: 0, locale: nil)
        let dayOnlyDateFormat = NSDateFormatter.dateFormatFromTemplate("dd", options: 0, locale: nil)
        let yearOnlyDateFormate = NSDateFormatter.dateFormatFromTemplate("YYYY", options: 0, locale: nil)
        
        dateFormatter.dateFormat = monthOnlyDateFormat
        let monthInString = dateFormatter.stringFromDate(currentDate)
        
        dateFormatter.dateFormat = dayOnlyDateFormat
        let dayInString = dateFormatter.stringFromDate(currentDate)
        
        dateFormatter.dateFormat = yearOnlyDateFormate
        let yearInString = dateFormatter.stringFromDate(currentDate)
        
        monthAndDayLabel.text = "\(monthInString) \(dayInString)"
        yearLabel.text = "\(yearInString)"
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSizeMake(rootView.frame.width, contentView.frame.height)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rightToLeftSwipedInShowcaseView() {
        
        // Cancel the gesture recognition if reached the end of the reading list BEFORE the swipe
        if currentReadingListPt == fetchedReadingListItems.count - 1 {
            return
        }
        
        let temp : homePageShowcasePanel = leftPanel
        let distanceToMove = self.showcase.frame.width - 60.0
        
        // Animation
        UIView.animateWithDuration(0.7, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
            self.leftPanel.transform = CGAffineTransformConcat(self.leftPanel.transform, CGAffineTransformMakeTranslation(-distanceToMove, 0.0))
            self.leftPanel.alpha = 0.0
            self.centerPanel.transform = CGAffineTransformConcat(self.centerPanel.transform, CGAffineTransformMakeTranslation(-distanceToMove, 0.0))
            self.centerPanel.alpha = 0.1
            self.rightPanel.transform = CGAffineTransformConcat(self.rightPanel.transform, CGAffineTransformMakeTranslation(-distanceToMove, 0.0))
            self.rightPanel.alpha = 1
            }) { (ifCompleted) in
                // Update the pointer to the current position in the reading list
                self.currentReadingListPt = self.currentReadingListPt + 1
                temp.transform = CGAffineTransformConcat(temp.transform, CGAffineTransformMakeTranslation(3 * distanceToMove, 0.0))
                self.leftPanel = self.centerPanel
                self.centerPanel = self.rightPanel
                self.rightPanel = temp
                UIView.animateWithDuration(0.15, animations: {
                    // Hide the right panel if reached the end of the reading list AFTER the swipe
                    if self.currentReadingListPt == self.fetchedReadingListItems.count - 1 {
                        self.rightPanel.alpha = 0.0
                    } else {
                        // Load the next reading list item
                        let sectionOfRightItem = ForumSections.Sections(rawValue: self.fetchedReadingListItems[self.currentReadingListPt + 1].category!.longValue)!
                        let backgroundImageOfRightItem = ForumSections.getPanelBackgroundImageOfGivenSection(sectionOfRightItem)
                        let titleOfRightItem = self.fetchedReadingListItems[self.currentReadingListPt + 1].title!
                        let lastUpdatedTimeOfRightItem = self.fetchedReadingListItems[self.currentReadingListPt + 1].timeAdded!
                        let baseCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
                        let numberOfDaysAfterLastUpdatedTimeOfRightItemInComponent = baseCalendar.components(NSCalendarUnit.Day, fromDate: lastUpdatedTimeOfRightItem, toDate: NSDate(), options: NSCalendarOptions())
                        let numberOfDaysAfterLastUpdatedTimeOfRightItem = numberOfDaysAfterLastUpdatedTimeOfRightItemInComponent.day
                        let lastUpdatedTimeOfRightItemInString = "上次更新于\(numberOfDaysAfterLastUpdatedTimeOfRightItem)天前"
                        
                        self.rightPanel.setUpContentsInPanel(backgroundImageOfRightItem, updateLabelContent: lastUpdatedTimeOfRightItemInString, itemTitleContent: titleOfRightItem)
                        
                        self.rightPanel.alpha = 0.1
                    }
                })
        }
    }
    
    func leftToRightSwipedInShowcaseView() {
        
        // Cancel the gesture recognition if reached the beginning of the reading list BEFORE the swipe
        if currentReadingListPt == 0 {
            return
        }
        
        let temp : homePageShowcasePanel = rightPanel
        let distanceToMove = self.showcase.frame.width - 60.0
        
        // Animation
        UIView.animateWithDuration(0.7, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
            self.leftPanel.transform = CGAffineTransformConcat(self.leftPanel.transform, CGAffineTransformMakeTranslation(distanceToMove, 0.0))
            self.leftPanel.alpha = 1.0
            self.centerPanel.transform = CGAffineTransformConcat(self.centerPanel.transform, CGAffineTransformMakeTranslation(distanceToMove, 0.0))
            self.centerPanel.alpha = 0.1
            self.rightPanel.transform = CGAffineTransformConcat(self.rightPanel.transform, CGAffineTransformMakeTranslation(distanceToMove, 0.0))
            self.rightPanel.alpha = 0.0
        }) { (ifCompleted) in
            // Update the pointer to the current position in the reading list
            self.currentReadingListPt = self.currentReadingListPt - 1
            temp.transform = CGAffineTransformConcat(temp.transform, CGAffineTransformMakeTranslation(-3 * distanceToMove, 0.0))
            self.rightPanel = self.centerPanel
            self.centerPanel = self.leftPanel
            self.leftPanel = temp
            UIView.animateWithDuration(0.15, animations: {
                // Hide the left panel if reached the beginning of the reading list AFTER the swipe
                if self.currentReadingListPt == 0 {
                    self.leftPanel.alpha = 0.0
                } else {
                    // Load the previous reading list item
                    let sectionOfLeftItem = ForumSections.Sections(rawValue: self.fetchedReadingListItems[self.currentReadingListPt - 1].category!.longValue)!
                    let backgroundImageOfLeftItem = ForumSections.getPanelBackgroundImageOfGivenSection(sectionOfLeftItem)
                    let titleOfLeftItem = self.fetchedReadingListItems[self.currentReadingListPt - 1].title!
                    let lastUpdatedTimeOfLeftItem = self.fetchedReadingListItems[self.currentReadingListPt - 1].timeAdded!
                    let baseCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
                    let numberOfDaysAfterLastUpdatedTimeOfLeftItemInComponent = baseCalendar.components(NSCalendarUnit.Day, fromDate: lastUpdatedTimeOfLeftItem, toDate: NSDate(), options: NSCalendarOptions())
                    let numberOfDaysAfterLastUpdatedTimeOfLeftItem = numberOfDaysAfterLastUpdatedTimeOfLeftItemInComponent.day
                    let lastUpdatedTimeOfLeftItemInString = "上次更新于\(numberOfDaysAfterLastUpdatedTimeOfLeftItem)天前"
                    
                    self.leftPanel.setUpContentsInPanel(backgroundImageOfLeftItem, updateLabelContent: lastUpdatedTimeOfLeftItemInString, itemTitleContent: titleOfLeftItem)
                    
                    self.leftPanel.alpha = 0.1
                }
            })
        }
    }

}
