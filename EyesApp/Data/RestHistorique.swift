//
//  RestHistorique.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestHistorique: Codable{
    
    var idHistorique: Int?
    var date: String?
    var pointsPlus: String?
    var pointsMoins: String?
    var user: RestUser?
    var listDemande: [RestDemande]?
    var listReponse: [RestReponse]?
    var listAction: [RestTypeAction]?
    
}
