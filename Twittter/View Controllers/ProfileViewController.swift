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
        userImageView.af_setImage(withURL: user.profileImageURL)
        nameLabel.text = user.name
        screenNameLabel.text = user.screenName
        descriptionLabel.text = user.description
        dateJoinedLabel.text = "Joined \(user.dateJoined)"
        followingCountLabel.text = "\(user.followingCount) Following"
        followersCountLabel.text = "\(user.followersCount) Followers"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
