//
//  TopicsViewScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/12/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class TopicsViewScreenViewController: UIViewController, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var topicsTableView: UITableView!
    @IBOutlet weak var subSectionsCollectionView: UICollectionView!
    @IBOutlet weak var upperRegionForPanGestureRecognizer: UIView!
    @IBOutlet weak var backgroundPanelInUpperRegion: UIImageView!
    @IBOutlet weak var leftPlaceholderView: UIView!
    @IBOutlet weak var rightPlaceholderView: UIView!
    @IBOutlet weak var navigationItemOnCurrentPage: UINavigationItem!
    
    var listOfAvailableSubSections : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarInTopicsAndPostsViewScreens!.setBackgroundImage(UIImage.fromColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)), forBarMetrics: UIBarMetrics.Default)
        (subSectionsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 100, height: 50.5)
        
        // Initialize List of Available Sections Here
        // Sample Data:
        listOfAvailableSubSections = ["全部", "DC", "Inception", "TSN", "X-Men", "MI4", "ST", "007", "Tolkien", "Pacific Rim", "HP", "Spider-Man", "Kingsman", "悲惨世界"]
        
        let panGestureRecognizerForUpperRegion = UIPanGestureRecognizer(target: self, action: #selector(self.pannedInUpperRegion(_:)))
        upperRegionForPanGestureRecognizer.addGestureRecognizer(panGestureRecognizerForUpperRegion)
        
        let panGestureRecognizerForLowerRegion = UIPanGestureRecognizer(target: self, action: #selector(self.pannedInLowerRegion(_:)))
        panGestureRecognizerForLowerRegion.delegate = self
        topicsTableView.addGestureRecognizer(panGestureRecognizerForLowerRegion)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func leftBackButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfAvailableSubSections.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = (subSectionsCollectionView.dequeueReusableCellWithReuseIdentifier("subSectionNameContainerCell", forIndexPath: indexPath) as! subSectionNameContainerCell)
        cell.setTitleOfButton(listOfAvailableSubSections[indexPath.indexAtPosition(1)])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SampleCell")!
        return cell
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        if upperRegionForPanGestureRecognizer.transform.ty >= 0 && (gestureRecognizer as! UIPanGestureRecognizer).translationInView(self.view).y > 0 {
            return true
        }
        
        if upperRegionForPanGestureRecognizer.transform.ty <= -258 {
            return true
        }

        return false
    }
    
    var lastDistanceMovedVertically : CGFloat = 0.0
    
    func pannedInUpperRegion(sender : UIPanGestureRecognizer) {
        let distanceMovedVertically = sender.translationInView(self.view).y
        
        if sender.state == UIGestureRecognizerState.Began {
            lastDistanceMovedVertically = 0.0
        }
        
        if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled) && self.upperRegionForPanGestureRecognizer.transform.ty >= 0 {
            UIView.animateWithDuration(0.1, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: -1.0, options: [], animations: {
                for subview in self.view.subviews {
                    subview.transform.ty = 0
                }
                }, completion: nil)
        }
        
        var deltaDistanceMovedVertically = distanceMovedVertically - lastDistanceMovedVertically
        
        if self.upperRegionForPanGestureRecognizer.transform.ty >= 0 && deltaDistanceMovedVertically > 0 {
            deltaDistanceMovedVertically = 0
        }
        
        for subview in self.view.subviews {
            subview.transform = CGAffineTransformConcat(subview.transform, CGAffineTransformMakeTranslation(0.0, deltaDistanceMovedVertically))
        }
        
        if self.upperRegionForPanGestureRecognizer.transform.ty <= -220 && deltaDistanceMovedVertically < 0 {
            for subview in self.view.subviews {
                    subview.transform.ty = -258
            }
            subSectionsCollectionView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            navigationBarInTopicsAndPostsViewScreens?.setBackgroundImage(UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)), forBarMetrics: UIBarMetrics.Default)
            leftPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            rightPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            
            // Filled With Sample Data: Update When Code is Ready
            navigationItemOnCurrentPage.title = "MOVIE FANFIC"

            deltaDistanceMovedVertically = 0
        }
        
        lastDistanceMovedVertically = distanceMovedVertically
        
        if self.upperRegionForPanGestureRecognizer.transform.ty > -258 && navigationItemOnCurrentPage.title != "" {
            navigationItemOnCurrentPage.title = ""
            subSectionsCollectionView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            navigationBarInTopicsAndPostsViewScreens?.setBackgroundImage(UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)), forBarMetrics: UIBarMetrics.Default)
            leftPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            rightPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
    }
    
    var lastDistanceMovedVerticallyInLowerRegion : CGFloat = 0.0
    
    func pannedInLowerRegion(sender : UIPanGestureRecognizer) {
        
        let distanceMovedVertically = sender.translationInView(self.view).y
        
        if sender.state == UIGestureRecognizerState.Began {
            lastDistanceMovedVerticallyInLowerRegion = 0.0
        }
        
        if (sender.state == UIGestureRecognizerState.Ended || sender.state == UIGestureRecognizerState.Cancelled) && self.upperRegionForPanGestureRecognizer.transform.ty >= 0 {
            UIView.animateWithDuration(0.1, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: -1.0, options: [], animations: {
                for subview in self.view.subviews {
                    subview.transform.ty = 0
                }
                }, completion: nil)
        }
        
        var deltaDistanceMovedVertically = distanceMovedVertically - lastDistanceMovedVerticallyInLowerRegion
        
        if self.upperRegionForPanGestureRecognizer.transform.ty >= 0 && distanceMovedVertically > 0 {
            deltaDistanceMovedVertically = 0.0
        }
        
        if self.upperRegionForPanGestureRecognizer.transform.ty <= -258 && self.topicsTableView.contentOffset.y >= 0.0 {
            deltaDistanceMovedVertically = 0.0
        }
        
        for subview in self.view.subviews {
            subview.transform = CGAffineTransformConcat(subview.transform, CGAffineTransformMakeTranslation(0.0, deltaDistanceMovedVertically))
        }
        
        if self.upperRegionForPanGestureRecognizer.transform.ty <= -220 && deltaDistanceMovedVertically < 0 {
            for subview in self.view.subviews {
                subview.transform.ty = -258
            }
            subSectionsCollectionView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            navigationBarInTopicsAndPostsViewScreens?.setBackgroundImage(UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)), forBarMetrics: UIBarMetrics.Default)
            leftPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            rightPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
            
            // Filled With Sample Data: Update When Code is Ready
            navigationItemOnCurrentPage.title = "MOVIE FANFIC"
            
            deltaDistanceMovedVertically = 0
        }
        
        lastDistanceMovedVerticallyInLowerRegion = distanceMovedVertically
        
        if self.upperRegionForPanGestureRecognizer.transform.ty > -258 && navigationItemOnCurrentPage.title != "" {
            navigationItemOnCurrentPage.title = ""
            subSectionsCollectionView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            navigationBarInTopicsAndPostsViewScreens?.setBackgroundImage(UIImage.fromColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)), forBarMetrics: UIBarMetrics.Default)
            leftPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            rightPlaceholderView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        }
        
    }
}
