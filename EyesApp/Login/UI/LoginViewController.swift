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

class LoginViewController: UIViewController {

    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil {
                // just logged in successfully
                self.dismiss(animated: false, completion: nil)
            }
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
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
