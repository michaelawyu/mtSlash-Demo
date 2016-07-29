//
//  topicTitleContainerCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/29/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class topicTitleContainerCell: UITableViewCell {

    @IBOutlet weak var authorAvatarProfileImage: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateOfPublishingLabel: UILabel!
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var noOfRepliesViewsAndLastReplyFromLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        authorAvatarProfileImage.layer.borderWidth = 1
        authorAvatarProfileImage.layer.masksToBounds = true
        authorAvatarProfileImage.layer.borderColor = UIColor.whiteColor().CGColor
        authorAvatarProfileImage.layer.cornerRadius = authorAvatarProfileImage.frame.height / 2
        authorAvatarProfileImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle(title: String) {
        topicTitleLabel.text = title
    }
    
    func setAuthor(authorName: String) {
        authorNameLabel.text = authorName
    }
    
    func setDateOfPublishing(time: String) {
        dateOfPublishingLabel.text = time
    }
    
    func setAuthorProfileImage(imageReference: String) {
        // Code Not Completed: Update When Ready
    }
    
    func setNoOfRepliesViewsAndLastReplyFromInfo(info: String) {
        noOfRepliesViewsAndLastReplyFromLabel.text = info
    }

}
