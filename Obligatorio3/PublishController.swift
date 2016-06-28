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
import SwiftLocation

class PublishController: UIViewController, UITextFieldDelegate , MKMapViewDelegate{
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var entryTitle: UITextField!
    var window: UIWindow?
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBAction func btnPublish(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Publicar", message: "¿Está seguro que desea publicar el viaje?", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Si", style: .Default, handler: { (action: UIAlertAction!) in
            
            //Coordinates
            var annotation = self.map.annotations
            var destinationCoordLat :String = ""
            var destinationCoordLng :String = ""
            
            var originCoordLat :String = ""
            var originCoordLng :String = ""
            
            for annot in annotation{
                
                if(annot.title! != "Origen"){
                    
                    destinationCoordLat = String(format:"%f", annot.coordinate.latitude)
                    destinationCoordLng = String(format:"%f", annot.coordinate.longitude)
                }else{
                    
                    originCoordLat = String(format:"%f", annot.coordinate.latitude)
                    originCoordLng = String(format:"%f", annot.coordinate.longitude)
                }
            }
            
            
            //saving entry on Firebase
            var myRootRef = Firebase(url:"https://pickapp-9ad8b.firebaseio.com/")
            var entriesRef = myRootRef.childByAppendingPath("entries")
            var entry = ["title": self.entryTitle.text, "date": self.dateTextField.text, "description": self.txtDescription.text, "user": self.defaults.stringForKey("Email"), "destinationCoordLat": destinationCoordLat, "destinationCoordLng": destinationCoordLng, "originCoordLat": originCoordLat, "originCoordLng": originCoordLng, "state": "Pendiente"]
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
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        do {
            
            try SwiftLocation.shared.currentLocation(Accuracy.Neighborhood, timeout: 20, onSuccess: { (location) -> Void in
                var lat :String
                var lng :String
                
                lat = String(location!.coordinate.latitude)
                lng = String(location!.coordinate.longitude)
                
                var currentLocation = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(lng)!)
                
                //MAP INFO
                //self.map.delegate = self
                //origin pin
                //Codigo Viejo
//                var objectAnnotationDest = MKPointAnnotation()
//                objectAnnotationDest.coordinate = currentLocation
//                objectAnnotationDest.title = "Origen"
                
                let objectAnnotationDest = ColorPointAnnotation(pinColor: UIColor.redColor())
                objectAnnotationDest.coordinate = currentLocation
                objectAnnotationDest.title = "Origen"
                
                
                self.map.addAnnotation(objectAnnotationDest)
                //zoom
                var region = MapUtils.getRegion(currentLocation, destinationCoordinates: currentLocation)
                self.map.setRegion(region, animated: true)
                
                
                }) { (error) -> Void in
                    // something went wrong
                    //self.activityIndicator.stopAnimating()
                    let alertController = UIAlertController(title: "Error", message:
                        error?.description, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }catch {
            //self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(title: "Error", message:
                "Error getting current location", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        //Border of map
        self.map!.layer.borderWidth = 1
        self.map!.layer.borderColor = UIColor.grayColor().CGColor
        
        
    }

    
    @IBAction func textFieldEditing(sender: UITextField) {
        
//        let datePickerView:UIDatePicker = UIDatePicker()
//        
//        datePickerView.datePickerMode = UIDatePickerMode.Date
//        
//        sender.inputView = datePickerView
        
        //self.dateTextField.addTarget(self, action: #selector(ViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        //http://stackoverflow.com/questions/28394933/how-do-i-check-when-a-uitextfield-changes
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        textField.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        return true
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
        
        //setting selected location
        
        let longPressed = UILongPressGestureRecognizer(target: self, action:"addAnnotation:")
        longPressed.minimumPressDuration = 0.5
        self.map.addGestureRecognizer(longPressed)
        
        self.map.delegate = self
        
    }
    
    func addAnnotation(sender:UILongPressGestureRecognizer){
        
        if sender.state == UIGestureRecognizerState.Began {
            //let allAnnotations = self.map.annotations
            
            //clear route
            let allOverlays = self.map.overlays
            self.map.removeOverlays(allOverlays)
            
            let point = sender.locationInView(self.map)
            let coord:CLLocationCoordinate2D = self.map.convertPoint(point, toCoordinateFromView: self.map)
            
            let annotationDestino = self.map.annotations
            var annotationForDelete : MKAnnotation!
            var annotationOrigen : MKAnnotation!
            for annot in annotationDestino{
                
                if(annot.title! != "Origen"){
                    annotationForDelete = annot
                    self.map.removeAnnotation(annotationForDelete)
                }else{
                    annotationOrigen = annot
                }
            }

            
            let sourceLocation = CLLocationCoordinate2D(latitude: annotationOrigen.coordinate.latitude, longitude: annotationOrigen.coordinate.longitude)
            let destinationLocation = CLLocationCoordinate2D(latitude: coord.latitude,longitude: coord.longitude)
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
                //let rect = route.polyline.boundingMapRect
                //self.map.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }
            
            //Codigoviejo
            //let annotation = MKPointAnnotation()
            //annotation.coordinate = coord
            
            ////save coordinate in memory to use it when pin is dragged
            //self.defaults.setObject(annotationOrigen.coordinate.latitude, forKey: "CoordinateOriginLat")
            //self.defaults.setObject(annotationOrigen.coordinate.longitude, forKey: "CoordinateOriginLng")
            //self.defaults.setObject(coord.latitude, forKey: "CoordinateDestinyLat")
            //self.defaults.setObject(coord.longitude, forKey: "CoordinateDestinyLng")
            
            
            let annotation = ColorPointAnnotation(pinColor: UIColor.blueColor())
            annotation.coordinate = coord
            annotation.title = "Destino"
                        
            self.map.addAnnotation(annotation)
            
        }
    }
    
    
    
}

class ColorPointAnnotation: MKPointAnnotation {
    var pinColor: UIColor = UIColor.greenColor()
    
    init(pinColor: UIColor) {
        self.pinColor = pinColor
        super.init()
    }
    
}

extension PublishController {
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
            pinView?.draggable = true
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
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.Ending {
            
            //let droppedAt = view.annotation?.coordinate
            //print(droppedAt)
            
            //Get annotations
            let annotation = self.map.annotations
            if(annotation.count > 1){
                
                
                //clear route
                let allOverlays = self.map.overlays
                self.map.removeOverlays(allOverlays)
                
                var annotationOrigin : MKAnnotation!
                var annotationDestiny : MKAnnotation!
                for annot in annotation{
                    if(annot.title! != "Origen"){
                        annotationDestiny = annot
                    }else{
                        annotationOrigin = annot
                    }
                }
                
                let sourceLocation = CLLocationCoordinate2D(latitude: annotationOrigin.coordinate.latitude, longitude: annotationOrigin.coordinate.longitude)
                let destinationLocation = CLLocationCoordinate2D(latitude: annotationDestiny.coordinate.latitude,longitude: annotationDestiny.coordinate.longitude)
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
                    //let rect = route.polyline.boundingMapRect
                    //self.map.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                }
                
            }
            
            
        }
    }
    
}

