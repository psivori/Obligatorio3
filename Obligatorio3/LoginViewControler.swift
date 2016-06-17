//
//  LoginViewController.swift
//  Obligatorio1
//
//  Created by Administrador on 15/4/16.
//  Copyright © 2016 MICHO. All rights reserved.
//
import UIKit
import IQKeyboardManagerSwift
import Firebase


class LoginViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enable = true
        
        //if user already logged in, goes to home page
        var email = defaults.stringForKey("Email")
        var password = defaults.stringForKey("Password")
        if email != nil && password != nil{
            //self.performSegueWithIdentifier("toHome", sender: nil)
        }
        
//        //Saving the offer into Firebase
//        var myRootRef = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/")
//        var offersRef = myRootRef.childByAppendingPath("users")
////        var offer = ["name": "cliente", "tipo": 1, "user": "usuario@ucu.com", "password": "123"]
////        let offerRef = offersRef.childByAutoId()
//        var offer = ["name": "fletero", "tipo": 2, "user": "fletero@ucu.com", "password": "321"]
//        let offerRef = offersRef.childByAutoId()
//        offerRef.setValue(offer)
        
        
        
        
    }

    @IBAction func login(sender: AnyObject) {
        
        var myRootRef = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/users")
        myRootRef.observeEventType(.Value, withBlock: {
            snapshot in
            
            for child in snapshot.children {
                if let w = child.value!!.objectForKey("name") as? String {
                    print(w)
                }
            }
        
        })
        
        
        
        var email = emailInput.text
        var password = passwordInput.text
        if email == "usuario@ucu.com" && password == "123"{
            defaults.setObject(email, forKey: "Email")
            defaults.setObject(password, forKey: "Password")
            defaults.setBool(false, forKey: "Courier")
            self.performSegueWithIdentifier("toHome", sender: nil)
        }else if email == "fletero@ucu.com" && password == "123"{
            defaults.setObject(email, forKey: "Email")
            defaults.setObject(password, forKey: "Password")
            defaults.setBool(true, forKey: "Courier")
            self.performSegueWithIdentifier("toHome", sender: nil)
        }else{
            let alert = UIAlertController(title: nil, message: "Credenciales incorrectas", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }


    
    
}


