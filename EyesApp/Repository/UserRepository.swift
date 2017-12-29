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
import Firebase
import FirebaseAuth
import UIKit

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
    
    func save(user : RestUser,imgeUser:UIImage?,completion: @escaping (Error?) -> Void)
    {
        // 1. reference to the database
        let ref = DBFireReference.users(uid: user.idUser!).reference()
        
        // 2. setValue of the reference
        ref.setValue(user.toDictionary())
        
        // 3. save the user's profile Image
        if let profileImage = imgeUser {
            let firImage = FIRImage(image: profileImage)
            firImage.saveProfileImage(user.idUser!, { (error) in
                // is caleld whenever the profile image is successfully uploaded - takes time!!!!!!
                completion(error)
            })
        }
    }
    
    

    
}
