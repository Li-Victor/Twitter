//
//  TweetCell.swift
//  Twittter
//
//  Created by Victor Li on 9/26/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetUserImage: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetDateLabel: UILabel!
    @IBOutlet weak var tweetUsernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBAction func didTapRetweet(_ sender: Any) {
        let userRetweeted = tweet.retweeted ? false : true
        if userRetweeted {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text). Tweeted: \(tweet.retweeted)")
                    self.tweet = tweet
                }
            }
        } else {
            // user unretweet
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text). Tweeted: \(tweet.retweeted)")
                    self.tweet = tweet
                    // Response is not consistent for untweeting. But in real twitter app, the tweet is unretweeted
                    self.tweet.retweeted = false
                    self.tweet.retweetCount -= 1
                }
            }
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        let userFavorited = tweet.favorited ? false : true
        if userFavorited {
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.tweet = tweet
                }
            }
        } else {
            APIManager.shared.unFavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    self.tweet = tweet
                }
            }
        }
    }
    
    var tweet: Tweet! {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        tweetUserImage.af_setImage(withURL: tweet.user.profileImageURL)
        tweetScreenNameLabel.text = "@\(tweet.user.screenName)"
        tweetDateLabel.text = tweet.createdAtString
        tweetUsernameLabel.text = tweet.user.name
        tweetTextLabel.text = tweet.text
        
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
        
        retweetCountLabel.text = String(tweet.retweetCount)
        favoriteCountLabel.text = String(tweet.favoriteCount)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        tweetUserImage.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
