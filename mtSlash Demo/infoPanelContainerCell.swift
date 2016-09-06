//
//  infoPanelContainerCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/12/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class infoPanelContainerCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var searchSummaryLabel: UILabel!
    @IBOutlet weak var redoSearchButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateSearchSummaryLabel(newText: String) {
        searchSummaryLabel.text = newText
    }

}
