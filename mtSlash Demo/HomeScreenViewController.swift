//
//  HomeScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/20/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var centerPanel: homePageShowcasePanel!
    @IBOutlet weak var showcase: homePageShowcase!
    
    var leftPanel : homePageShowcasePanel!
    var rightPanel : homePageShowcasePanel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        leftPanel = homePageShowcasePanel(frame: CGRect(x: 0.0, y: 0.0, width: showcase.frame.width - 60.0, height: showcase.frame.height))
        leftPanel.alpha = 0.1
        showcase.addSubview(leftPanel)
        showcase.setConstraintsForLeftPanel(leftPanel)
        
        rightPanel = homePageShowcasePanel(frame: CGRect(x: 0.0, y: 0.0, width: showcase.frame.width - 60.0, height: showcase.frame.height))
        rightPanel.alpha = 0.1
        showcase.addSubview(rightPanel)
        showcase.setConstraintsForRightPanel(rightPanel)
        
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

    

}
