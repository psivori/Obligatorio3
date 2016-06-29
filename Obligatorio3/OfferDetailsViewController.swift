//
//  SingleEntryViewController.swift
//  Obligatorio3
//
//  Created by Administrador on 10/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit
import MapKit

class OfferDetailsViewController: UIViewController {
    
    var entry: EntryOffer!
    let defaults = NSUserDefaults.standardUserDefaults()
   
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var detailsLabel: UITextView!
    
    @IBAction func AceptOffer(sender: AnyObject) {
    
        var refreshAlert = UIAlertController(title: "", message: "¿Aceptar la oferta?", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Sí", style: .Default, handler: { (action: UIAlertAction!) in
            let alert2 = UIAlertController(title: nil, message: "Oferta Aceptada.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (action) in
                navigationController?.popToRootViewControllerAnimated(true)
            }
            alert2.addAction(okAction)
            self.presentViewController(alert2, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { (action: UIAlertAction!) in }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetLabel.text = entry!.budget
        nombreLabel.text = entry!.name
        detailsLabel.text = entry!.description
        
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
