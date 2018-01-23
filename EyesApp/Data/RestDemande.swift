//
//  RestDemande.swift
//  EyesApp
//
//  Created by simo on 10/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public struct RestDemande: Codable{
    
    var idDemande: String?
    var commentDemande: String?
    var dateSaisieDemande: String?
    var latLocalisationUser: String?
    var longLocalisationUser :String?
    var typeDemande: RestTypeDemande?
    var user: RestUser?
    var lieu: RestLieu?
    var etat: RestEtat?
    
    init(idDemande: String,commentDemande: String,dateSaisieDemande: String,latLocalisationUser: String,longLocalisationUser :String,typeDemande: RestTypeDemande,user: RestUser,lieu: RestLieu,etat: RestEtat) {
        
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
    
    
    func toSaveAsDictionary() -> [String : Any]
    {
        let nomUser = self.user?.nomUser ?? ""
        let prenomUser = self.user?.prenomUser ?? ""
        let gender = self.user?.gender ?? ""
        let profilePhotoUrl = self.user?.profilePhotoUrl ?? ""
        let birthDayUser = self.user?.birthDayUser ?? ""
        let mailUser = self.user?.mailUser ?? ""
        let phoneUser = self.user?.phoneUser ?? ""
        let dateCreateUser = self.user?.dateCreateUser ?? ""
        let nbrPointUser = self.user?.nbrPointUser ?? ""
        let isFromFB = self.user?.isFromFB
        let idUser = self.user?.idUser ?? ""
        return [
            "idDemande": self.idDemande ?? "",
            "commentDemande":self.commentDemande ?? "",
            "dateSaisieDemande": self.dateSaisieDemande ?? "",
            "latLocalisationUser": self.latLocalisationUser ?? "",
            "longLocalisationUser": self.longLocalisationUser ?? "",
            "typeDemande":
                [
                    "idTypeDemande": self.typeDemande?.idTypeDemande ?? "",
                    "descriptionTypeDemande": self.typeDemande?.descriptionTypeDemande ?? ""
            ],
            "user":[
                "idUser":idUser,
                "nomUser":nomUser ,
                "prenomUser": prenomUser ,
                "gender":gender ,
                "mailUser": mailUser,
                "profilePhotoUrl":profilePhotoUrl,
                "birthDayUser":birthDayUser,
                "phoneUser": phoneUser,
                "dateCreateUser": dateCreateUser,
                "nbrPointUser": nbrPointUser,
                "isFromFB":isFromFB,
                "adresse":
                    [
                        "numVoie": self.user?.adresse?.numVoie ?? "",
                        "libelleVoie": self.user?.adresse?.libelleVoie ?? "",
                        "codePostal": self.user?.adresse?.codePostal ?? "",
                        "ville": self.user?.adresse?.ville ?? ""
                ]
            ],
            
            "lieu":["idLieu":self.lieu?.idLieu ?? "",
                    "libelleLieu":self.lieu?.libelleLieu ?? "",
                    "latitudeLieu":self.lieu?.latitudeLieu ?? "",
                    "longitudeLieu":self.lieu?.longitudeLieu ?? "",
                    "adresseLieu": self.lieu?.adresseLieu ?? ""
            ],
            "etat":["idEtat":self.etat?.idEtat ?? "",
                    "libelle":self.etat?.libelle ?? "",
                    "statut": self.etat?.statut ?? ""
            ]
        ]
    }
}
