//
//  SuggestViewModel.swift
//  EyesApp
//
//  Created by simo on 11/02/2018.
//  Copyright © 2018 simo. All rights reserved.
//

import RxSwift
import RxCocoa
import FBSDKLoginKit

final class SuggestViewModel {
    
    let suggests = Variable<[String]>([String]())
    var shownSuggests = Variable<[String]>([String]())
    
    init() {
        
        let ref = DBFireReference.typeDemande.reference()
        ref.observe(.value, with: { snapshot in
                if let values = snapshot.value as? NSDictionary{
                    for (_,value) in values{
                        if let value = value as? String{
                            self.suggests.value.append(value)
                        }
                    }
                }
           })
    }
    
        
}

