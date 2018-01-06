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

class LoginViewModel {

    var password = Variable<String>("")
    var emailAdress = Variable<String>("")
    var errorMessage = Variable<String>("")

    let disposeBag = DisposeBag()
    let repository  = UserRepository()
    
    init() {
        repository.getUser(idUser: 123, mailUser: "simo@gmail.com").subscribe(onNext:{ user in
            
            print(user)
        },onError:{ e in
            print(e)

            
        }).disposed(by: disposeBag)
    }
    
    func signIn(success:@escaping()->()){
        repository.signIn(email: self.emailAdress.value, password: self.password.value, success: {
            success()
        }) { error in
            self.manageError(error: error)
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
