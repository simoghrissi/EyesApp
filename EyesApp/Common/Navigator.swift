//
//  Navigator.swift
//  EyesApp
//
//  Created by simo on 30/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import UIKit

public class Navigator {
    
       static let sharedInstance = Navigator()
    
    func navigateToMain(controller:UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")as? ViewController{
            controller.present(viewController, animated: false, completion: nil)

        }
    }
  
}
