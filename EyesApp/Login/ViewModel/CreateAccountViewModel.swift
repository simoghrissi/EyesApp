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
        var emailAdress = Variable<String>("")
        var firstName = Variable<String>("")
        var phoneNumber = Variable<String>("")
        var profilImageUrl = Variable<String>("")
        var profilImage = Variable<UIImage>(UIImage(named: "defaultProfileImage")!)
        var errorMessage = Variable<String>("")
        let repository = UserRepository()
        let isloaderHidden = Variable<Bool>(false)
    
    
    init(){
        
    }
    
    func createAccount(success:@escaping()->()){
        // 1. sign up a new account
        
        self.repository.create(email: self.emailAdress.value, password: self.password.value, success: { firstUser in
            
            if let firstUser = firstUser {
                self.changeProfilImage(idUser: firstUser.uid, success: {
                    self.saveUser(user: firstUser, imageUser: self.profilImage.value, success: {
                        success()
                    })
                })
            }
        }) { error in
            self.manageError(error: error)
        }
    }
    
    func saveUser(user: User,imageUser: UIImage,success:@escaping()->()){
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let newUser  = RestUser(idUser: user.uid, nomUser: self.lastName.value, prenomUser: self.firstName.value, mailUser: self.emailAdress.value, passwordUser: self.password.value, phoneUser: self.phoneNumber.value, dateCreateUser: "\(month)/\(day)/\(year)", nbrPointUser: "", adresse: nil,gender :"",profilePhotoUrl:self.profilImageUrl.value)
        
        self.repository.save(user: newUser)
        Auth.auth().signIn(withEmail: self.emailAdress.value, password: self.password.value,  completion: { (firUser, error) in
            if let error = error {
                self.manageError(error: error)
            }else{
                success()
            }
        })
//        self.repository.signIn(email: self.emailAdress.value, password: self.password.value, success: {
//            success()
//        })
//        { error in
//            self.manageError(error: error)
//        }
        
    }
    
    func changeProfilImage(idUser:String,success:@escaping()->()){
        
        let resizedImage = profilImage.value.resize()
        if let imageData = UIImageJPEGRepresentation(resizedImage, 0.9) {
            let ref = DBFireStorage.profileImages.reference().child(idUser)
            let putTask = ref.putData(imageData)
            putTask.observe(.success, handler: { (snapchot) in
                self.profilImageUrl.value = (snapchot.metadata?.downloadURL()?.absoluteString)!
                success()
            })
            //putTask.observe(.failure, handler: { errorSnapchot
              //  in
                //error(errorSnapchot as! Error)
            //})
        }
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

