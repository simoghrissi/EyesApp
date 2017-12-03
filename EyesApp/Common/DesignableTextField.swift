//
//  DesignableTextField.swift
//  Particuliers
//
//  Created by Engie Mobility on 30/06/2017.
//  Copyright © 2017 Engie Mobility. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPaddingImage: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightPaddingImage: CGFloat = 200 {
        didSet {
            updateView()
        }
    }
    
    var rightImageView: UIImageView?
    var rightViewButton: UIButton?
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: leftPaddingImage, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select
            // the image in the Assets.xcassets and change the "Render As" property to
            // "Template Image".
            imageView.tintColor = color
            
            var width = leftPadding + 20
            
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width = width + 5
            }
            
            let view = UIView(frame: CGRect(x:0, y:0, width: width, height:20))
            view.addSubview(imageView)
            leftView = view
            
        } else {
            leftViewMode = UITextFieldViewMode.always
            var width = leftPadding
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width = width + 5
            }
            
            let view = UIView(frame: CGRect(x:0, y:0, width: width, height:20))
            leftView = view
        }
        
        if let image = rightImage {
            rightViewMode = UITextFieldViewMode.always
            self.rightImageView = UIImageView(frame: CGRect(x: rightPaddingImage, y: 0, width: 20, height: 20))
            self.rightImageView?.image = image
            self.rightImageView?.image = self.rightImageView?.image!.withRenderingMode(.alwaysTemplate)
            self.rightImageView?.tintColor = UIColor.red
            let width = rightPadding + 20
                
            self.rightViewButton = UIButton(frame: CGRect(x:0, y:0, width: width, height:20))
            self.rightViewButton?.setImage(self.rightImageView?.image, for: .normal)
           // self.rightViewButton?.tintColor = type.Color.lightGrey2
            //self.rightViewButton?.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
            rightView = self.rightViewButton
            rightView?.isHidden = true
        } else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string:
            placeholder != nil ?
                placeholder! : "", attributes:[NSForegroundColorAttributeName: color])
    }

//    func showPassword() {
//        if self.isSecureTextEntry {
//            self.rightViewButton?.tintColor = Style.Color.blue
//            self.isSecureTextEntry = false
//        } else {
//            self.rightViewButton?.tintColor = Style.Color.lightGrey2
//            self.isSecureTextEntry = true
//            
//        }
//    }
}
