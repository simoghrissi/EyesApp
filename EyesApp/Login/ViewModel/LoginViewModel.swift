//
//  LoginViewModel.swift
//  EyesApp
//
//  Created by simo on 24/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class LoginViewModel {

    var password = Variable<String>("")
    var emailAdress = Variable<String>("")
    var errorMessage = Variable<String>("")
    var phone = Variable<String>("")
    var address = Variable<String>("")
    var birthDay = Variable<String>("")
    var gender = Variable<String>("")
    var email = Variable<String>("")
    var lastName = Variable<String>("")
    var firstName = Variable<String>("")
    var profilImageUrl = Variable<String>("")
    let disposeBag = DisposeBag()
    let repository  = UserRepository()
    
    init() {
        repository.getUser(idUser: 123, mailUser: "simo@gmail.com").subscribe(onNext:{ user in
            
            print(user)
        },onError:{ e in
            print(e)

            
        }).disposed(by: disposeBag)
    }
    
    
    func signInWithFB(success:@escaping()->())
    {
        
        if let token = FBSDKAccessToken.current() {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email , gender ,address, birthday"]).start(completionHandler: { _ , result ,error  in
                if error != nil{
                    return
                }else{
                    
                    if let value = result as? [String:Any] {
                        self.email.value = value["email"] as? String ?? ""
                        self.lastName.value = value["last_name"] as? String ?? ""
                        self.firstName.value = value["first_name"] as? String ?? ""
                        self.phone.value = value["phoneUser"] as? String ?? ""
                        self.gender.value = value["gender"] as? String ?? ""
                        self.birthDay.value = value["birthday"] as? String ?? ""
                        self.address.value = value["address"] as? String ?? ""
                        if let picture = value["picture"] as? Dictionary<String,Any> {
                            if let data = picture["data"] as? Dictionary<String,Any> {
                                if let pictureUrl = data["url"] as? String {
                                    self.profilImageUrl.value = pictureUrl
                                }
                            }
                        }
                    }
                    let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                    Auth.auth().signIn(with: credential) { (user, error) in
                        if let error = error {
                            print(error)
                            return
                        }else{
                            
                            let user = Auth.auth().currentUser
                            
                            if let user = user {
                                let ref = DBFireReference.users(uid: user.uid).reference()
                                
                                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                                    // Get user value
                                    let value = snapshot.value as? NSDictionary
                                    let idUser = value?["idUser"] as? String ?? ""
                                    if idUser.isEmpty{
                                        let date = Date()
                                        let calendar = Calendar.current
                                        let year = calendar.component(.year, from: date)
                                        let month = calendar.component(.month, from: date)
                                        let day = calendar.component(.day, from: date)
                                        let newUser  = RestUser(idUser: (user.uid), nomUser: self.lastName.value, prenomUser: self.firstName.value, mailUser: self.emailAdress.value, passwordUser: self.password.value, phoneUser: self.phone.value, dateCreateUser: "\(month)/\(day)/\(year)", nbrPointUser: "",adresse:nil, gender :self.gender.value, profilePhotoUrl:self.profilImageUrl.value,birthDayUser:"", isFromFB:true )
                                        self.repository.save(user: newUser)
                                    }
                                    success()
                                    
                                }) { (error) in
                                    print(error.localizedDescription)
                                }
                                
                            }
                           }
                        
                    }
                    
                }
                
            })
            
        }
    }
    
    
    func signIn(success:@escaping()->()){
        Auth.auth().signIn(withEmail: self.emailAdress.value, password: self.password.value,  completion: { (firUser, error) in
            if let error = error {
                self.manageError(error: error)
            }else{
                success()
            }
        })
    }
    
    func manageError(error e: Error?) {
        if let e = e as? ApiError {
            switch (e) {
            case .KO_TECHNIQUE:
                errorMessage.value = "technical_error".localized
                break
            }
        } else {
            errorMessage.value = "technical_error".localized
        }
    }
}
