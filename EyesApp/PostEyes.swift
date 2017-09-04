//
//  PostEyes.swift
//  EyesApp
//
//  Created by simo on 03/09/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit

class PostEyes{
    

    var imageProfil: UIImage?
    var nameProfil: String
    var postImage: UIImage?
    var description: String
    
    init?(imageProfil: UIImage?, nameProfil: String, postImage: UIImage?,description:String) {

               // Initialize stored properties.
        self.nameProfil = nameProfil
        self.description = description
        if imageProfil == nil{
            self.imageProfil = UIImage(named: "defaultImage")
        }else{
            self.imageProfil = imageProfil

        }
        // TODO traité le cas ou le post est null
        if postImage == nil{
            self.postImage = UIImage(named: "defaultImage")
        }else{
            self.postImage = postImage

        }

        
    }
    
}
