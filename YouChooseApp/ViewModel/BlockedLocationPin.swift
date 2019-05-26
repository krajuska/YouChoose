//
//  BlockedLocationPin.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/26/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import MapKit

class BlockedLocationPin : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    var title: String?
    var blockedLocation: BlockedLocation
    
    init(_ blockedLocation:BlockedLocation) {
        self.blockedLocation = blockedLocation
        self.coord = CLLocationCoordinate2D(latitude: blockedLocation.latitude, longitude: blockedLocation.longitude)
        self.title = blockedLocation.name
    }
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
    
}
