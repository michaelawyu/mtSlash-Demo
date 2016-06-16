//
//  customSegueFromUsernameInputScreenToPasswordInputScreen.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/15/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class customSegueFromUsernameInputScreenToPasswordInputScreen: UIStoryboardSegue {
    override func perform() {
        self.sourceViewController.presentViewController(self.destinationViewController, animated: false, completion: nil)
    }
}
