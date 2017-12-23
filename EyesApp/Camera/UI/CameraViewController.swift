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
class CameraViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate {

    @IBOutlet var postPopup: UIView!
    @IBOutlet weak var imagePopup: UIImageView!
    @IBOutlet weak var imageTaken: UIImageView!
    @IBOutlet weak var textPost: UITextField!
    var imagePicker = UIImagePickerController()
    var delegate :loadDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        showCamera()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        movePopup(postPopup, moveDistance: -50, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        movePopup(postPopup, moveDistance: -50, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

   func showCamera(){
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
    @IBAction func takePhoto(_ sender: Any) {

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
           // DBManager.putPostInData(imageProfil: nil, nameProfil: "simo", postImage: imageTaken.image, description: self.textPost.text ?? "")
        }

        removePopup()
    }
    @IBAction func closePopup(_ sender: Any) {
        removePopup()
    }
    func showPopup()
    {
        self.view.addSubview(self.postPopup)
        self.view.backgroundColor = UIColor.lightGray
        self.postPopup.layer.cornerRadius = 5
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.postPopup.center  = self.view.center
        }, completion: { (completed) in
            self.imagePopup.image = self.imageTaken.image
            
        })

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
    
    
    
    // Move the text field in a pretty animation!
    func movePopup(_ view: UIView, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
                UIView.beginAnimations("popup", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
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
