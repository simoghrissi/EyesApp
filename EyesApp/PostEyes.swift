//
//  PostEyes.swift
//  EyesApp
//
//  Created by simo on 03/09/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit

class PostEyes{
    

    var imageProfil: UIImage? = nil
    var nameProfil: String = ""
    var postImage: UIImage? = nil
    var description: String = ""
    
    init() {}
    init?(imageProfil: UIImage?, nameProfil: String, postImage: UIImage?,description:String) {
        
        // Initialize stored properties.
        self.nameProfil = nameProfil
        self.description = description
        
        if imageProfil != nil{
            self.imageProfil = imageProfil
        }else{
            self.imageProfil =  UIImage(named: "defaultImage")
        }
        
        if postImage != nil{
            self.postImage = postImage
        }else{
            self.postImage =  UIImage(named: "defaultImage")
        }
        
        
        
    }

    
    
}
