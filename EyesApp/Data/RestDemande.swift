//
//  RestDemande.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestDemande{
    
    var idDemande: Int?
    var commentDemande: String?
    var dateSaisieDemande: String?
    var latLocalisationUser: String?
    var longLocalisationUser :String?
    var typeDemande: RestTypeDemande?
    var user: RestUser?
    var lieu: RestLieu?
    var etat: RestEtat?
    
    init(idDemande: Int,commentDemande: String,dateSaisieDemande: String,latLocalisationUser: String,longLocalisationUser :String,typeDemande: RestTypeDemande,user: RestUser,lieu: RestLieu,etat: RestEtat) {
        
        self.idDemande = idDemande
        self.commentDemande = commentDemande
        self.dateSaisieDemande = dateSaisieDemande
        self.latLocalisationUser = latLocalisationUser
        self.longLocalisationUser = longLocalisationUser
        self.typeDemande = typeDemande
        self.user = user
        self.lieu = lieu
        self.etat = etat
    }
}
