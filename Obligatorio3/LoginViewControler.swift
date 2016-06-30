//
//  LoginViewController.swift
//  Obligatorio1
//
//  Created by Administrador on 15/4/16.
//  Copyright © 2016 MICHO. All rights reserved.
//usuario@ucu.com
//fletero@ucu.com
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
<<<<<<< HEAD
           // self.performSegueWithIdentifier("toHome", sender: nil)
=======
            //self.performSegueWithIdentifier("toHome", sender: nil)
>>>>>>> effcdb97ebba551d0b36a89f4cca981ab01717ee
        }
    }

    @IBAction func login(sender: AnyObject) {
        var cont : Int = 0
        var myRootRef = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/users")
        myRootRef.queryOrderedByChild("user").observeEventType(.ChildAdded, withBlock: { snapshot in
            cont += 1
            if var mail = snapshot.value["user"] as? String {
                if(mail == self.emailInput.text) {
                    self.currentUser = mail
                    self.currentPassword = snapshot.value["password"] as? String
                    self.currentUserType = snapshot.value["tipo"] as? Int
                    var name = snapshot.value["name"] as? String
                    
                    if(self.currentUserType == 1 && self.currentPassword == self.passwordInput.text!){
                        self.defaults.setObject(self.currentUser, forKey: "Email")
                        self.defaults.setObject(self.currentPassword, forKey: "Password")
                        self.defaults.setBool(false, forKey: "Courier")
                        self.defaults.setObject(name, forKey: "Name")
                        self.performSegueWithIdentifier("toHome", sender: nil)
                    }else if(self.currentUserType == 2 && self.currentPassword == self.passwordInput.text!){
                        self.defaults.setObject(self.currentUser, forKey: "Email")
                        self.defaults.setObject(self.currentPassword, forKey: "Password")
                        self.defaults.setBool(true, forKey: "Courier")
                        self.defaults.setObject(name, forKey: "Name")
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
        
    }
    
}


