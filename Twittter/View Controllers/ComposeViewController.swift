//
//  ComposeViewController.swift
//  Twittter
//
//  Created by Victor Li on 10/2/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController {
    
    weak var delegate: ComposeViewControllerDelegate?

    @IBOutlet weak var composeTextField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBAction func onTapExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapPost(_ sender: Any) {
        if let text = composeTextField.text {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.af_setImage(withURL: (User.current?.profileImageURL)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
