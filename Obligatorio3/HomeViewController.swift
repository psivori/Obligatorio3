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
    @IBOutlet weak var publishButton: UIBarButtonItem!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var canPublish = !defaults.boolForKey("Fletero") //poner nombre en ingles
        if canPublish {
            navigationItem.rightBarButtonItems = [publishButton]
        } else {
            navigationItem.rightBarButtonItems = []
        }
        
    }
    
    
}

