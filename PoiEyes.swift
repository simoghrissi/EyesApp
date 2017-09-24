//
//  Poi.swift
//  EyesApp
//
//  Created by simo on 24/09/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import UIKit

class PoiEyes{
    
    var id: Int = -1
    var name: String? = ""
    var otherInf: String? = ""
    var type: String? = ""
    
    init(){}
    
    init(id:Int,name:String,otherInf:String,type:String){
        self.id = id
        self.name = name
        self.otherInf = otherInf
        self.type = type
        
    }
}
