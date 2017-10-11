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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
