//
//  LoginViewController.swift
//  EyesApp
//
//  Created by simo on 24/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {

    @IBOutlet weak var facebookLoginView: UIView!
    @IBOutlet weak var passwordText: DesignableTextField!
    @IBOutlet weak var emailText: DesignableTextField!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    let loginButton = FBSDKLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        loginButton.delegate = self
        
       facebookLoginView.addSubview(loginButton)
        loginButton.frame = CGRect(x: 0, y: 0, width:facebookLoginView.frame.width , height: facebookLoginView.frame.height)
       setupBinding()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        viewModel.signIn{
            Navigator.sharedInstance.navigateToMain(controller: self)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        viewModel.signInWithFB {
            Navigator.sharedInstance.navigateToMain(controller: self)

        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil{
            viewModel.signInWithFB {
                Navigator.sharedInstance.navigateToMain(controller: self)
                
            }
        }
       
    }
    @IBAction func loginWithFaceBookAction(_ sender: Any) {
//        func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            // ...
//        }
        
    }
    
    func setupBinding(){
        
        passwordText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.password)
        .disposed(by: disposeBag)
        
        emailText.rx.text.map{$0 ?? ""}
        .bind(to: viewModel.emailAdress)
        .disposed(by: disposeBag)
        
        _ = viewModel.errorMessage
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe{
                if $0.element != "" {
                    UIAlertController.okAlert(controller: self, title: "Error_title".localized, message: self.viewModel.errorMessage.value)
                }
        }
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
       
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
