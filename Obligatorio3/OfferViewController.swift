//
//  ViewController.swift
//  Obligatorio3
//
//  Created by Administrador on 9/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

class OfferViewController: UIViewController {
    
    var entry: Entry!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var budget: UITextField!
    @IBOutlet weak var entryTitle: UILabel!
    @IBOutlet weak var entryOrigin: UILabel!
    @IBOutlet weak var entryDestination: UILabel!
    @IBOutlet weak var entryDate: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Border of txtDescription
        self.txtDescription!.layer.borderWidth = 1
        self.txtDescription!.layer.borderColor = UIColor.grayColor().CGColor
        
        IQKeyboardManager.sharedManager().enable = true
        
        entryTitle.text = entry!.title
        entryOrigin.text = entry!.origin
        entryDestination.text = entry!.destination
        entryDate.text = entry!.date
        
    }
    
    @IBAction func sendOffer(sender: AnyObject) {
        if budget.text != "" && txtDescription.text != "" {
            var refreshAlert = UIAlertController(title: "", message: "¿Enviar oferta?", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "Sí", style: .Default, handler: { (action: UIAlertAction!) in
                //Saving the offer into Firebase
                var myRootRef = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/")
                var offersRef = myRootRef.childByAppendingPath("offers")
                var offer = ["budget": self.budget.text, "description": self.txtDescription.text, "entryId": self.entry.id]
                let offerRef = offersRef.childByAutoId()
                offerRef.setValue(offer)
                
                let alert2 = UIAlertController(title: nil, message: "Oferta enviada.", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (action) in
                    navigationController?.popToRootViewControllerAnimated(true)
                }
                alert2.addAction(okAction)
                self.presentViewController(alert2, animated: true, completion: nil)
            }))
            refreshAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { (action: UIAlertAction!) in }))
            presentViewController(refreshAlert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: nil, message: "Complete los datos.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
}
