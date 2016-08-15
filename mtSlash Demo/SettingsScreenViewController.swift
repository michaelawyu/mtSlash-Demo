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
    
    // Function for returning specific table view cell at given location (index path)
    func initTableViewCellAtGivenIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let indexPathAsTuple : (Int, Int) = (indexPath.indexAtPosition(0), indexPath.indexAtPosition(1))
        switch indexPathAsTuple {
        case (0, 0):
            let cell : standardSettingsWithAccessoryViewCell = tableView.dequeueReusableCellWithIdentifier("standardCellWithAccessoryView") as! standardSettingsWithAccessoryViewCell
            
            // To be updated: Read current font setting from database
            cell.setCurrentSelectionOfSetting("苹方(标准)")
            
            cell.setTitleOfSetting("字体样式")
            return cell
        case (0, 1):
            let cell : fontSidenoteInSettingsViewCell = tableView.dequeueReusableCellWithIdentifier("sidenoteCell_Fonts") as! fontSidenoteInSettingsViewCell
            return cell
        case (0, 2):
            let cell : standardSettingsWithAccessoryViewCell = tableView.dequeueReusableCellWithIdentifier("standardCellWithAccessoryView") as! standardSettingsWithAccessoryViewCell
            
            // To be updated: Read current font setting from database
            cell.setCurrentSelectionOfSetting("标准")
            
            cell.setTitleOfSetting("字体大小")
            return cell
        case (0, 3):
            let cell : displaySampleSidenoteInSettingsViewCell = tableView.dequeueReusableCellWithIdentifier("sidenoteCell_DisplaySample") as! displaySampleSidenoteInSettingsViewCell
            return cell
        case (1,0):
            let cell : standardSettingsWithoutAccessoryViewCell = tableView.dequeueReusableCellWithIdentifier("standardCellWithoutAccessoryView") as! standardSettingsWithoutAccessoryViewCell
            cell.setTitleOfSetting("清空当前用户的历史搜索记录")
            return cell
        case (1,1):
            let cell : standardSettingsWithoutAccessoryViewCell = tableView.dequeueReusableCellWithIdentifier("standardCellWithoutAccessoryView") as! standardSettingsWithoutAccessoryViewCell
            cell.setTitleOfSetting("清空当前用户的阅读列表")
            return cell
        case (2,0):
            let cell : standardSettingsWithoutAccessoryViewCell = tableView.dequeueReusableCellWithIdentifier("standardCellWithoutAccessoryView") as! standardSettingsWithoutAccessoryViewCell
            cell.setTitleOfSetting("登出")
            return cell
        case (2,1):
            let cell : currentAccountSidenoteInSettingsViewCell = tableView.dequeueReusableCellWithIdentifier("sidenoteCell_CurrentAccount") as! currentAccountSidenoteInSettingsViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return titlesOfSections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = initTableViewCellAtGivenIndexPath(indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noOfItemsUnderEachSection[section]
    }
    
    
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
