//
//  standardSettingsWithAccessoryViewCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/10/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class standardSettingsWithAccessoryViewCell: UITableViewCell {

    @IBOutlet weak var titleOfSettingLabel: UILabel!
    @IBOutlet weak var currentSelectionOfSettingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitleOfSetting(title: String) {
        titleOfSettingLabel.text = title
    }
    
    func setCurrentSelectionOfSetting(selection: String) {
        currentSelectionOfSettingLabel.text = selection
    }

}
