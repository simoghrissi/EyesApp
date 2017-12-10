//
//  RestUser.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
public struct RestUser{
    
    var idUser: Int?
    var nomUser: String?
    var prenomUser: String?
    var mailUser: String?
    var passwordUser: String?
    var phoneUser: String?
    var dateCreateUser: String?
    var nbrPointUser: String?
    var adresse: RestAdresse?

    init(idUser:Int,nomUser:String,prenomUser:String,mailUser:String,passwordUser:String,phoneUser:String,dateCreateUser:String,nbrPointUser:String,adresse:RestAdresse) {
        
        self.idUser = idUser
        self.nomUser = nomUser
        self.prenomUser = prenomUser
        self.mailUser = mailUser
        self.passwordUser = passwordUser
        self.phoneUser = phoneUser
        self.dateCreateUser = nbrPointUser
        self.adresse = adresse
    }
    
}
