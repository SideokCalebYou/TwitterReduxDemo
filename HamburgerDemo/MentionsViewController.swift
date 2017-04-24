//
//  MentionsViewController.swift
//  HamburgerDemo
//
//  Created by sideok you on 4/23/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  
  var tweets : [Tweet]!
  override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
    
        TwitterClient.sharedInstance?.getMentionTimeLine(success: { (tweets:[Tweet]) in
          print("got mentions")
          self.tweets = tweets
          self.tableView.reloadData()
          
        }, failure: { (error:Error) in
          print("failed to get mentions")
        })
      
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
    
    cell.tweet = tweets[indexPath.row]
    
    return cell
  }
  

}
