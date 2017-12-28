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
import Firebase

class CreateAccountTableViewController: UITableViewController {

    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginText: DesignableTextField!
    @IBOutlet weak var passwordText: DesignableTextField!
    @IBOutlet weak var fullNameText: DesignableTextField!
    @IBOutlet weak var emailAdressText: DesignableTextField!
    
    let viewModel = CreateAccountViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    @IBAction func createAccountAction(_ sender: Any) {
     
        
    }
    
    func setupBinding(){
        
        emailAdressText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.emailAdress)
        .disposed(by: disposeBag)
        
        loginText.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.login)
            .disposed(by: disposeBag)
        
        passwordText.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        fullNameText.rx.text.map{$0 ?? ""}
            .bind(to: viewModel.fullName)
            .disposed(by: disposeBag)
        
    }
}
