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
    
    func create(email:String,password:String,success:@escaping(User?)->(),errorCreation:@escaping(Error?)->()){
        
         Auth.auth().createUser(withEmail: email, password: password, completion: { (firUser, error) in
            if error != nil {
                errorCreation(error)
            }else{
                success(firUser)
            }
        })
        
    }
    
    func save(user : RestUser,imgeUser:UIImage?)
    {
        // 1. reference to the database
        let ref = DBFireReference.users(uid: user.idUser!).reference()
        
        // 2. setValue of the reference
        ref.setValue(user.toSaveAsDictionary())
        
        // 3. save the user's profile Image
      
    }
    
    func signIn(email:String,password:String,success:@escaping()->(),errorSignIn:@escaping(Error?)->()){
        
        Auth.auth().signIn(withEmail: email, password: email, completion: { (firUser, error) in
            if let error = error {
                errorSignIn(error)
            } else {
                success()
                print("SUCCESS SIGN IN")
            }
        })

    }
    func save(user:RestUser){
        let ref = DBFireReference.users(uid: user.idUser!).reference()
        ref.setValue(user.toSaveAsDictionary())
    }
    
    
    func update(user : RestUser){
        let ref = DBFireReference.users(uid: user.idUser!).reference()
        ref.updateChildValues(user.toUpdateAsDictionary())
    }

    
}
