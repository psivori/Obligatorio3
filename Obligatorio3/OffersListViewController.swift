//
//  ViewController.swift
//  Obligatorio3
//
//  Created by Administrador on 9/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class OffersListViewController: UIViewController {
    
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var budget: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Border of txtDescription
        self.txtDescription!.layer.borderWidth = 1
        self.txtDescription!.layer.borderColor = UIColor.grayColor().CGColor
        
        IQKeyboardManager.sharedManager().enable = true
    }
    
    @IBAction func sendOffer(sender: AnyObject) {
        //guardar la oferta
        navigationController?.popToRootViewControllerAnimated(true)
    }
}