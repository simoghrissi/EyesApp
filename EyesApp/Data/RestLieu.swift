//
//  RestLieu.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestLieu: Codable{
    
    var idLieu: String?
    var libelleLieu: String?
    var latitudeLieu: String?
    var longitudeLieu: String?
    var adresseLieu: String?
    
    init(idLieu:String,libelleLieu:String,latitudeLieu:String,longitudeLieu: String,adresseLieu: String) {
        
        self.idLieu = idLieu
        self.libelleLieu = libelleLieu
        self.latitudeLieu = latitudeLieu
        self.longitudeLieu = longitudeLieu
        self.adresseLieu = adresseLieu
    }
    
    
}
