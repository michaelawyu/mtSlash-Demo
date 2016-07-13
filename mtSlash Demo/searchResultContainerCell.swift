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
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
