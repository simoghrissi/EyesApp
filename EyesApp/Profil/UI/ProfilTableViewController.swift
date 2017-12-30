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
    
    var imagePicker = UIImagePickerController()

    let viewModel = ProfilViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupBinding()
    }

    @IBAction func saveAction(_ sender: Any) {

    }
    
    @IBAction func logoutAction(_ sender: Any) {
        viewModel.logout()
        Navigator.sharedInstance.navigateToMain(controller: self)
    }
    
    @IBAction func changeProfilAction(_ sender: Any) {
         UIAlertController.alertShowCamera(controller: self, imagePicker: imagePicker, imageView: profileImageView)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        profileImageView.contentMode = .scaleAspectFit //3
        profileImageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
        
        
    }
 
    func setupBinding(){
        
        _ = viewModel.errorMessage
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe{
                if $0.element != "" {
                    UIAlertController.okAlert(controller: self, title: "Error_title".localized, message: self.viewModel.errorMessage.value)
                }
        }
        
        emailText.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        viewModel.profilImage.asObservable()
        .bind(to: self.profileImageView.rx.image)
        .disposed(by: disposeBag)
        
        phoneText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.phone)
        .disposed(by: disposeBag)
        
        addressText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.address)
        .disposed(by: disposeBag)
        
        passwordText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.password)
        .disposed(by: disposeBag)
        
        birthDayText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.birthDay)
        .disposed(by: disposeBag)
        
        genderText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.gender)
        .disposed(by: disposeBag)
        
        firstNameText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.firstName)
        .disposed(by: disposeBag)
        
        lastNameText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.lastName)
        .disposed(by: disposeBag)
        
        
        
    }
    
}
