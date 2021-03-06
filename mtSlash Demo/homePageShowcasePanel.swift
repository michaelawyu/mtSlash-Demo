//
//  homePageShowcasePanel.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/25/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class homePageShowcasePanel: UIView {
    
    var backgroundImage : UIImageView?
    var updateLabel : UILabel?
    var itemTitle : UILabel?
    
    var title : String? = nil
    var timeAdded : NSDate? = nil
    var link : String? = nil
    var ifVisible : Bool? = nil
    var category : Int? = nil
    var abstract : String? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        extInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        extInit()
    }
    
    func extInit() {
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.8
        
        self.backgroundColor = UIColor(red: 227.0/255.0, green: 18.0/255.0, blue: 11.0/255.0, alpha: 0.85)
        
        backgroundImage = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height))
        backgroundImage?.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImage?.clipsToBounds = true
        backgroundImage?.alpha = 1.0
        
        //Sample Context: Background Image for Panel
        backgroundImage?.image = UIImage()
        
        updateLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 20.0))
        updateLabel?.numberOfLines = 1
        updateLabel?.textAlignment = NSTextAlignment.Right
        updateLabel?.font = UIFont(name: "PingFangSC-Regular", size: 13.0)
        updateLabel?.textColor = UIColor.whiteColor()
        updateLabel?.shadowColor = UIColor.blackColor()
        updateLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        //Sample Context: Update Label
        updateLabel?.text = "添加日期"
        
        itemTitle = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 50.0))
        itemTitle?.numberOfLines = 2
        itemTitle?.textAlignment = NSTextAlignment.Right
        itemTitle?.font = UIFont(name: "PingFangSC-Semibold", size: 14.0)
        itemTitle?.textColor = UIColor.whiteColor()
        itemTitle?.shadowColor = UIColor.blackColor()
        itemTitle?.translatesAutoresizingMaskIntoConstraints = false
        
        //Sample Context: Item Title
        itemTitle?.text = "项目标题"
        
        self.addSubview(backgroundImage!)
        self.addSubview(updateLabel!)
        self.addSubview(itemTitle!)
        
        let viewMargins = self.layoutMarginsGuide
                
        updateLabel?.topAnchor.constraintEqualToAnchor(viewMargins.topAnchor).active = true
        updateLabel?.leadingAnchor.constraintEqualToAnchor(viewMargins.leadingAnchor).active = true
        updateLabel?.trailingAnchor.constraintEqualToAnchor(viewMargins.trailingAnchor).active = true
        updateLabel?.heightAnchor.constraintEqualToAnchor(viewMargins.heightAnchor, multiplier: 0.0, constant: 20.0)
        
        itemTitle?.bottomAnchor.constraintEqualToAnchor(viewMargins.bottomAnchor).active = true
        itemTitle?.leadingAnchor.constraintEqualToAnchor(viewMargins.leadingAnchor).active = true
        itemTitle?.trailingAnchor.constraintEqualToAnchor(viewMargins.trailingAnchor).active = true
        itemTitle?.heightAnchor.constraintEqualToAnchor(viewMargins.heightAnchor, multiplier: 0.0, constant: 50.0)
    }
    
    func setUpContentsInPanel (newBackgroundImage: UIImage, updateLabelContent: String, itemTitleContent: String) {
        backgroundImage?.image = newBackgroundImage
        updateLabel?.text = updateLabelContent
        itemTitle?.text = itemTitleContent
    }
    
    func setInfoEmbeddedInPanel(title: String, timeAdded: NSDate, link: String, ifVisible: Bool, category: Int, abstract: String) {
        self.title = title
        self.timeAdded = timeAdded
        self.link = link
        self.ifVisible = ifVisible
        self.category = category
        self.abstract = abstract
    }


}
