//
//  LoginViewController.swift
//  Obligatorio1
//
//  Created by Administrador on 15/4/16.
//  Copyright © 2016 MICHO. All rights reserved.
//usuario@ucu.com
import UIKit
import IQKeyboardManagerSwift
import Firebase


class LoginViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    var currentUser :String?
    var currentPassword : String?
    var currentUserType :Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enable = true
        
        //if user already logged in, goes to home page
        var email = defaults.stringForKey("Email")
        var password = defaults.stringForKey("Password")
        if email != nil && password != nil{
            self.performSegueWithIdentifier("toHome", sender: nil)
        }
        
        //Saving the offer into Firebase
//        var myRootRef = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/")
//        var offersRef = myRootRef.childByAppendingPath("users")
////        var offer = ["name": "cliente", "tipo": 1, "user": "usuario@ucu.com", "password": "123"]
////        let offerRef = offersRef.childByAutoId()
//        var offer = ["name": "fletero", "tipo": 2, "user": "fletero@ucu.com", "password": "321"]
//        let offerRef = offersRef.childByAppendingPath("usuario")()
//        offerRef.setValue(offer)
        
        
        
        
    }

    @IBAction func login(sender: AnyObject) {
        
        //var flag : Bool = false
        var cont : Int = 0
        var myRootRef = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/users")
        myRootRef.queryOrderedByChild("user").observeEventType(.ChildAdded, withBlock: { snapshot in
            
            cont += 1
            if var mail = snapshot.value["user"] as? String {
                
                if(mail == self.emailInput.text)
                {
                    self.currentUser = mail
                    self.currentPassword = snapshot.value["password"] as? String
                    self.currentUserType = snapshot.value["tipo"] as? Int
                    ///flag = true
                    
                    if(self.currentUserType == 1 && self.currentPassword == self.passwordInput.text!){
                        
                        self.defaults.setObject(self.currentUser, forKey: "Email")
                        self.defaults.setObject(self.currentPassword, forKey: "Password")
                        self.defaults.setBool(true, forKey: "Courier")
                        self.performSegueWithIdentifier("toHome", sender: nil)
                        
                    }else if(self.currentUserType == 2 && self.currentPassword == self.passwordInput.text!){
                        
                        self.defaults.setObject(self.currentUser, forKey: "Email")
                        self.defaults.setObject(self.currentPassword, forKey: "Password")
                        self.defaults.setBool(false, forKey: "Courier")
                        self.performSegueWithIdentifier("toHome", sender: nil)
                        
                    }else if(cont == 2){
                        
                        let alert = UIAlertController(title: nil, message: "Credenciales incorrectas", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }else
                {
                    if(cont == 2)
                    {
                        let alert = UIAlertController(title: nil, message: "Credenciales incorrectas", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }               
                    
                }
            }
        
            }, withCancelBlock: { error in
                print(error.description)
                
        })
        
        /*
        if (flag){
        
            if(self.currentUserType == "1"){
            
                defaults.setObject(self.currentUser, forKey: "Email")
                defaults.setObject(self.currentPassword, forKey: "Password")
                defaults.setBool(false, forKey: "Courier")
                self.performSegueWithIdentifier("toHome", sender: nil)
                
            }else if(self.currentUserType == "2"){
                
                defaults.setObject(self.currentUser, forKey: "Email")
                defaults.setObject(self.currentPassword, forKey: "Password")
                defaults.setBool(true, forKey: "Courier")
                self.performSegueWithIdentifier("toHome", sender: nil)
            }
            
        }else{
            
            let alert = UIAlertController(title: nil, message: "Credenciales incorrectas", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }*/
        
//        var email = self.currentUser//emailInput.text
//        var password = self.currentPassword//passwordInput.text
//        if email == "usuario@ucu.com" && password == "123"{
//            defaults.setObject(email, forKey: "Email")
//            defaults.setObject(password, forKey: "Password")
//            defaults.setBool(false, forKey: "Courier")
//            self.performSegueWithIdentifier("toHome", sender: nil)
//        }else if email == "fletero@ucu.com" && password == "123"{
//            defaults.setObject(email, forKey: "Email")
//            defaults.setObject(password, forKey: "Password")
//            defaults.setBool(true, forKey: "Courier")
//            self.performSegueWithIdentifier("toHome", sender: nil)
//        }else{
//            let alert = UIAlertController(title: nil, message: "Credenciales incorrectas", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//        }
    }
    
}


