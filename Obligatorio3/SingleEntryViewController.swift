//
//  SingleEntryViewController.swift
//  Obligatorio3
//
//  Created by Administrador on 10/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit
import MapKit

class SingleEntryViewController: UIViewController {
    
    var entry: Entry!
    @IBOutlet weak var entryTitle: UILabel!
    @IBOutlet weak var entryOrigin: UILabel!
    @IBOutlet weak var entryDate: UILabel!
    @IBOutlet weak var entryDestination: UILabel!
    @IBOutlet weak var entryDescription: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryTitle.text = entry!.title
        entryOrigin.text = entry!.origin
        entryDestination.text = entry!.destination
        entryDate.text = entry!.date
        entryDescription.text = entry!.description
        
        //MAP INFO
        //destination pin
        var objectAnnotationDest = MKPointAnnotation()
        objectAnnotationDest.coordinate = entry!.destinationCoordinates
        objectAnnotationDest.title = "Destino"
        self.map.addAnnotation(objectAnnotationDest)
        //origin pin
        var objectAnnotationOri = MKPointAnnotation()
        objectAnnotationOri.coordinate = entry!.originCoordinates
        objectAnnotationOri.title = "Origen"
        self.map.addAnnotation(objectAnnotationOri)
        //zoom

        
       // #define MAP_PADDING 1.1
       // #define MINIMUM_VISIBLE_LATITUDE 0.01
        var minLatitude : Double
        var maxLatitude : Double
        var minLongitude : Double
        var maxLongitude : Double
        if entry!.destinationCoordinates.latitude < entry!.originCoordinates.latitude{
            minLatitude = entry!.destinationCoordinates.latitude
            maxLatitude = entry!.originCoordinates.latitude
        }else{
            minLatitude = entry!.originCoordinates.latitude
            maxLatitude = entry!.destinationCoordinates.latitude
        }
        if entry!.destinationCoordinates.longitude < entry!.originCoordinates.longitude{
            minLongitude = entry!.destinationCoordinates.longitude
            maxLongitude = entry!.originCoordinates.longitude
        }else{
            minLongitude = entry!.originCoordinates.longitude
            maxLongitude = entry!.destinationCoordinates.longitude
        }
        var lat = (minLatitude + maxLatitude) / 2;
        var lon = (minLongitude + maxLongitude) / 2;
        var latitudeDelta = (maxLatitude - minLatitude) * 2;
        if latitudeDelta < 0.01{
            latitudeDelta = 0.01
        }
        var longitudeDelta = (maxLongitude - minLongitude) * 2;
        var span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: span)
        self.map.setRegion(region, animated: true)
    }

}
