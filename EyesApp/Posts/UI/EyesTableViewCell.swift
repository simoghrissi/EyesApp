//
//  EyesTableViewCell.swift
//  EyesApp
//
//  Created by simo on 03/09/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit

class EyesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageProfilCell: UIImageView!
    @IBOutlet weak var nameProfilCell: UILabel!
    @IBOutlet weak var postImageCell: UIImageView!
    @IBOutlet weak var descriptionCell: UILabel!
    
    var post: PostEyes! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        
        imageProfilCell.image = post.imageProfil
        imageProfilCell.layer.cornerRadius = imageProfilCell.bounds.width / 2.0
        imageProfilCell.layer.masksToBounds = true
        
        descriptionCell.text = post.description
        nameProfilCell.text = post.nameProfil
        postImageCell.image = post.postImage

    }
}
