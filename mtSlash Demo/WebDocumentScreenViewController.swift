//
//  WebDocumentScreenViewController.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 6/16/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class WebDocumentScreenViewController: UIViewController {
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarTitle.title = WebLinks.getNameOfWebLink(ActivatedWebLink!)
        webView.loadRequest(NSURLRequest(URL: WebLinks.getAddressOfWebLink(ActivatedWebLink!)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func returnButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
