//
//  CentralControlTabBarController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/20/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class CentralControlTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = self.tabBar
        tabBar.tintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
        
        let viewControllers = self.viewControllers
        for viewController in viewControllers! {
            let tabBarItem = viewController.tabBarItem
            tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
            self.tabBarItem = tabBarItem
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillLayoutSubviews() {
        var tabBarFrame = self.tabBar.frame
        tabBarFrame.size.height = 40
        tabBarFrame.origin.y = self.view.frame.size.height - 40
        self.tabBar.frame = tabBarFrame
    }

}
