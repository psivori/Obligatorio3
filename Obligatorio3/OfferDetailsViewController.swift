//
//  SingleEntryViewController.swift
//  Obligatorio3
//
//  Created by Administrador on 10/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class OfferDetailsViewController: UIViewController {
    
    var offer: EntryOffer!
    var entry: Entry!
    let defaults = NSUserDefaults.standardUserDefaults()
   
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var detailsLabel: UITextView!
    
    @IBAction func AceptOffer(sender: AnyObject) {
    
        var refreshAlert = UIAlertController(title: "", message: "¿Aceptar la oferta?", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Sí", style: .Default, handler: { (action: UIAlertAction!) in
            
            //Updating the entry on Firebase
            var myEntryRoot = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/entries/" + self.entry.id + "/state")
            myEntryRoot.setValue("Finalizada")
            

            let alert2 = UIAlertController(title: nil, message: "Oferta aceptada.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (action) in
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            alert2.addAction(okAction)
            self.presentViewController(alert2, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { (action: UIAlertAction!) in }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetLabel.text = offer!.budget
        nombreLabel.text = offer!.name
        detailsLabel.text = offer!.description
        
        //Border of txtDescription
        self.detailsLabel!.layer.borderWidth = 1
        self.detailsLabel!.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Volver"
        navigationItem.backBarButtonItem = backItem
    }
    
}
