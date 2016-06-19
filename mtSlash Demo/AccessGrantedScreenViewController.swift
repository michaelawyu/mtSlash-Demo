//
//  AccessGrantedScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/19/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class AccessGrantedScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        (self.view as! AccessGrantedPage).extInit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
