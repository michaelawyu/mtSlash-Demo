//
//  searchResultContainerCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/8/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class searchResultContainerCell: UITableViewCell {

    @IBOutlet weak var elementContainerBackgroundView: UIView!
    @IBOutlet weak var upperBorderView: UIView!
    @IBOutlet weak var lowerBorderView: UIView!
    @IBOutlet weak var sectionIcon: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var noOfRepliesIcon: UIImageView!
    @IBOutlet weak var viewCountIcon: UIImageView!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var noOfRepliesLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var username : String? = nil
    var publishDateWithoutIntroText : String? = nil
    var titleOfThread : String? = nil
    var noOfReplies : Int? = nil
    var viewCount : Int? = nil
    var summaryOfThread : String? = nil
    var threadID : Int? = nil
    var sectionReference : Int? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUsernameAndPublishDate(username: String, publishDate: String) {
        self.username = username
        self.publishDateWithoutIntroText = publishDate
        
        usernameLabel.text = username
        publishDateLabel.text = "发表于 \(publishDate)"
    }
    
    func setTitleAndSummaryOfThread(title: String, summary: String) {
        self.titleOfThread = title
        self.summaryOfThread = summary
        
        topicTitleLabel.text = title
        summaryLabel.text = summary
    }
    
    func setNoOfRepliesAndViewCount(noOfReplies: Int, viewCount: Int) {
        self.noOfReplies = noOfReplies
        self.viewCount = viewCount
        
        let noOfRepliesAbridgedInString = ConvenientMethods.numberAbridger(noOfReplies)
        let viewCountAbridgedInString = ConvenientMethods.numberAbridger(viewCount)
        
        noOfRepliesLabel.text = noOfRepliesAbridgedInString
        viewCountLabel.text = viewCountAbridgedInString
    }
    
    func setAdditionalInfo(threadID: Int, sectionRef: Int) {
        self.threadID = threadID
        self.sectionReference = sectionRef
    }

}
