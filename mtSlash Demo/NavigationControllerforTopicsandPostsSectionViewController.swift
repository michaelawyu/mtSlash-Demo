//
//  NavigationControllerforTopicsandPostsSectionViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/23/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

var navigationBarInTopicsAndPostsViewScreens : UINavigationBar? = nil

class NavigationControllerforTopicsandPostsSectionViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarInTopicsAndPostsViewScreens = self.navigationBar
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.visibleViewController
    }
    

}
