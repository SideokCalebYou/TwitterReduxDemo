//
//  Users.swift
//  TwitterDemo
//
//  Created by sideok you on 4/15/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class User: NSObject {
  
  var name : String?
  var screenName : String?
  var profileUrl : URL?
  var headerUrl : URL?
  var tagline: String?
  var tweetCount: Int?
  var followingCount: Int?
  var followersCount: Int?
  
  var dictionary : NSDictionary?
  
  init(dictionary: NSDictionary){
    self.dictionary = dictionary
    print(self.dictionary)
    
    name = dictionary["name"] as? String
    screenName = dictionary["screen_name"] as? String
    
    let profileUrlString = dictionary["profile_image_url_https"] as? String
    if let profileUrlString = profileUrlString{
      profileUrl = URL(string:profileUrlString)
    }
    
    let headerUrlString = dictionary["profile_background_image_url_https"] as? String
    if let headerUrlString = headerUrlString{
      headerUrl = URL(string:headerUrlString)
      print("\(headerUrlString)")
    }else{
      headerUrl = nil
    }
    
    tagline = dictionary["description"] as? String
    
    tweetCount = dictionary["statuses_count"] as? Int
    
    followingCount = dictionary["friends_count"] as? Int
    
    followersCount = dictionary["followers_count"] as? Int
  }
  
  static let userDidLogoutNotification = "UserDidLogout"
  
  static var _currentUser: User?
  
  class var currentUser: User? {
    get {
      if _currentUser == nil {
        
        let defaults = UserDefaults.standard
        let userData = defaults.object(forKey: "currentUserData") as? Data
        
        if let userData = userData {
          print("\(userData)")
          let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
          _currentUser = User(dictionary: dictionary)
        }
      }
      
      return _currentUser
      
    } set(user) {
      
      _currentUser = user
      
      let defaults = UserDefaults.standard
      
      if let user = user {
        let userData = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
        defaults.set(userData, forKey: "currentUserData")
      } else {
        defaults.removeObject(forKey: "currentUserData")
      }
      
      defaults.synchronize()
    }
  }
  
}
