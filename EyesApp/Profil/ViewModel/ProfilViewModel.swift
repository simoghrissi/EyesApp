//
//  ProfilViewModel.swift
//  EyesApp
//
//  Created by simo on 30/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfilViewModel {
    
    var profilImage = Variable<UIImage>(UIImage(named: "defaultProfileImage")!)
    var phone = Variable<String>("")
    var address = Variable<String>("")
    var password = Variable<String>("")
    var birthDay = Variable<String>("")
    var gender = Variable<String>("")
    var email = Variable<String>("")
    var lastName = Variable<String>("")
    var firstName = Variable<String>("")
    var errorMessage = Variable<String>("")
    var profilImageUrl = Variable<String>("")
    var isFromFB = Variable<Bool>(false)
    
    let repository = UserRepository()
    let firebaseAuth = Auth.auth()

    init() {
        let user = firebaseAuth.currentUser

        if let user = user {
            let ref = DBFireReference.users(uid: user.uid).reference()
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                self.email.value = value?["mailUser"] as? String ?? ""
                self.lastName.value = value?["nomUser"] as? String ?? ""
                self.firstName.value = value?["prenomUser"] as? String ?? ""
                self.phone.value = value?["phoneUser"] as? String ?? ""
                self.gender.value = value?["gender"] as? String ?? ""
                self.birthDay.value = value?["birthDay"] as? String ?? ""
                self.password.value = value?["passwordUser"] as? String ?? ""
                self.address.value = value?["address"] as? String ?? ""
                self.profilImageUrl.value = value?["profilePhotoUrl"] as? String ?? ""
                self.isFromFB.value = value?["isFromFB"] as?  Bool ?? false

            }) { (error) in
                print(error.localizedDescription)
            }
            
            if !isFromFB.value{
                let refStrorage = DBFireStorage.profileImages.reference().child((user.uid))
                
                refStrorage.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let _ = error {
                        self.profilImage.value = UIImage(named: "defaultProfileImage")!
                    } else {
                        let imageProfile = UIImage(data: data!)
                        self.profilImage.value  = imageProfile!
                    }
                }
            }
        }
    }
    
    func logout(){
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

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
            putTask.observe(.failure, handler: { errorSnapchot
              in
            self.manageError(error: errorSnapchot as? Error)
            })
        }
    }
    
    func updateUserInfo(){
        
      let user = firebaseAuth.currentUser
        self.changeProfilImage(idUser: (user?.uid)!, success: {
            let restUser = RestUser(idUser: (user?.uid)!, nomUser: self.lastName.value, prenomUser: self.firstName.value, mailUser: self.email.value, passwordUser: self.password.value, phoneUser: self.phone.value, adresse: nil, gender: self.gender.value,profilePhotoUrl: self.profilImageUrl.value,birthDayUser:self.birthDay.value)
            self.repository.update(user: restUser)
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
