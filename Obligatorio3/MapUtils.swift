//
//  MapUtils.swift
//  Obligatorio3
//
//  Created by Administrador on 15/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import Foundation
import MapKit

class MapUtils {
    
    /**
    Returns a region according to two annotations
    */
    public static func getRegion(originCoordinates: CLLocationCoordinate2D, destinationCoordinates: CLLocationCoordinate2D) -> MKCoordinateRegion {
        var minLatitude : Double
        var maxLatitude : Double
        var minLongitude : Double
        var maxLongitude : Double
        if destinationCoordinates.latitude < originCoordinates.latitude{
            minLatitude = destinationCoordinates.latitude
            maxLatitude = originCoordinates.latitude
        }else{
            minLatitude = originCoordinates.latitude
            maxLatitude = destinationCoordinates.latitude
        }
        if destinationCoordinates.longitude < originCoordinates.longitude{
            minLongitude = destinationCoordinates.longitude
            maxLongitude = originCoordinates.longitude
        }else{
            minLongitude = originCoordinates.longitude
            maxLongitude = destinationCoordinates.longitude
        }
        var lat = (minLatitude + maxLatitude) / 2;
        var lon = (minLongitude + maxLongitude) / 2;
        var latitudeDelta = (maxLatitude - minLatitude) * 2;
        if latitudeDelta < 0.01{
            latitudeDelta = 0.01
        }
        var longitudeDelta = (maxLongitude - minLongitude) * 2;
        var span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: span)
    }

}
