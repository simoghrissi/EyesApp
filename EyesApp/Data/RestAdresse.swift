//
//  RestAdresse.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestAdresse{
    
    var numVoie: String?
    var libelleVoie: String?
    var codePostal: String?
    var ville: String?
    
    init(numVoie:String,libelleVoie:String,codePostal:String,ville:String) {
        
        self.numVoie = numVoie
        self.libelleVoie = libelleVoie
        self.codePostal = codePostal
        self.ville = ville
    }
}
