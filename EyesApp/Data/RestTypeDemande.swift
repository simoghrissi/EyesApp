//
//  RestTypeDemande.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestTypeDemande: Codable{
    
    var idTypeDemande: Int?
    var descriptionTypeDemande: String?
    
    init(idTypeDemande: Int,descriptionTypeDemande: String) {
        
        self.idTypeDemande = idTypeDemande
        self.descriptionTypeDemande = descriptionTypeDemande
    }
}
