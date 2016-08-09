//
//  SettingsScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/20/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class SettingsScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let titlesOfSections : [String] = ["显示", "隐私与安全", "登录状态"]
    let noOfItemsUnderEachSection : [Int] = [4,2,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return titlesOfSections.count
    }
    
    // To be updated
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = UITableViewCell()
        
        if indexPath.indexAtPosition(0) != 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("SampleCell")!
        }
        
        if indexPath.indexAtPosition(0) == 0 {
            if indexPath.indexAtPosition(1) == 1 {
                cell = tableView.dequeueReusableCellWithIdentifier("SampleCell_2")!
            }
            
            if indexPath.indexAtPosition(1) == 3 {
                cell = tableView.dequeueReusableCellWithIdentifier("SampleCell_3")!
            }
            
            if indexPath.indexAtPosition(1) != 1 && indexPath.indexAtPosition(1) != 3 {
                cell = tableView.dequeueReusableCellWithIdentifier("SampleCell")!
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noOfItemsUnderEachSection[section]
    }
    
    /*
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titlesOfSections : [String] = ["显示", "隐私", "登录状态"]
        return titlesOfSections[section]
    }
    */
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabelForHeader = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 15.0))
        titleLabelForHeader.text = titlesOfSections[section]
        titleLabelForHeader.font = UIFont(name: "PingFangSC-Semibold", size: 13.0)
        titleLabelForHeader.textColor = UIColor(red: 225.0/255.0, green: 17.0/255.0, blue: 11.0/255.0, alpha: 0.4)
        return titleLabelForHeader
    }

}
