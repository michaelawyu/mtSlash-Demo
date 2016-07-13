//
//  SearchResultScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/8/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class SearchResultScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.indexAtPosition(1) == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("infoPanelContainerCell", forIndexPath: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultContainerCell", forIndexPath: indexPath)
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
}
