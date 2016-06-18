//
//  ViewController.swift
//  Obligatorio3
//
//  Created by Administrador on 9/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//usuario@ucu.com

import UIKit
import IQKeyboardManagerSwift
import MapKit
import Firebase

class PublishController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var entryTitle: UITextField!
    var window: UIWindow?
    
    @IBAction func btnPublish(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Publicar", message: "¿Está seguro que desea publicar el viaje?", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Si", style: .Default, handler: { (action: UIAlertAction!) in
            //saving entry on Firebase
            var myRootRef = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/")
            var entriesRef = myRootRef.childByAppendingPath("entries")
            var entry = ["title": self.entryTitle.text, "date": self.dateTextField.text, "description": self.txtDescription.text]
            let entryRef = entriesRef.childByAutoId()
            entryRef.setValue(entry)
            //confirmation alert
            let alert2 = UIAlertController(title: nil, message: "Publicación enviada.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default) { (action) in
                navigationController?.popToRootViewControllerAnimated(true)
            }
            alert2.addAction(okAction)
            self.presentViewController(alert2, animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: { (action: UIAlertAction!) in }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        //self.dateTextField.addTarget(self, action: #selector(ViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        //http://stackoverflow.com/questions/28394933/how-do-i-check-when-a-uitextfield-changes
        self.dateTextField.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        self.dateTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.dateTextField.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        //Border of txtDescription
        self.txtDescription!.layer.borderWidth = 1
        self.txtDescription!.layer.borderColor = UIColor.grayColor().CGColor
        
        //Border of map
        self.map!.layer.borderWidth = 1
        self.map!.layer.borderColor = UIColor.grayColor().CGColor
        
        IQKeyboardManager.sharedManager().enable = true
        
    }
    
}
