//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Arsalan Saif on 3/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
       
        var favorited:Bool = false
        var retweeted:Bool = false
        var tweetId: Int = -1
        
        override func awakeFromNib() {
            super.awakeFromNib()
        }

        @IBAction func favoriteTweet(_ sender: UIButton) {
            let toBeFavorited = !favorited
            if (toBeFavorited) {
                TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {self.setFavorite(true)}, failure: { (error) in
                    print("Favorite did not succed: \(error)")
                })
            } else {
                TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {self.setFavorite(false)}, failure: { (error) in
                    print("Favorite did not succed: \(error)")
                })
            }
        }
        @IBAction func retweet(_ sender: UIButton) {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {self.setFavorite(false)}, failure: { (error) in
                print("Retweet did not succed: \(error)")
            })
        }
        
        func setFavorite(_ isFavorited:Bool) {
            favorited = isFavorited
            if (favorited) {
                favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
            } else {
                favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
            }
        }
        
        func setRetweet(_ isRetweeted:Bool) {
            retweeted = isRetweeted
            if (retweeted) {
                retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
                retweetButton.isEnabled = false
            } else {
                retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
                retweetButton.isEnabled = true
            }
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }

    }
