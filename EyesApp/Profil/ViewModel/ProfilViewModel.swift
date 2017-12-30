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

    init() {
        
    }
    
    func logout(){
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }
}
