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
    
    var centerPanel : homePageShowcasePanel!
    var leftPanel : homePageShowcasePanel!
    var rightPanel : homePageShowcasePanel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let showcaseWidthAfterInitialization = self.view.frame.width + 5.0
        
        //Getting the Data
        
        let rightToLeftSwipeGestureRecognizerInShowcaseView = UISwipeGestureRecognizer(target: self, action: #selector(self.rightToLeftSwipedInShowcaseView))
        rightToLeftSwipeGestureRecognizerInShowcaseView.direction = UISwipeGestureRecognizerDirection.Left
        showcase.addGestureRecognizer(rightToLeftSwipeGestureRecognizerInShowcaseView)
        
        let leftToRightSwipeGestureRecognizerInShowcaseView = UISwipeGestureRecognizer(target: self, action: #selector(self.leftToRightSwipedInShowcaseView))
        leftToRightSwipeGestureRecognizerInShowcaseView.direction = UISwipeGestureRecognizerDirection.Right
        showcase.addGestureRecognizer(leftToRightSwipeGestureRecognizerInShowcaseView)
        
        centerPanel = samplePanel
        
        leftPanel = homePageShowcasePanel(frame: CGRect(x: 0.0, y: 0.0, width: showcaseWidthAfterInitialization - 60.0, height: showcase.frame.height))
        leftPanel.alpha = 0.1
        showcase.addSubview(leftPanel)
        showcase.setConstraintsForLeftPanel(leftPanel, showcaseWidth: showcaseWidthAfterInitialization)
        
        rightPanel = homePageShowcasePanel(frame: CGRect(x: 0.0, y: 0.0, width: showcaseWidthAfterInitialization - 60.0, height: showcase.frame.height))
        rightPanel.alpha = 0.1
        showcase.addSubview(rightPanel)
        showcase.setConstraintsForRightPanel(rightPanel, showcaseWidth: showcaseWidthAfterInitialization)
        
        /*
        while dataReadyFlag != true {
            print("Waiting for the Data Model.")
        }
        
        let dataController : DefaultDataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        let readingListItemsFetchRequest = NSFetchRequest(entityName: "ReadingList")
        var readingListItems : [MTReadingList]? = nil
        
        do {
            readingListItems = try managedObjectContextInUse.executeFetchRequest(readingListItemsFetchRequest) as? [MTReadingList]
        } catch {
            fatalError("An error has occurred: Failed to fetch reading list items from the database.")
        }
        
        if readingListItems!.count == 0 {
            Initialization.incorporateDefaultReadingList(dataController)
        }
        
        do {
            readingListItems = try managedObjectContextInUse.executeFetchRequest(readingListItemsFetchRequest) as? [MTReadingList]
        } catch {
            fatalError("An error has occurred: Failed to fetch reading list items from the database.")
        }
        */
        
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
        
        let temp : homePageShowcasePanel = leftPanel
        let distanceToMove = self.showcase.frame.width - 60.0
        
        UIView.animateWithDuration(0.7, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
            self.leftPanel.transform = CGAffineTransformConcat(self.leftPanel.transform, CGAffineTransformMakeTranslation(-distanceToMove, 0.0))
            self.leftPanel.alpha = 0.0
            self.centerPanel.transform = CGAffineTransformConcat(self.centerPanel.transform, CGAffineTransformMakeTranslation(-distanceToMove, 0.0))
            self.centerPanel.alpha = 0.1
            self.rightPanel.transform = CGAffineTransformConcat(self.rightPanel.transform, CGAffineTransformMakeTranslation(-distanceToMove, 0.0))
            self.rightPanel.alpha = 1
            }) { (ifCompleted) in
                temp.transform = CGAffineTransformConcat(temp.transform, CGAffineTransformMakeTranslation(3 * distanceToMove, 0.0))
                self.leftPanel = self.centerPanel
                self.centerPanel = self.rightPanel
                self.rightPanel = temp
                UIView.animateWithDuration(0.15, animations: {
                    self.rightPanel.alpha = 0.1
                })
        }
    }
    
    func leftToRightSwipedInShowcaseView() {
        let temp : homePageShowcasePanel = rightPanel
        let distanceToMove = self.showcase.frame.width - 60.0
        
        UIView.animateWithDuration(0.7, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut], animations: {
            self.leftPanel.transform = CGAffineTransformConcat(self.leftPanel.transform, CGAffineTransformMakeTranslation(distanceToMove, 0.0))
            self.leftPanel.alpha = 1.0
            self.centerPanel.transform = CGAffineTransformConcat(self.centerPanel.transform, CGAffineTransformMakeTranslation(distanceToMove, 0.0))
            self.centerPanel.alpha = 0.1
            self.rightPanel.transform = CGAffineTransformConcat(self.rightPanel.transform, CGAffineTransformMakeTranslation(distanceToMove, 0.0))
            self.rightPanel.alpha = 0.0
        }) { (ifCompleted) in
            temp.transform = CGAffineTransformConcat(temp.transform, CGAffineTransformMakeTranslation(-3 * distanceToMove, 0.0))
            self.rightPanel = self.centerPanel
            self.centerPanel = self.leftPanel
            self.leftPanel = temp
            UIView.animateWithDuration(0.15, animations: {
                self.leftPanel.alpha = 0.1
            })
        }
    }

}
