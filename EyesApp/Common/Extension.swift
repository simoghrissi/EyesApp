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
    func downloadedFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url)
    }
}

extension UIImage
{
    func resize() -> UIImage {
        let height: CGFloat = 1000.0
        let ratio = self.size.width / self.size.height
        let width = height * ratio
        
        let newSize = CGSize(width: width, height: height)
        let newRectangle = CGRect(x: 0, y: 0, width: width, height: height)
        
        // context - canvas
        UIGraphicsBeginImageContext(newSize)
        
        // draw the newly sized image on the canvas
        self.draw(in: newRectangle)
        
        // get the new size image into a new varibale
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // close the canvas
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}
