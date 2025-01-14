//
//  QuestionHeaderView.swift
//  Questions
//
//  Created by Roland Shen on 7/20/16.
//  Copyright © 2016 Roland Shen. All rights reserved.
//

import UIKit
import Parse

class QuestionImageHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var repliesLabel: UILabel!
    
    var poster: PFUser?
    
    @IBAction func messagePressed(_ sender: AnyObject) {
        let newConvo = Conversation()
        newConvo.fromUser = PFUser.current()
        newConvo.toUser = poster
        newConvo.saveInBackground()
    }
}
