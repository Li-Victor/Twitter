//
//  ComposeViewController.swift
//  Twittter
//
//  Created by Victor Li on 10/2/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import UIKit
import AlamofireImage
import KMPlaceholderTextView

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?
    
    let characterLimit = 140

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var composeTextView: KMPlaceholderTextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var tweetButton: UIButton!
    
    @IBAction func onTapExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapPost(_ sender: Any) {
        if let text = composeTextView.text {
            APIManager.shared.composeTweet(with: text) { (tweet, error) in
                if let error = error {
                    print("Error composing Tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Compose Tweet Success!")
                    self.delegate?.did(post: tweet)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        let difference = characterLimit - newText.count
        characterCountLabel.text = "Character Count: \(difference)"
        
        if difference != characterLimit {
            tweetButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.631372549, blue: 0.9490196078, alpha: 1)
        } else {
            tweetButton.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.delegate = self
        userImage.layer.cornerRadius = 17.5
        userImage.af_setImage(withURL: (User.current?.profileImageURL)!)
        
        tweetButton.layer.cornerRadius = 12.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
