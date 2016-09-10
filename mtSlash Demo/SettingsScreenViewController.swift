//
//  SettingsScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/20/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit
import CoreData

class SettingsScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var settingTableView: UITableView!
    
    let titlesOfSections : [String] = ["显示", "隐私与安全", "登录状态"]
    let noOfItemsUnderEachSection : [Int] = [4,2,2]
    
    // Function for returning specific table view cell at given location (index path)
    func initTableViewCellAtGivenIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let indexPathAsTuple : (Int, Int) = (indexPath.indexAtPosition(0), indexPath.indexAtPosition(1))
        switch indexPathAsTuple {
        case (0, 0):
            let cell : standardSettingsWithAccessoryViewCell = settingTableView.dequeueReusableCellWithIdentifier("standardCellWithAccessoryView") as! standardSettingsWithAccessoryViewCell
            
            cell.setTitleOfSetting("字体样式")
            
            // Read current font setting from database
            let currentFont = ConvenientMethods.getCurrentSettingFromDatabase().1
            cell.setCurrentSelectionOfSetting(Fonts.getDescriptionOfSupportedFonts(currentFont))
            
            return cell
        case (0, 1):
            let cell : fontSidenoteInSettingsViewCell = settingTableView.dequeueReusableCellWithIdentifier("sidenoteCell_Fonts") as! fontSidenoteInSettingsViewCell
            return cell
        case (0, 2):
            let cell : standardSettingsWithAccessoryViewCell = settingTableView.dequeueReusableCellWithIdentifier("standardCellWithAccessoryView") as! standardSettingsWithAccessoryViewCell
            
            // Read current font size setting from database
            let currentFontSize = ConvenientMethods.getCurrentSettingFromDatabase().0
            cell.setCurrentSelectionOfSetting(Fonts.getDescriptionOfSupportedFontSizes(currentFontSize))
            
            cell.setTitleOfSetting("字体大小")
            return cell
        case (0, 3):
            let cell : displaySampleSidenoteInSettingsViewCell = settingTableView.dequeueReusableCellWithIdentifier("sidenoteCell_DisplaySample") as! displaySampleSidenoteInSettingsViewCell
            cell.refreshDisplayLabel()
            return cell
        case (1,0):
            let cell : standardSettingsWithoutAccessoryViewCell = settingTableView.dequeueReusableCellWithIdentifier("standardCellWithoutAccessoryView") as! standardSettingsWithoutAccessoryViewCell
            cell.setTitleOfSetting("清空当前用户的历史搜索记录")
            return cell
        case (1,1):
            let cell : standardSettingsWithoutAccessoryViewCell = settingTableView.dequeueReusableCellWithIdentifier("standardCellWithoutAccessoryView") as! standardSettingsWithoutAccessoryViewCell
            cell.setTitleOfSetting("清空当前用户的阅读列表")
            return cell
        case (2,0):
            let cell : standardSettingsWithoutAccessoryViewCell = settingTableView.dequeueReusableCellWithIdentifier("standardCellWithoutAccessoryView") as! standardSettingsWithoutAccessoryViewCell
            cell.setTitleOfSetting("登出")
            return cell
        case (2,1):
            let cell : currentAccountSidenoteInSettingsViewCell = settingTableView.dequeueReusableCellWithIdentifier("sidenoteCell_CurrentAccount") as! currentAccountSidenoteInSettingsViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.rowHeight = UITableViewAutomaticDimension
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
        cell.selectionStyle = UITableViewCellSelectionStyle.None
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPathAsTuple : (Int, Int) = (indexPath.indexAtPosition(0), indexPath.indexAtPosition(1))
        switch indexPathAsTuple {
        case (0, 0):
            newFontSelected()
        case (0, 2):
            newFontSizeSelected()
        case (1, 0):
            // Issue a warning before clearing search history of current user
            let confirmationRequiredBeforeClearingSearchHistory = UIAlertController(title: "确认您的操作", message: "在您确认后，您的所有搜索历史记录将被清除，且不能恢复。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                confirmationRequiredBeforeClearingSearchHistory.dismissViewControllerAnimated(true, completion: nil)
                // Confirmation acquired, proceed to clear all user-specific search history entries
                self.clearSearchHistoryOfCurrentUser()
            })
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: { (action) in
                // Action cancelled
                confirmationRequiredBeforeClearingSearchHistory.dismissViewControllerAnimated(true, completion: nil)
                return
            })
            confirmationRequiredBeforeClearingSearchHistory.addAction(OKAction)
            confirmationRequiredBeforeClearingSearchHistory.addAction(cancelAction)
            self.presentViewController(confirmationRequiredBeforeClearingSearchHistory, animated: true, completion: nil)
        case (1, 1):
            // Issue a warning before clearing search history of current user
            let confirmationRequiredBeforeClearingReadingList = UIAlertController(title: "确认您的操作", message: "在您确认后，您的阅读列表将被清空，且不能恢复。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                confirmationRequiredBeforeClearingReadingList.dismissViewControllerAnimated(true, completion: nil)
                // Confirmation acquired, proceed to clear all user-specific search history entries
                self.clearReadingListOfCurrentUser()
            })
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: { (action) in
                // Action cancelled
                confirmationRequiredBeforeClearingReadingList.dismissViewControllerAnimated(true, completion: nil)
                return
            })
            confirmationRequiredBeforeClearingReadingList.addAction(OKAction)
            confirmationRequiredBeforeClearingReadingList.addAction(cancelAction)
            self.presentViewController(confirmationRequiredBeforeClearingReadingList, animated: true, completion: nil)
        case (2, 0):
            // Issue a warning before logging out
            let confirmationRequiredBeforeLoggingOut = UIAlertController(title: "确认您的操作", message: "在您确认后，当前账户将会从应用程序中登出。", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: { (action) in
                confirmationRequiredBeforeLoggingOut.dismissViewControllerAnimated(true, completion: nil)
                // Confirmation acquired, proceed to log out
                self.logOutCurrentUser()

            })
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: { (action) in
                confirmationRequiredBeforeLoggingOut.dismissViewControllerAnimated(true, completion: nil)
            })
            confirmationRequiredBeforeLoggingOut.addAction(OKAction)
            confirmationRequiredBeforeLoggingOut.addAction(cancelAction)
            self.presentViewController(confirmationRequiredBeforeLoggingOut, animated: true, completion: nil)
        default:
            return
        }
    }
    
    func newFontSelected() {
        let selectedANewFontActionSheet = UIAlertController(title: "字体选择", message: "在下方列表中调整显示帖子内容时使用的字体。敬请参阅相关文档了解关于可用字体的更多信息。", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // Set anchor for the popover controller (as required for iPad-esque devices)
        selectedANewFontActionSheet.popoverPresentationController?.sourceView = self.view
        selectedANewFontActionSheet.popoverPresentationController?.sourceRect = self.view.frame
        
        for item in Fonts.listOfSupportedFonts {
            let supportedFontAction = UIAlertAction(title: Fonts.getDescriptionOfSupportedFonts(item), style: UIAlertActionStyle.Default, handler: { (action) in
                // Update the system record
                self.updateSettingOfCurrentUser(nil, newFont: item.rawValue)
                
                // Refresh the UI
                dispatch_async(dispatch_get_main_queue(), {
                    self.settingTableView.reloadData()
                })
                
            })
            selectedANewFontActionSheet.addAction(supportedFontAction)
        }
        self.presentViewController(selectedANewFontActionSheet, animated: true, completion: nil)
    }
    
    func newFontSizeSelected() {
        let selectedANewFontSizeActionSheet = UIAlertController(title: "字体大小选择", message: "在下方列表中调整显示帖子内容时使用的基准字体大小。由帖子自定义的字体大小将会在基准字体大小的基础上重设。", preferredStyle: UIAlertControllerStyle.ActionSheet)
        // Set anchor for the popover controller (as required for iPad-esque devices)
        selectedANewFontSizeActionSheet.popoverPresentationController?.sourceView = self.view
        selectedANewFontSizeActionSheet.popoverPresentationController?.sourceRect = self.view.frame
        
        for item in Fonts.listOfSupportedSizes {
            let supportedFontSizeAction = UIAlertAction(title: Fonts.getDescriptionOfSupportedFontSizes(item), style: UIAlertActionStyle.Default, handler: { (action) in
                // Update the system record
                self.updateSettingOfCurrentUser(item.rawValue, newFont: nil)
                
                // Refresh the UI
                dispatch_async(dispatch_get_main_queue(), {
                    self.settingTableView.reloadData()
                })
            })
            selectedANewFontSizeActionSheet.addAction(supportedFontSizeAction)
        }
        
        self.presentViewController(selectedANewFontSizeActionSheet, animated: true, completion: nil)
    }
    
    func updateSettingOfCurrentUser(newFontSize: Float?, newFont: String?) {
        // Wait until the framework is ready
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Set up fetch request
        let settingItemsFetchRequest = NSFetchRequest(entityName: "MTSettings")
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        let predicateForFetchingSettingsOfSpecificUser = NSPredicate(format: "(belongTo == %@)", argumentArray: [currentUser])
        settingItemsFetchRequest.predicate = predicateForFetchingSettingsOfSpecificUser
        
        var settingsOfCurrentUser : [MTSettings]? = nil
        var settingOfCurrentUser : MTSettings? = nil
        
        // Fetch user-specific setting from data framework
        do {
            settingsOfCurrentUser = try managedObjectContextInUse.executeFetchRequest(settingItemsFetchRequest) as? [MTSettings]
            settingOfCurrentUser = settingsOfCurrentUser!.last
        } catch {
            fatalError("An error has occurred: Failed to fetch setting items from the database.")
        }
        
        // Update the setting of current user
        if newFontSize != nil {
            settingOfCurrentUser!.definedFontSize = newFontSize!
        }
        
        if newFont != nil {
            settingOfCurrentUser!.definedFont = newFont!
        }
        
        // Save the setting to data framework
        do {
            try managedObjectContextInUse.save()
        } catch {
            fatalError("An error has occurred: Failed to save updated setting to the database.")
        }
    }
    
    func clearSearchHistoryOfCurrentUser() {
        // Get search history of current user
        // Wait until the framework is ready
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Set up fetch request
        let searchHistoryEntriesFetchRequest = NSFetchRequest(entityName: "MTSearchHistory")
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        let predicateForFetchingSearchHistoryEntriesOfSpecificUser = NSPredicate(format: "(belongTo == %@)", argumentArray: [currentUser])
        searchHistoryEntriesFetchRequest.predicate = predicateForFetchingSearchHistoryEntriesOfSpecificUser
        
        var searchHistoryEntriesOfCurrentUser : [MTSearchHistory] = []
        
        // Fetch user-specific search history entries from data framework
        do {
            searchHistoryEntriesOfCurrentUser = try managedObjectContextInUse.executeFetchRequest(searchHistoryEntriesFetchRequest) as! [MTSearchHistory]
        } catch {
            fatalError("An error has occurred: Failed to fetch search history entries from the database.")
        }
        
        // Remove all entries
        for entry in searchHistoryEntriesOfCurrentUser {
            managedObjectContextInUse.deleteObject(entry)
        }
        
        // Save the updates
        do {
            try managedObjectContextInUse.save()
        } catch {
            fatalError("An error has occurred: Failed to save changes into the database.")
        }
        
        // Issue a notification for completion of action
        let clearanceOfSearchHistoryEntriesCompleted = UIAlertController(title: "操作完成", message: "当前用户的所有搜索历史记录已被清除。", preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) in
            clearanceOfSearchHistoryEntriesCompleted.dismissViewControllerAnimated(true, completion: nil)
        }
        clearanceOfSearchHistoryEntriesCompleted.addAction(OKAction)
        self.presentViewController(clearanceOfSearchHistoryEntriesCompleted, animated: true, completion: nil)
    }
    
    func clearReadingListOfCurrentUser() {
        // Get reading list of current user
        // Wait until the framework is ready
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        // Set up fetch request
        let readingListEntriesFetchRequest = NSFetchRequest(entityName: "MTReadingList")
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        let predicateForFetchingReadingListEntriesOfSpecificUser = NSPredicate(format: "(belongTo == %@) AND (ifVisible == %@)", argumentArray: [currentUser, false])
        readingListEntriesFetchRequest.predicate = predicateForFetchingReadingListEntriesOfSpecificUser
        
        var readingListEntriesOfCurrentUser : [MTReadingList] = []
        
        // Fetch user-specific reading list entries from data framework
        do {
            readingListEntriesOfCurrentUser = try managedObjectContextInUse.executeFetchRequest(readingListEntriesFetchRequest) as! [MTReadingList]
        } catch {
            fatalError("An error has occurred: Failed to fetch reading list entries from the database.")
        }
        
        // Remove all entries
        for entry in readingListEntriesOfCurrentUser {
            managedObjectContextInUse.deleteObject(entry)
        }
        
        // Save the updates
        do {
            try managedObjectContextInUse.save()
        } catch {
            fatalError("An error has occurred: Failed to save changes into the database.")
        }
        
        // Issue a notification for completion of action
        let clearanceOfReadingListEntriesCompleted = UIAlertController(title: "操作完成", message: "当前用户的阅读列表已被清空。", preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) in
            clearanceOfReadingListEntriesCompleted.dismissViewControllerAnimated(true, completion: nil)
        }
        clearanceOfReadingListEntriesCompleted.addAction(OKAction)
        self.presentViewController(clearanceOfReadingListEntriesCompleted, animated: true, completion: nil)
    }
    
    func logOutCurrentUser() {
        // Wait until the framework is ready
        while dataReadyFlag != true {
            print("Waiting for the data model to get ready.")
        }
        
        // Set up data controller and moc (managed object context)
        let dataController = ConvenientMethods.getDataControllerInAppDelegate()
        let managedObjectContextInUse = dataController.managedObjectContext
        
        let currentUser = ConvenientMethods.getCurrentUser(uid)
        
        // Deactivate current user
        currentUser.ifActive = NSNumber(bool: false)
        
        // Save the updates
        do {
            try managedObjectContextInUse.save()
        } catch {
            fatalError("An error has occurred: Failed to save changes into the database.")
        }
        
        // Issue a notification for completion of action
        let successfullyLoggedOut = UIAlertController(title: "操作完成", message: "您已登出。", preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default) { (action) in
            // Transition to the cover screen
            dispatch_async(dispatch_get_main_queue(), {
                successfullyLoggedOut.dismissViewControllerAnimated(true, completion: nil)
                // Clear the username in memory
                username = ""
                self.performSegueWithIdentifier("fromSettingsScreenToCoverPageScreen", sender: self)
            })
        }
        successfullyLoggedOut.addAction(OKAction)
        self.presentViewController(successfullyLoggedOut, animated: true, completion: nil)
    }
}
