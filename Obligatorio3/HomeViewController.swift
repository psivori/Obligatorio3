//
//  ViewController.swift
//  Obligatorio1
//
//  Created by Administrador on 14/4/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import MapKit
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var publishButton: UIBarButtonItem!
    var entries = [Entry]()
    var selectedEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //shows or hides de publish button, according to profile user
        var canPublish = !defaults.boolForKey("Courier")
        if canPublish {
            navigationItem.rightBarButtonItems = [publishButton]
        } else {
            navigationItem.rightBarButtonItems = []
        }
        //getting entries to show on table view
        loadEntries()
        
    }
    
    
    func loadEntries() {
        let entry1 = Entry(title: "Mudanza urgente", description : "Preciso trasladar todos los muebles de mi casa", originCoordinates : CLLocationCoordinate2D(latitude: 37.8873589, longitude: -122.608227), destinationCoordinates : CLLocationCoordinate2D(latitude: 37.7873589, longitude: -122.408227), date : "06/06/2016", state : "aceptado")
        let entry2 = Entry(title: "Traslado de mercaderia", description : "Traslado para mercaderia de local comercial", originCoordinates : CLLocationCoordinate2D(latitude: 37.7773589, longitude: -122.408227), destinationCoordinates : CLLocationCoordinate2D(latitude: 37.7873589, longitude: -122.508227), date : "06/06/2016", state : "postulado")
        entries += [entry1, entry2]
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "entryViewCellCustom"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EntryViewCellCustom
        
        // Fetches the appropriate meal for the data source layout.
        let entry = entries[indexPath.row]
        cell.titleLabel.text = entry.title
        cell.stateLabel.text = " " + entry.state + " "
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        selectedEntry = entries[indexPath.row]
        self.performSegueWithIdentifier("showEntry", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Volver"
        navigationItem.backBarButtonItem = backItem
        if let singleEntryViewController = segue.destinationViewController as? SingleEntryViewController{
            singleEntryViewController.entry = selectedEntry
        }
    }

    
}

