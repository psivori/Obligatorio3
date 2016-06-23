//
//  SingleEntryViewController.swift
//  Obligatorio3
//
//  Created by Administrador on 10/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit
import MapKit

class SingleEntryViewController: UIViewController, MKMapViewDelegate {
    
    var entry: Entry!
    @IBOutlet weak var showOffers: UIBarButtonItem!
    let defaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var offerButton: UIBarButtonItem!
    @IBOutlet weak var entryTitle: UILabel!
    @IBOutlet weak var entryOrigin: UILabel!
    @IBOutlet weak var entryDate: UILabel!
    @IBOutlet weak var entryDestination: UILabel!
    @IBOutlet weak var entryDescription: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var canOffer = defaults.boolForKey("Courier")
        if !canOffer {
            navigationItem.rightBarButtonItems = [offerButton]
        } else {
            navigationItem.rightBarButtonItems = [showOffers]
        }
        
        entryTitle.text = entry!.title
        entryOrigin.text = entry!.origin
        entryDestination.text = entry!.destination
        entryDate.text = entry!.date
        entryDescription.text = entry!.description
        
        //MAP INFO
        map.delegate = self
        //destination pin
        var objectAnnotationDest = MKPointAnnotation()
        objectAnnotationDest.coordinate = entry!.destinationCoordinates
        objectAnnotationDest.title = "Destino"
        self.map.addAnnotation(objectAnnotationDest)
        
        //origin pin
        var objectAnnotationOri = MKPointAnnotation()
        //let objectAnnotationOri = ColorPointAnnotation(pinColor: UIColor.blueColor())
        objectAnnotationOri.coordinate = entry!.originCoordinates
        objectAnnotationOri.title = "Origen"
        self.map.addAnnotation(objectAnnotationOri)
        //zoom
        var region = MapUtils.getRegion(entry!.originCoordinates, destinationCoordinates: entry!.destinationCoordinates)
        self.map.setRegion(region, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Volver"
        navigationItem.backBarButtonItem = backItem
        if let offerViewController = segue.destinationViewController as? OfferViewController{
            offerViewController.entry = self.entry
        }
    }
    
//    class ColorPointAnnotation: MKPointAnnotation {
//        var pinColor: UIColor
//        
//        init(pinColor: UIColor) {
//            self.pinColor = pinColor
//            super.init()
//        }
//    }
//    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
//        let reuseId = "pin"
//        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
//        if pinView == nil {
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            let colorPointAnnotation = annotation as! ColorPointAnnotation
//            pinView?.pinTintColor = colorPointAnnotation.pinColor
//        }
//        else {
//            pinView?.annotation = annotation
//        }
//        
//        return pinView
//    }

}