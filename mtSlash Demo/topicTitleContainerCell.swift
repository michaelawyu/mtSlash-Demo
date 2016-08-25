//
//  topicTitleContainerCell.swift
//  mtSlash Demo
//
//  Created by Michael.A.W.Yu on 7/29/16.
//  Copyright © 2016 Michael.A.W.Yu. All rights reserved.
//

import UIKit

class topicTitleContainerCell: UITableViewCell {

    @IBOutlet weak var authorAvatarProfileImage: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateOfPublishingLabel: UILabel!
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var noOfRepliesViewsAndLastReplyFromLabel: UILabel!

    var authorName : String = ""
    var authorID : Int = 0
    var publishDateInSeconds : Int = 0
    var publishDate : NSDate = NSDate()
    var fid : Int = 0
    var lastPosterName : String = ""
    var numberOfReplies : Int = 0
    var numberOfViews : Int = 0
    // Fandom of the thread
    var categoryID : Int = 0
    var postTitle : String = ""
    var tid : Int = 0
    // Type of the thread, such as translation, original work, etc.
    var typeID : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the frame of avatar profile image as a circle
        authorAvatarProfileImage.layer.borderWidth = 1
        authorAvatarProfileImage.layer.masksToBounds = true
        authorAvatarProfileImage.layer.borderColor = UIColor.whiteColor().CGColor
        authorAvatarProfileImage.layer.cornerRadius = authorAvatarProfileImage.frame.height / 2
        authorAvatarProfileImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setTitle(title: String) {
        topicTitleLabel.text = title
        postTitle = title
    }
    
    func setAuthor(authorName: String, authorID: Int) {
        authorNameLabel.text = authorName
        self.authorName = authorName
        self.authorID = authorID
        
        setAuthorAvatarProfileImage()
    }
    
    func setDateOfPublishing(timeInSeconds: Int) {
        publishDateInSeconds = timeInSeconds
        publishDate = NSDate(timeIntervalSince1970: Double(timeInSeconds))
        
        let publishDateFormatter = NSDateFormatter()
        publishDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        dateOfPublishingLabel.text = publishDateFormatter.stringFromDate(publishDate)
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
                    self.authorAvatarProfileImage.image = retrievedAvatarProfileImage
                })
            }
        }
        taskForRetrievingAvatarProfileImage.resume()
    }
    
    func setNoOfRepliesViewsAndLastReplyFromInfo(numberOfReplies: Int, numberOfViews: Int, lastPosterName: String) {
        self.numberOfReplies = numberOfReplies
        self.numberOfViews = numberOfViews
        self.lastPosterName = lastPosterName
        noOfRepliesViewsAndLastReplyFromLabel.text = "\(numberOfReplies)条回复 \(numberOfViews)次查看 最后回复来自@\(lastPosterName)"
    }
    
    func setAdditonalInfo(fid: Int, tid: Int, categoryID: Int, typeID: Int) {
        self.fid = fid
        self.tid = tid
        self.categoryID = categoryID
        self.typeID = typeID
    }

}
