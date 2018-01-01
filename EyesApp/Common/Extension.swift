//
//  Extension.swift
//  EyesApp
//
//  Created by simo on 31/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func circleImage(image :UIImage)-> UIImage{

        self.image = image
        self.layer.cornerRadius = self.bounds.width / 2.0
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        return image
    }
}
