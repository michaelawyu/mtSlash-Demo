//
//  standardSearchHistoryEntryContainerCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 9/4/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class standardSearchHistoryEntryContainerCell: UITableViewCell {

    @IBOutlet weak var searchHistoryEntryLabel: UILabel!
    
    var keyword : String? = nil
    var timeAdded : NSDate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setValuesOfCell(keyword: String, timeAdded: NSDate) {
        self.keyword = keyword
        self.timeAdded = timeAdded
        
        searchHistoryEntryLabel.text = keyword
    }

}
