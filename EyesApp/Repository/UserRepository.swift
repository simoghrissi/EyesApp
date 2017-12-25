//
//  UserRepository.swift
//  EyesApp
//
//  Created by simo on 24/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

public protocol UserRepositoryProtocol {
    func getUser(idUser: Int, mailUser: String) -> Observable<RestUser>
}

public final class UserRepository: UserRepositoryProtocol {
    
    let userRepositoryProtocol: UserNetworkProtocol = UserNetwork()
    
    init() {
        
    }
    
    public func getUser(idUser: Int, mailUser: String) -> Observable<RestUser> {
        let post: RestBaseParams = RestBaseParams(idUser: idUser, mailUser: mailUser)
        return userRepositoryProtocol.getUser(post: post)
    }
}
