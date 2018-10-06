//
//  ProfileViewController.swift
//  Twittter
//
//  Created by Victor Li on 10/2/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateJoinedLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = User.current!
        
        if let profileBannerPath = user.profileBannerPath {
            let profileBannerURL = URL(string: profileBannerPath)!
            bannerImageView.af_setImage(withURL: profileBannerURL)
        } else {
            bannerImageView.image = UIImage(named: "default_profile_banner")
        }
        
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderWidth = 3.5
        userImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2
        
        userImageView.af_setImage(withURL: user.profileImageURL)
        nameLabel.text = user.name
        screenNameLabel.text = "@\(user.screenName)"
        descriptionLabel.text = user.description
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        let date = formatter.date(from: user.dateJoined)!
        formatter.dateFormat = "LLLL YYYY"
        
        dateJoinedLabel.text = "Joined \(formatter.string(from: date))"
        
        followingCountLabel.text = "\(user.followingCount) Following"
        followersCountLabel.text = "\(user.followersCount) Followers"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
