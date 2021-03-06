//
//  Entry.swift
//  Obligatorio3
//
//  Created by Administrador on 10/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import MapKit
import Foundation
import SwiftLocation

class Entry{
    var title : String
    var description : String
    var origin : String?
    var originCoordinates : CLLocationCoordinate2D
    var destination : String?
    var destinationCoordinates : CLLocationCoordinate2D
    var date : String
    var state : String
    var id : String
   
    init(title : String, description : String, originCoordinates : CLLocationCoordinate2D, destinationCoordinates : CLLocationCoordinate2D, date : String, state : String, id : String){
        self.description = description
        self.title = title
        self.date = date
        self.destinationCoordinates = destinationCoordinates
        self.originCoordinates = originCoordinates
        self.state = state
        self.id = id
        
        //getting destination city name
        SwiftLocation.shared.reverseCoordinates(Service.Apple, coordinates: destinationCoordinates, onSuccess: { (place) -> Void in
            self.destination = place!.locality
            }) { (error) -> Void in
        }
        
        //getting origin city name
        SwiftLocation.shared.reverseCoordinates(Service.Apple, coordinates: originCoordinates, onSuccess: { (place) -> Void in
            self.origin = place!.locality
            }) { (error) -> Void in
        }
    }

}