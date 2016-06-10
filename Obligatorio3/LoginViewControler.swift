//
//  LoginViewController.swift
//  Obligatorio1
//
//  Created by Administrador on 15/4/16.
//  Copyright © 2016 MICHO. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func login(sender: AnyObject) {
        var email = emailInput.text
        var password = passwordInput.text
        if email == "usuario@ucu.com" && password == "123"{
            defaults.setObject(email, forKey: "Email")
            defaults.setObject(password, forKey: "Password")
            defaults.setBool(false, forKey: "Fletero")
            self.dismissViewControllerAnimated(true, completion: nil)
        }else if email == "fletero@ucu.com" && password == "123"{
            defaults.setObject(email, forKey: "Email")
            defaults.setObject(password, forKey: "Password")
            defaults.setBool(true, forKey: "Fletero")
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            let alert = UIAlertController(title: nil, message: "Credenciales incorrectas", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
 
    
    
    
}


