//
//  BuildConfig.swift
//  EyesApp
//
//  Created by simo on 23/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation

public class BuildConfig {
    
    static let sharedInstance = BuildConfig()
    
     var endpoint: String = ""
     var digSecretClient: String = ""
    
    private init() {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
                endpoint = dic["endpoint"] as! String
            }
        }
    }
    
}
