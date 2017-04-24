//
//  TimelineViewController.swift
//  HamburgerDemo
//
//  Created by sideok you on 4/23/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
    var tweets: [Tweet]!
  var indexPathRow : Int!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
      
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) -> () in
          self.tweets = tweets
          self.tableView.reloadData()
        }, failure: { (error:Error) -> () in
          print("fail to get user timeline")
        })
    }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tweets != nil{
      return tweets.count
    }else{
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    print("called")
    let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
    
    cell.tweet = tweets[indexPath.row]
    
    cell.tweetProfileImage.tag = indexPath.row
    cell.tweetProfileImage.isUserInteractionEnabled = true
    let tapGestureOnImage = UITapGestureRecognizer(target: self, action: #selector(onTapGesture(_:)))
    cell.tweetProfileImage.addGestureRecognizer(tapGestureOnImage)
    
    
    return cell;
  }
  
  func onTapGesture(_ sender:UITapGestureRecognizer){
    print("tapped")
    indexPathRow = sender.view?.tag
    print(indexPathRow)
    performSegue(withIdentifier: "ShowProfile", sender: self)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "ShowProfile"{
      let profileViewController = segue.destination as! ProfileViewController
      profileViewController.parameters["screen_name"] = tweets[indexPathRow].screenName
      print(tweets[indexPathRow].screenName)
    }
  }
}
