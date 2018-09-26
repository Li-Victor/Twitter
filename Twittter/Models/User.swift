//
//  User.swift
//  Twittter
//
//  Created by Victor Li on 9/25/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import Foundation

struct User {
    static var current: User?
    
    let name: String!
    let screenName: String!
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
    }
}
