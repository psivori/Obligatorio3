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
        if canOffer {
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
        let objectAnnotationOri = ColorPointAnnotation(pinColor: UIColor.redColor())
        objectAnnotationOri.coordinate = entry!.originCoordinates
        objectAnnotationOri.title = "Origen"
        self.map.addAnnotation(objectAnnotationOri)
        
        
        let objectAnnotationDestiny = ColorPointAnnotation(pinColor: UIColor.blueColor())
        objectAnnotationDestiny.coordinate = entry!.destinationCoordinates
        objectAnnotationDestiny.title = "Destino"
        
        self.map.addAnnotation(objectAnnotationDestiny)
        
        let sourceLocation = CLLocationCoordinate2D(latitude: objectAnnotationOri.coordinate.latitude, longitude: objectAnnotationOri.coordinate.longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: objectAnnotationDestiny.coordinate.latitude,longitude: objectAnnotationDestiny.coordinate.longitude)
        // 3.
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .Automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)

        // 8.
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.map.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
        }
        
        //zoom
        var region = MapUtils.getRegion(entry!.originCoordinates, destinationCoordinates: entry!.destinationCoordinates)
        self.map.setRegion(region, animated: true)
        
        //Border of map
        self.map!.layer.borderWidth = 1
        self.map!.layer.borderColor = UIColor.grayColor().CGColor
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Volver"
        navigationItem.backBarButtonItem = backItem
        if let offerViewController = segue.destinationViewController as? OfferViewController{
            offerViewController.entry = self.entry
        }
        if let offersListViewController = segue.destinationViewController as? OffersListViewController{
            offersListViewController.entry = self.entry
        }
    }
    
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        //        if annotation is MKPointAnnotation {
        //            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
        //
        //            pinAnnotationView.pinColor = .Green
        //            pinAnnotationView.draggable = true
        //            pinAnnotationView.canShowCallout = true
        //            pinAnnotationView.animatesDrop = true
        //
        //            return pinAnnotationView
        //        }
        //
        //        return nil
        
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            let colorPointAnnotation = annotation as! ColorPointAnnotation
            pinView?.pinTintColor = colorPointAnnotation.pinColor
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay.isKindOfClass(MKPolyline) {
            // draw the track
            let polyLine = overlay
            let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
            polyLineRenderer.strokeColor = UIColor.blueColor()
            polyLineRenderer.lineWidth = 2.0
            
            return polyLineRenderer
        }
        return MKPolylineRenderer()
        
        
    }
    

}


