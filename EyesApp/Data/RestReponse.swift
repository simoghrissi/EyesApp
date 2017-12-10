//
//  RestReponse.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestReponse{
    
    var idReponse: Int?
    var dateReponse: String?
    var photoReponse: String?
    var commentReponse: String?
    var latLocalisationUser: String?
    var longLocalisationUser: String?
    var dateCreateUser: String?
    var nbrPointUser: String?
    var user: RestUser?
    var lieu: RestLieu?
    var etat: RestEtat?
    var demande: RestDemande?
    
    init(idReponse: Int,dateReponse: String,photoReponse: String,commentReponse: String,latLocalisationUser: String,longLocalisationUser: String,dateCreateUser: String,nbrPointUser: String,user: RestUser,lieu: RestLieu,etat: RestEtat,demande: RestDemande) {
        
        self.idReponse = idReponse
        self.dateReponse = dateReponse
        self.photoReponse = photoReponse
        self.commentReponse = commentReponse
        self.latLocalisationUser = latLocalisationUser
        self.longLocalisationUser = longLocalisationUser
        self.dateCreateUser = dateCreateUser
        self.nbrPointUser = nbrPointUser
        self.user = user
        self.lieu = lieu
        self.etat = etat
        self.demande = demande
        
    }
    
    
}
