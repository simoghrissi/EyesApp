//
//  FIRImage.swift
//  EyesApp
//
//  Created by simo on 28/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class FIRImage
{
    var image: UIImage
    var downloadURL: URL?
    var downloadURLString: String!
    var ref: StorageReference!
    
    init(image: UIImage) {
        self.image = image
    }
    
    func saveProfileImage(_ userUID: String, _ completion: @escaping (Error?) -> Void)
    {
        let resizedImage = image.resize()
        if let imageData = UIImageJPEGRepresentation(resizedImage, 0.9) {
            // 1. get the reference
            ref = DBFireStorage.profileImages.reference().child(userUID)
            downloadURLString = ref.description
            
            // 2. save that data to the reference
            ref.putData(imageData, metadata: nil, completion: { (metaData, error) in
                completion(error)
            })
        }
    }
    
}

