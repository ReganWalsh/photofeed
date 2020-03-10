//
//  FeedCell.swift
//  21.PhotoMedia
//
//  Created by Regan  Walsh on 29/02/20.
//  Copyright © 2020 Regan  Walsh. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FeedCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    
    @IBAction func likeClicked(_ sender: Any) {
        let firestore =  Firestore.firestore();
        if let likeCount = Int(likesLabel.text!) { 
            let likeStore = ["likes" : likeCount + 1] as [String : Any] //Add Like To Dictionary
            firestore.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true) //Then Merge In New Data

        }
    }
    
    @IBOutlet weak var likeClicked: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
