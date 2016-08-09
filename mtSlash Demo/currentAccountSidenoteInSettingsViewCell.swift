//
//  currentAccountSidenoteInSettingsViewCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 8/10/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class currentAccountSidenoteInSettingsViewCell: UITableViewCell {

    @IBOutlet weak var currentAccountStatementLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        currentAccountStatementLabel.text = "您当前是以\(username)的身份登录的。"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
