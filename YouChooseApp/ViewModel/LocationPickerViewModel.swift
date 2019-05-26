//
//  LocationPickerViewModel.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/24/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreData
import MapKit

func fetchBlockedLocations(_ data: NSManagedObjectContext) -> [BlockedLocation] {
    var allBlockedLocations = [BlockedLocation]()
    let request: NSFetchRequest<BlockedLocation> = BlockedLocation.fetchRequest()
    do {
        allBlockedLocations = try data.fetch(request)
    } catch  {
        print("Erro ao ler o contexto - getAllBlockedLocations: \(error) ")
    }
    return allBlockedLocations
}

func showPins(_ blockedLocations: [BlockedLocation], _ view: LocationPickerViewController) {
    
    var minLat = Double.infinity
    var minLon = Double.infinity
    var maxLat = -Double.infinity
    var maxLon = -Double.infinity
    
    for location in blockedLocations {
        
        let pin = BlockedLocationPin(location)
        let lat = location.latitude
        let lon = location.longitude
        let radius = location.radius
        view.mapView.addAnnotation(pin)
        
        if (lat + radius) > maxLat { maxLat = lat + radius }
        if (lat - radius) < minLat { minLat = lat - radius }
        if (lon + radius) > maxLon { maxLon = lon + radius }
        if (lon - radius) < minLon { minLon = lon - radius }
        
    }
    
    let centerLat = (minLat + maxLat) / 2
    let centerLon = (minLon + maxLon) / 2
    let deltaLat = maxLat - centerLat
    let deltaLon = maxLon - centerLon
    
    let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(centerLat, centerLon), span: MKCoordinateSpan(latitudeDelta: deltaLat * 2 + 0.01, longitudeDelta: deltaLon * 2 + 0.01))
    view.mapView.setRegion(region, animated: true)
}
