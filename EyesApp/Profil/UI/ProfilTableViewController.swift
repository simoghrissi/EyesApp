//
//  ProfilTableViewController.swift
//  EyesApp
//
//  Created by simo on 30/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ProfilTableViewController: UITableViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var phoneText: DesignableTextField!
    @IBOutlet weak var addressText: DesignableTextField!
    @IBOutlet weak var passwordText: DesignableTextField!
    @IBOutlet weak var birthDayText: DesignableTextField!
    @IBOutlet weak var genderText: DesignableTextField!
    @IBOutlet weak var emailText: DesignableTextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBinding()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func saveAction(_ sender: Any) {
    
    }
    
    @IBAction func changeProfilAction(_ sender: Any) {
    }
    
    func setupBinding(){
        
    }
    
}
