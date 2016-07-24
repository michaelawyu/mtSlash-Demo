//
//  subSectionNameContainerCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/24/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class subSectionNameContainerCell: UICollectionViewCell {
    
    @IBOutlet weak var subSectionNameButton: UIButton!
    
    func setTitleOfButton(name : String) {
        subSectionNameButton.setTitle(name, forState: UIControlState.Normal)
    }
}
