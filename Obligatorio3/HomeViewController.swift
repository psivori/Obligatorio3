//
//  ViewController.swift
//  Obligatorio1
//
//  Created by Administrador on 14/4/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var email = defaults.stringForKey("Email")
        var password = defaults.stringForKey("Password")
        
        if email == nil || password == nil{
            self.performSegueWithIdentifier("toLogin", sender: nil)
        }
    }
    
    
}

