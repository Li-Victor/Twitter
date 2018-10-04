//
//  User.swift
//  Twittter
//
//  Created by Victor Li on 9/25/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import Foundation

struct User {
    private static var _current: User?
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    let name: String
    let screenName: String
    let profileImageURL: URL
    let description: String
    let tweetsCount: Int
    let followersCount: Int
    let followingCount: Int
    let dateJoined: String
    let profileBannerPath: String?
    
    let dictionary: [String: Any]
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        description = dictionary["description"] as! String
        tweetsCount = dictionary["statuses_count"] as! Int
        followersCount = dictionary["followers_count"] as! Int
        followingCount = dictionary["friends_count"] as! Int
        dateJoined = dictionary["created_at"] as! String
        profileBannerPath = dictionary["profile_banner_url"] as? String
        
        var profileImagePath = dictionary["profile_image_url_https"] as! String
        profileImagePath = profileImagePath.replacingOccurrences(of: "_normal", with: "_bigger")
        profileImageURL = URL(string: profileImagePath)!
    }
}
