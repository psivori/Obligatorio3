//
//  ViewController.swift
//  Obligatorio1
//
//  Created by Administrador on 14/4/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import MapKit
import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var publishButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var entries = [Entry]()
    var selectedEntry: Entry?
    var email : String!
    var courier : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        //shows or hides de publish button, according to profile user
        email = defaults.stringForKey("Email")
        courier = !defaults.boolForKey("Courier")
        if !courier {
            navigationItem.rightBarButtonItems = [publishButton]
        } else {
            navigationItem.rightBarButtonItems = []
        }
       
    }
    
    override func viewDidAppear(animated: Bool) {
        entries.removeAll()
        loadEntries()
    }
    
    func loadEntries() {
        var ref = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/entries")
        ref.queryOrderedByChild("user").observeEventType(.ChildAdded, withBlock: { snapshot in
            if var user = snapshot.value["user"] as? String {
                //if courier || user == self.email {
                    var tit = snapshot.value["title"] as! String
                    var des = snapshot.value["description"] as? String
                    var dte = snapshot.value["date"] as? String
                    var entry = Entry(title: tit, description : des!, originCoordinates : CLLocationCoordinate2D(latitude: 37.8873589, longitude: -122.608227), destinationCoordinates : CLLocationCoordinate2D(latitude: 37.7873589, longitude: -122.408227), date : dte!, state : "aceptado")
                    self.entries.append(entry)
                    self.tableView.reloadData()
                //}
            }
        })
        
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

