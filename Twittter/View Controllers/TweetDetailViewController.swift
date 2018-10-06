//
//  TweetDetailViewController.swift
//  Twittter
//
//  Created by Victor Li on 10/1/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import UIKit
import AlamofireImage
import TTTAttributedLabel

class TweetDetailViewController: UIViewController, TTTAttributedLabelDelegate {

    @IBOutlet weak var tweetUserImageView: UIImageView!
    @IBOutlet weak var tweetUsernameLabel: UILabel!
    @IBOutlet weak var tweetUserScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: TTTAttributedLabel!
    @IBOutlet weak var tweetDateLabel: UILabel!
    @IBOutlet weak var tweetRetweetsLabel: UILabel!
    @IBOutlet weak var tweetLikesLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetUserImageView.layer.cornerRadius = 25
        tweetUserImageView.af_setImage(withURL: tweet.user.profileImageURL)
        tweetUserScreenNameLabel.text = "@\(tweet.user.screenName)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        let date = formatter.date(from: tweet.createdAtString)!
        formatter.dateFormat = "M/d/yy, h:mm a"
        
        tweetDateLabel.text = formatter.string(from: date)
        tweetUsernameLabel.text = tweet.user.name
        
        // Clickable Links in Tweets
        tweetTextLabel.delegate = self
        tweetTextLabel.enabledTextCheckingTypes = NSTextCheckingResult.CheckingType.link.rawValue
        tweetTextLabel.text = tweet.text
        tweetLikesLabel.text = "\(tweet.favoriteCount) Likes"
        
        if tweet.retweetCount == 0 {
            tweetRetweetsLabel.text = " "
        } else {
            tweetRetweetsLabel.text = "\(tweet.retweetCount) Retweets"
        }
        
        if tweet.favorited {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon-1"), for: .normal)
        }
        
        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
