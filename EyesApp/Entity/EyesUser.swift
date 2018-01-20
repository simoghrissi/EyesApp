//
//  EyesUser.swift
//  EyesApp
//
//  Created by simo on 20/01/2018.
//  Copyright © 2018 simo. All rights reserved.
//

import RealmSwift

public class EyesUser:Object{
    
    dynamic var id = 0
    dynamic var idUser: String?
    dynamic var nomUser: String?
    dynamic var prenomUser: String?
    dynamic var mailUser: String?
    dynamic var phoneUser: String?
    dynamic var dateCreateUser: String?
    dynamic var nbrPointUser: String?
    dynamic var gender:String?
    dynamic var birthDayUser :String?
    dynamic var profilePhotoUrl:String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(restUser: RestUser?) {
        self.init()
        self.idUser = restUser?.idUser ?? ""
        self.nomUser = restUser?.nomUser ?? ""
        self.prenomUser = restUser?.prenomUser ?? ""
        self.mailUser = restUser?.mailUser ?? ""
        self.phoneUser = restUser?.phoneUser ?? ""
        self.dateCreateUser = restUser?.dateCreateUser ?? ""
        self.nbrPointUser = restUser?.nbrPointUser ?? ""
        self.gender = restUser?.nbrPointUser ?? ""
        self.birthDayUser = restUser?.birthDayUser ?? ""
        self.profilePhotoUrl = restUser?.profilePhotoUrl ?? ""
    }
    
}
