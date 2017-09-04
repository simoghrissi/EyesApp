//
//  CameraViewController.swift
//  EyesApp
//
//  Created by simo on 22/08/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit

protocol loadDataDelegate {
    
func addDataToTm(imageProfil:UIImage?,nameProfil:String,postImage:UIImage?,description:String)
}
class CameraViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var postPopup: UIView!
    @IBOutlet weak var imagePopup: UIImageView!
    @IBOutlet weak var imageTaken: UIImageView!
    @IBOutlet weak var textPost: UITextField!
    var imagePicker = UIImagePickerController()
    var delegate :loadDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func takePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
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
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    //MARK: - Delegates
     func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imageTaken.contentMode = .scaleAspectFit //3
        imageTaken.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
        showPopup()
            
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chosePost(_ sender: Any) {
        if delegate != nil{
            delegate?.addDataToTm(imageProfil: nil, nameProfil: "simo", postImage: imageTaken.image, description: self.textPost.text ?? "")
        }

        removePopup()
    }
    @IBAction func closePopup(_ sender: Any) {
        removePopup()
    }
    
    
    
    func showPopup()
    {
        self.view.addSubview(self.postPopup)
        self.postPopup.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.postPopup.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.postPopup.alpha = 1.0
            self.postPopup.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.postPopup.center = self.view.center
        })
        self.imagePopup.image = imageTaken.image
           }
    
    func removePopup()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.postPopup.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.postPopup.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParentViewController: nil)
                self.postPopup.removeFromSuperview()
                self.navigationController?.popViewController(animated: true)

            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
