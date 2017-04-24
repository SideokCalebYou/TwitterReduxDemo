//
//  ProfileViewController.swift
//  HamburgerDemo
//
//  Created by sideok you on 4/23/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var profileBackgroundImage: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var profileNameLabel: UILabel!
  @IBOutlet weak var profileScreenNameLabel: UILabel!
  @IBOutlet weak var profileTweetsLabel: UILabel!
  @IBOutlet weak var profileFollowingLabel: UILabel!
  @IBOutlet weak var profileFollowersLabel: UILabel!
  
  @IBOutlet weak var userView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  var tweets: [Tweet]!
  var parameters: [String: String] = [:]
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
      
      
      if parameters["screen_name"] != nil{
        TwitterClient.sharedInstance?.showUser(screen_name: parameters["screen_name"]!, success: { (user:User) in
          
          if self.parameters["screen_name"] != "sideok_you" {
            self.profileBackgroundImage.setImageWith(user.headerUrl!)
            self.profileImage.setImageWith(user.profileUrl!)
            self.profileNameLabel.text = user.name
            self.profileScreenNameLabel.text = user.screenName
            self.profileTweetsLabel.text = "\(user.tweetCount!)"
            self.profileFollowingLabel.text = "\(user.followingCount!)"
            self.profileFollowersLabel.text = "\(user.followersCount!)"
            self.parameters["screen_name"] = user.screenName
            self.navigationItem.title = user.name
          }else{
            self.profileBackgroundImage.setImageWith(user.headerUrl!)
            self.profileImage.setImageWith(user.profileUrl!)
            self.profileNameLabel.text = user.name
            self.profileScreenNameLabel.text = user.screenName
            self.profileTweetsLabel.text = "\(user.tweetCount!)"
            self.profileFollowingLabel.text = "\(user.followingCount!)"
            self.profileFollowersLabel.text = "\(user.followersCount!)"
            self.parameters["screen_name"] = user.screenName
            self.navigationItem.title = user.name
          }
          
        }, failure: { (error:Error) in
          print("error")
        })
        
        TwitterClient.sharedInstance?.selectedUserTimeLine(screen_name: parameters["screen_name"]!, success: { (tweets:[Tweet]) in
          self.tweets = tweets
          self.tableView.reloadData()
        }, failure: { (error:Error) in
          print("fail to get user timeline")
        })
        
      }else{
        
        TwitterClient.sharedInstance?.currentAccount(succues: { (user:User) in
          //self.profileBackgroundImage.setImageWith(user.headerUrl!)
          self.profileImage.setImageWith(user.profileUrl!)
          self.profileNameLabel.text = user.name
          self.profileScreenNameLabel.text = user.screenName
          self.profileTweetsLabel.text = "\(user.tweetCount!)"
          self.profileFollowingLabel.text = "\(user.followingCount!)"
          self.profileFollowersLabel.text = "\(user.followersCount!)"
          self.parameters["screen_name"] = user.screenName
          self.navigationItem.title = user.name
        }, failure: { (error:Error) in
          print("fail to get user account")
        })
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) -> () in
          self.tweets = tweets
          self.tableView.reloadData()
        }, failure: { (error:Error) -> () in
          print("fail to get user timeline mine")
        })
      }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tweets != nil{
      return tweets.count
    }else{
      return 0
    }
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
    
    cell.tweet = self.tweets[indexPath.row]
    
    return cell
  }
  
}
