//
//  LoginViewModel.swift
//  EyesApp
//
//  Created by simo on 24/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {
    
    let disposeBag = DisposeBag()
    
    let repository  = UserRepository()
    
    init() {
        repository.getUser(idUser: 123, mailUser: "simo@gmail.com").subscribe(onNext:{ user in
            
            print(user)
        },onError:{ e in
            print(e)

            
        }).disposed(by: disposeBag)
    }
}
