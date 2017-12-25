//
//  RestBaseParams.swift
//  EyesApp
//
//  Created by simo on 23/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestBaseParams: Codable{
    
    var idUser: Int?
    var mailUser: String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case idUser = "idUser"
        case mailUser = "mailUser"
        
    }
    init(idUser:Int,mailUser:String) {
        self.idUser = idUser
        self.mailUser = mailUser
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idUser = try values.decodeIfPresent(Int.self, forKey: .idUser)
        mailUser = try values.decodeIfPresent(String.self, forKey: .mailUser)
        
    }
    
}
