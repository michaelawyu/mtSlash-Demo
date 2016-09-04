//
//  NavigationControllerforTopicsandPostsSectionViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/23/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

var navigationBarInTopicsAndPostsViewScreens : UINavigationBar? = nil
var navigationControllerInTopicsAndPostsViewScreens : NavigationControllerforTopicsandPostsSectionViewController? = nil

class NavigationControllerforTopicsandPostsSectionViewController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Expose navigation bar and navigation controller to other view controllers
        navigationBarInTopicsAndPostsViewScreens = self.navigationBar
        navigationControllerInTopicsAndPostsViewScreens = self
        
        // Set the delegate to self
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.visibleViewController
    }
    
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        return super.popViewControllerAnimated(animated)
    }

    // Restore the style of navigation bar when transitioning from posts view screen to topics view screen
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController is TopicsViewScreenViewController && storedNavigationBarStyle != nil && navigationBarInTopicsAndPostsViewScreens != nil {
            // Restore to dark style
            if storedNavigationBarStyle == NavigationBarStylesInTopicsAndPostsViewScreen.availableStyles.DarkStyle {
                NavigationBarStylesInTopicsAndPostsViewScreen.setStyleOfNavigationBarToDarkStyle(navigationBarInTopicsAndPostsViewScreens!)
            }
            // Restore to translucent style 
            if storedNavigationBarStyle == NavigationBarStylesInTopicsAndPostsViewScreen.availableStyles.TranslucentStyle {
                NavigationBarStylesInTopicsAndPostsViewScreen.setStyleOfNavigationBarToTranslucentStyle(navigationBarInTopicsAndPostsViewScreens!)
            }
        }
    }
}
