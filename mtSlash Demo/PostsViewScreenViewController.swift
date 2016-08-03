//
//  PostsViewScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/29/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class PostsViewScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        postsTableView.estimatedRowHeight = 400.0
        postsTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SampleCell")!
        return cell
    }
}
