//
//  RestTypeAction.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestTypeAction{
    
    var idTypeAction: Int?
    var nomAction: String?
    
    init(idTypeAction: Int,nomAction: String) {
        
        self.idTypeAction = idTypeAction
        self.nomAction = nomAction
    }
    
}
