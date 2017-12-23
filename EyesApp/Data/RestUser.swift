//
//  RestUser.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
public struct RestUser:Codable{
    
    var idUser: Int?
    var nomUser: String?
    var prenomUser: String?
    var mailUser: String?
    var passwordUser: String?
    var phoneUser: String?
    var dateCreateUser: String?
    var nbrPointUser: String?
    var adresse: RestAdresse?
    let encoder = JSONEncoder()
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
    
    enum CodingKeys: String, CodingKey {
        
        case idUser = "idUser"
        case nomUser = "nomUser"
        case prenomUser = "prenomUser"
        case mailUser = "mailUser"
        case passwordUser = "passwordUser"
        case phoneUser = "phoneUser"
        case dateCreateUser = "dateCreateUser"
        case adresse = "adresse"

    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idUser = try values.decodeIfPresent(Int.self, forKey: .idUser)
        nomUser = try values.decodeIfPresent(String.self, forKey: .nomUser)
        prenomUser = try values.decodeIfPresent(String.self, forKey: .prenomUser)
        mailUser = try values.decodeIfPresent(String.self, forKey: .mailUser)
        passwordUser = try values.decodeIfPresent(String.self, forKey: .passwordUser)
        phoneUser = try values.decodeIfPresent(String.self, forKey: .phoneUser)
        dateCreateUser = try values.decodeIfPresent(String.self, forKey: .dateCreateUser)
        adresse = try values.decodeIfPresent(RestAdresse.self, forKey: .adresse)


    }
    
    
}
