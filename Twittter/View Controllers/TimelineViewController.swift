//
//  TimelineViewController.swift
//  Twittter
//
//  Created by Victor Li on 9/25/18.
//  Copyright © 2018 Victor Li. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    
    private var tweets: [Tweet] = [] {
        didSet {
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }

    
    @IBAction func onLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    @objc private func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchTweets()
    }
    
    private func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets: [Tweet]?, error: Error?) in
            if let tweets = tweets {
                self.tweets = tweets
            } else {
                print(error?.localizedDescription ?? "Error in the function fetchTweets TimeViewController")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 155
        
        // add refresh control on top of tableView
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimelineViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        fetchTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
