//
//  postContainerCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/26/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import Foundation
import UIKit

class postContainerCell : UITableViewCell {
    
    @IBOutlet weak var authorAvatarProfileImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var viewContentFromThisAuthorOnlyButton: UIButton!
    @IBOutlet weak var postContentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the frame of avatar profile image as a circle
        authorAvatarProfileImageView.layer.borderWidth = 1
        authorAvatarProfileImageView.layer.masksToBounds = true
        authorAvatarProfileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        authorAvatarProfileImageView.layer.cornerRadius = authorAvatarProfileImageView.frame.height / 2
        authorAvatarProfileImageView.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}