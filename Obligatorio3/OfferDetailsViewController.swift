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
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UITextView!
    @IBAction func AceptOffer(sender: AnyObject) {
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetLabel.text = entry!.price
        nombreLabel.text = entry!.name
        lastNameLabel.text = entry!.lastName
        detailsLabel.text = entry!.details
        
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
