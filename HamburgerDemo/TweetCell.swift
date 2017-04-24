//
//  ProfileCell.swift
//  HamburgerDemo
//
//  Created by sideok you on 4/23/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  @IBOutlet weak var tweetProfileImage: UIImageView!
  @IBOutlet weak var tweetScreenNameLabel: UILabel!
  @IBOutlet weak var tweetCreatedAtLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  
  var tweet : Tweet!{
    didSet{
      tweetProfileImage.image = nil
      if let profileImageUrl = tweet.profileImageUrl{
        tweetProfileImage.setImageWith(profileImageUrl)
      }
      tweetProfileImage.layer.cornerRadius = 5
      
      tweetScreenNameLabel.text = tweet.screenName
      
      if let since = tweet.timestamp?.timeIntervalSinceNow {
        let hours = round(since / 3600.0) * -1.0
        if hours < 24 {
          tweetCreatedAtLabel.text = "\(Int(hours))H"
        } else {
          tweetCreatedAtLabel.text = "\(tweet.timestampDate!)"
        }
      }
      
      
      tweetTextLabel.text = tweet.text
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

}
