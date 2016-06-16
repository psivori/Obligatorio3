//
//  ViewController.swift
//  Obligatorio3
//
//  Created by Administrador on 9/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


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
        var refreshAlert = UIAlertController(title: "", message: "¿Enviar oferta?", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Sí", style: .Default, handler: { (action: UIAlertAction!) in
            //GUARDAR LA OFERTA
            let alert2 = UIAlertController(title: nil, message: "Oferta enviada.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (action) in
                navigationController?.popToRootViewControllerAnimated(true)
            }
            alert2.addAction(okAction)
            self.presentViewController(alert2, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { (action: UIAlertAction!) in }))
        presentViewController(refreshAlert, animated: true, completion: nil)

        
    }
}
