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
    
    var pid : Int? = nil
    var fid : Int? = nil
    var tid : Int? = nil
    var authorName : String? = nil
    var authorID : Int? = nil
    var subject : String? = nil
    var publishDateInSeconds : Int? = nil
    var publishDate : NSDate = NSDate()
    var message : String? = nil
    
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
    
    func setAdditionalInfo(pid: Int, fid: Int, tid: Int) {
        self.pid = pid
        self.fid = fid
        self.tid = tid
    }
    
    func setAuthor(authorName: String, authorID: Int) {
        self.authorName = authorName
        self.authorID = authorID
        
        authorNameLabel.text = authorName
        
        setAuthorAvatarProfileImage()
    }
    
    private func setAuthorAvatarProfileImage() {
        let URLForRetrievingAvatarProfileImageInString = WebLinks.getAddressOfWebLink(WebLinks.UCenterAvatarProfileImage).absoluteString + "uid=\(authorID)&size=small"
        let URLForRetrievingAvatarProfileImage = NSURL(string: URLForRetrievingAvatarProfileImageInString)!
        let sessionForRetrievingAvatarProfileImage = NSURLSession.sharedSession()
        let requestForRetrievingAvatarProfileImage = NSMutableURLRequest(URL: URLForRetrievingAvatarProfileImage)
        requestForRetrievingAvatarProfileImage.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        let taskForRetrievingAvatarProfileImage = sessionForRetrievingAvatarProfileImage.dataTaskWithURL(URLForRetrievingAvatarProfileImage) { (data, response, error) in
            if error == nil && data != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    let retrievedAvatarProfileImage = UIImage(data: data!)
                    self.authorAvatarProfileImageView.image = retrievedAvatarProfileImage
                })
            }
        }
        taskForRetrievingAvatarProfileImage.resume()
    }
    
    func setSubjectAndMessage(subject: String, message: String, parser: BulletinBoardCode2NSMutableAttributedStringParser) {
        self.subject = subject
        self.message = message
        
        self.postTitleLabel.text = subject
        self.postContentTextView.attributedText = parser.updateStringToParse(message)
    }
    
    func setDateOfPublishing(timeInSeconds: Int) {
        publishDateInSeconds = timeInSeconds
        publishDate = NSDate(timeIntervalSince1970: Double(timeInSeconds))
        
        let publishDateFormatter = NSDateFormatter()
        publishDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let publishDateInString = publishDateFormatter.stringFromDate(publishDate)
        publishDateLabel.text = "发表于\(publishDateInString)"
    }
    
    func disableViewContentFromThisAuthorOnlyButton() {
        viewContentFromThisAuthorOnlyButton.hidden = true
    }
}