//
//  CreateAccountViewModel.swift
//  EyesApp
//
//  Created by simo on 28/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import RxSwift
import Firebase
import FirebaseAuth

class CreateAccountViewModel{

        var lastName = Variable<String>("")
        var password = Variable<String>("")
        var firstName = Variable<String>("")
        var emailAdress = Variable<String>("")
        var phoneNumber = Variable<String>("")
        var imageUser = Variable<UIImage>(UIImage(named: "loginIcon")!)
    
        let repository = UserRepository()
    
    init(){
        
    }
    
    func createAccount(){
        // 1. sign up a new account
        Auth.auth().createUser(withEmail: self.emailAdress.value, password: self.password.value, completion: { (firUser, error) in
            
            if error != nil {
                // ERROR - report
                print(error)
                
            } else if let firUser = firUser {
                let date = Date()
                let calendar = Calendar.current
                
                let year = calendar.component(.year, from: date)
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                // 2. save the user's information -- User class!!!
                let newUser  = RestUser(idUser: firUser.uid, nomUser: self.lastName.value, prenomUser: self.firstName.value, mailUser: self.emailAdress.value, passwordUser: self.password.value, phoneUser: self.phoneNumber.value, dateCreateUser: "\(month)/\(day)/\(year)", nbrPointUser: "", adresse: nil)
                
                self.repository.save(user: newUser, imgeUser: self.imageUser.value, completion: { (error) in
                    if error != nil {
                        print(error)
                    } else {
                        
                        // SUCCESSFULLY SIGNED UP A NEW ACCOUNT!
                        // 3. log in the user to use the app
                        Auth.auth().signIn(withEmail: self.emailAdress.value, password: self.password.value, completion: { (firUser, error) in
                            
                            if let error = error {
                                print(error)
                            } else {
                                print("SUCCESS SIGN IN")
                            }
                        })
                    }
                })
            }
        })
        
    }
    
}

