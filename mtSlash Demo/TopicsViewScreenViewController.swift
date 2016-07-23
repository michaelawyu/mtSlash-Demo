//
//  TopicsViewScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/12/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class TopicsViewScreenViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var subSectionsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarInTopicsAndPostsViewScreens!.setBackgroundImage(UIImage.fromColor(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)), forBarMetrics: UIBarMetrics.Default)
        (subSectionsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 100, height: 50.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = subSectionsCollectionView.dequeueReusableCellWithReuseIdentifier("SampleCell", forIndexPath: indexPath)

        return cell
    }
}
