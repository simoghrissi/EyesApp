//
//  ProfilTableViewController.swift
//  EyesApp
//
//  Created by simo on 30/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfilTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var phoneText: DesignableTextField!
    @IBOutlet weak var addressText: DesignableTextField!
    @IBOutlet weak var passwordText: DesignableTextField!
    @IBOutlet weak var birthDayText: DesignableTextField!
    @IBOutlet weak var genderText: DesignableTextField!
    @IBOutlet weak var emailText: DesignableTextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    let defaultImage = UIImage(named: "defaultProfileImage")!

    var imagePicker = UIImagePickerController()

    var viewModel:ProfilViewModel?
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        viewModel = ProfilViewModel()
        setupBinding()
    }

    @IBAction func saveAction(_ sender: Any) {
        self.viewModel?.profilImage.value = self.profileImageView.image ?? self.defaultImage
        viewModel?.updateUserInfo()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        viewModel?.logout()
        self.performSegue(withIdentifier: "logout", sender: sender)
    }
    
    @IBAction func changeProfilImageAction(_ sender: Any) {
        UIAlertController.alertShowCamera(controller: self, imagePicker: imagePicker, imageView: profileImageView)
//        profileImageView.rx.observe(UIImage.self, "image")
//            .map({$0 ?? self.defaultImage})
//            .bind(to: (viewModel?.profilImage)!)
//            .dispose()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage 
        profileImageView.image = profileImageView.circleImage(image: chosenImage)
        dismiss(animated:true, completion: nil)
    }
 
    func setupBinding(){

        _ = viewModel?.errorMessage
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe{
                if $0.element != "" {
                    UIAlertController.okAlert(controller: self, title: "Error_title".localized, message: (self.viewModel?.errorMessage.value)!)
                }
        }

        viewModel?.email.asObservable()
        .bind(to: self.emailText.rx.text)
        .disposed(by: disposeBag)
        
        emailText.rx.text.map{$0 ?? ""}
            .bind(to: (viewModel?.email)!)
            .disposed(by: disposeBag)

        viewModel?.profilImage.asObservable()
        .bind(to: self.profileImageView.rx.image)
        .disposed(by: disposeBag)

        
        viewModel?.profilImage.asObservable().subscribe({ image in
            self.profileImageView.image =  self.profileImageView.circleImage(image: image.element!)
        }).disposed(by: disposeBag)
        
            viewModel?.phone.asObservable()
            .bind(to: self.phoneText.rx.text)
            .disposed(by: disposeBag)

        phoneText.rx.text.map{$0 ?? ""}
            .bind(to: (viewModel?.phone)!)
        .disposed(by: disposeBag)

        viewModel?.address.asObservable()
            .bind(to: self.addressText.rx.text)
            .disposed(by: disposeBag)
        
        addressText.rx.text.map{$0 ?? ""}
            .bind(to: (viewModel?.address)!)
        .disposed(by: disposeBag)

        viewModel?.password.asObservable()
            .bind(to: self.passwordText.rx.text)
            .disposed(by: disposeBag)
        
        passwordText.rx.text.map{$0 ?? ""}
            .bind(to: (viewModel?.password)!)
        .disposed(by: disposeBag)
        
        
        viewModel?.birthDay.asObservable()
            .bind(to: self.birthDayText.rx.text)
            .disposed(by: disposeBag)

        birthDayText.rx.text.map{$0 ?? ""}
            .bind(to: (viewModel?.birthDay)!)
        .disposed(by: disposeBag)
        
        viewModel?.gender.asObservable()
            .bind(to: self.genderText.rx.text)
            .disposed(by: disposeBag)

        genderText.rx.text.map{$0 ?? ""}
            .bind(to: (viewModel?.gender)!)
        .disposed(by: disposeBag)
        
        viewModel?.firstName.asObservable()
            .bind(to: self.firstNameText.rx.text)
            .disposed(by: disposeBag)

        firstNameText.rx.text.map{$0 ?? ""}
            .bind(to: (viewModel?.firstName)!)
        .disposed(by: disposeBag)
        
        viewModel?.lastName.asObservable()
            .bind(to: self.lastNameText.rx.text)
            .disposed(by: disposeBag)

        lastNameText.rx.text.map{$0 ?? ""}
            .bind(to: (viewModel?.lastName)!)
        .disposed(by: disposeBag)



    }
    
}
