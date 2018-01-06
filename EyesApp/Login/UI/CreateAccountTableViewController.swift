//
//  CreateAccountTableViewController.swift
//  EyesApp
//
//  Created by simo on 28/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CreateAccountTableViewController: UITableViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var phoneNumberText: DesignableTextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var lastNameText: DesignableTextField!
    @IBOutlet weak var passwordText: DesignableTextField!
    @IBOutlet weak var firstNameText: DesignableTextField!
    @IBOutlet weak var emailAdressText: DesignableTextField!
    let defaultImage = UIImage(named: "defaultProfileImage")!

    let viewModel = CreateAccountViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    @IBAction func changeProfileImageAction(_ sender: Any) {
        self.viewModel.profilImage.value = self.userImageView.image ?? self.defaultImage
    }
    @IBAction func createAccountAction(_ sender: Any) {
        viewModel.createAccount{
            Navigator.sharedInstance.navigateToMain(controller: self)
        }
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
        
        emailAdressText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.emailAdress)
        .disposed(by: disposeBag)
        
        phoneNumberText.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.phoneNumber)
            .disposed(by: disposeBag)
        
        lastNameText.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.lastName)
            .disposed(by: disposeBag)
        
        passwordText.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        firstNameText.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.firstName)
            .disposed(by: disposeBag)
        
        viewModel.profilImage.asObservable()
        .bind(to: self.userImageView.rx.image)
        .disposed(by: disposeBag)
        
        viewModel.profilImage.asObservable().subscribe({ image in
            self.userImageView.image =  self.userImageView.circleImage(image: image.element!)
        }).disposed(by: disposeBag)
        
        
    }
}
