//
//  UIAlertView.swift
//  Particuliers
//
//  Created by simo on 16/10/2017.
//  Copyright © 2017 Engie Mobility. All rights reserved.
//

import UIKit
extension UIAlertController{
    
    class func callService(phoneNumber:String){
        let number: String = "tel://00-00-00-00-00"
        if let url = URL(string: number) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    class func simpleCallAlert(controller : UIViewController,phoneNumber:String,message:String){
        let alert = UIAlertController(title: phoneNumber, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "annuler".localized, style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "appeler".localized, style: UIAlertActionStyle.default, handler: { action in
            self.callService(phoneNumber: phoneNumber)
            
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    
    class func infoAlertMessage(controller : UIViewController,title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        controller.present(alert, animated: true, completion: nil)
    
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    class func alertShowCamera(controller : UIViewController,imagePicker : UIImagePickerController,imageView:UIImageView){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "from_library".localized, style: UIAlertActionStyle.default, handler: { action in
            openPhotoLibrary()
            
        }))
        
        alert.addAction(UIAlertAction(title: "take_photo".localized, style: UIAlertActionStyle.default, handler: { action in
            showCamera()
            
        }))
        
        alert.addAction(UIAlertAction(title: "delete_photo".localized, style: UIAlertActionStyle.destructive, handler: { action in
            imageView.image = UIImage(named: "defaultProfileImage")
            
        }))
        alert.addAction(UIAlertAction(title: "cancel".localized, style: UIAlertActionStyle.cancel, handler: { action in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        controller.present(alert, animated: true, completion: nil)

        func openPhotoLibrary() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                controller.present(imagePicker, animated: true, completion: nil)
            }
        }
        func showCamera(){
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.cameraCaptureMode = .photo
                imagePicker.modalPresentationStyle = .fullScreen
                controller.present(imagePicker,animated: true,completion: nil)
            } else {
                noCamera()
            }
        }
        
        func noCamera(){
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device has no camera",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "OK",
                style:.default,
                handler: nil)
            alertVC.addAction(okAction)
            controller.present(
                alertVC,
                animated: true,
                completion: nil)
        }
        func saveImageInlibrary() {
            let imageData = UIImageJPEGRepresentation(imageView.image!, 0.6)
            let compressedJPGImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        }
    }
    
    
    class func okAlert(controller: UIViewController, title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok_message".localized, style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    class func okAlertWithPopToRoot(controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok_message".localized, style: UIAlertActionStyle.default, handler: {_ in
            controller.navigationController?.popToRootViewController(animated: true)
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    class func okAlertWithPop(controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok_message".localized, style: UIAlertActionStyle.default, handler: {_ in
            controller.navigationController?.popViewController(animated: true)
        }))
        controller.present(alert, animated: true, completion: nil)
    }
}
