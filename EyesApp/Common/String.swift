//
//  String.swift
//  EyesApp
//
//  Created by simo on 29/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

extension String {
    
    var localized:String{
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        
    }
    
}
