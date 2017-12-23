//
//  RestEtat.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestEtat: Codable{
    
    var idEtat: Int?
    var libelle :String?
    var statut: String?
    
    init(idEtat:Int,libelle:String,statut:String) {
        self.idEtat = idEtat
        self.libelle = libelle
        self.statut = statut
    }
    

}
