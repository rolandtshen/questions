//
//  QuestionCell.swift
//  Questions
//
//  Created by Roland Shen on 7/11/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import Foundation
import UIKit
import ParseUI
import Parse
import ChameleonFramework
import Bond
import ReactiveKit

class QuestionCell: PFTableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var repliesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UIButton!
    @IBOutlet weak var categoryFlag: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var likeDisposable: Disposable?
    
    var post: Question? {
        didSet {
            likeDisposable?.dispose()
            if let post = post {
                likeDisposable = post.likes.observeNext(with: { (value) in
                    if let value = value {
                        self.likesLabel.text = self.numLikes(value)
                        self.likeButton.isSelected = value.contains(PFUser.current()!)
                        if value.count == 0 {
                            self.likeButton.setImage(UIImage(named: "like"), for: .normal)
                        } else {
                            self.likeButton.setImage(UIImage(named: "liked"), for: .normal)
                        }
                    } else {
                        self.likesLabel.text = "\(LikeHelper.getNumLikes(post))"
                        self.likeButton.isSelected = false
                        self.likeButton.setImage(UIImage(named: "like"), for: .normal)
                    }
                })
            }
        }
    }
    
    func numLikes(_ userList: [PFUser]) -> String {
        let likes = userList.count
        let stringLikes = String(likes)
        return stringLikes
    }
    
    @IBAction func userPressed(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        profileViewController.user = post?.user
//        self.presentViewController(profileViewController, animated:true, completion:nil)
    }
    
    @IBAction func likePressed(_ sender: AnyObject) {
        post!.toggleLikePost(PFUser.current()!)
    }
}
