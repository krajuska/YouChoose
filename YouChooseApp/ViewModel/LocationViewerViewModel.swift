//
//  LocationViewerViewModel.swift
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

// adaptado https://stackoverflow.com/questions/7278094/moving-a-cllocation-by-x-meters
func locationMax(_ distanceMeters:Double, _ origin:(Double,Double)) -> (Double,Double) {
    let distRadians = distanceMeters / (6372797.6) // earth radius in meters
    
    let lat1 = origin.0 * Double.pi / 180
    let lon1 = origin.1 * Double.pi / 180
    
    let lat2 = asin(sin(lat1) * cos(distRadians) + cos(lat1) * sin(distRadians))
    let lon2 = lon1 + atan2(sin(distRadians) * cos(lat1), cos(distRadians) - sin(lat1) * sin(lat2))
    
    return (lat2 * 180 / Double.pi, lon2 * 180 / Double.pi)
}

func showPins(_ blockedLocations: [BlockedLocation], _ view: LocationViewerViewController) {
    
    if blockedLocations.count == 0 {
        return
    }
    
    var minLat = Double.infinity
    var minLon = Double.infinity
    var maxLat = -Double.infinity
    var maxLon = -Double.infinity
    view.mapView.removeAnnotations(view.mapView.annotations)
    view.mapView.removeOverlays(view.mapView.overlays)
    
    for location in blockedLocations {
        
        let pin = BlockedLocationPin(location)
        let lat = location.latitude
        let lon = location.longitude
        let max = locationMax( location.radius, (location.latitude, location.longitude) )
        let radiusLat = max.0 - lat
        let radiusLon = max.1 - lon
        
        view.mapView.addAnnotation(pin)
        let circle = MKCircle(center: pin.coordinate, radius: location.radius as CLLocationDistance)
        view.mapView.addOverlay(circle)
        
        if (lat + radiusLat) > maxLat { maxLat = lat + radiusLat }
        if (lat - radiusLat) < minLat { minLat = lat - radiusLat }
        if (lon + radiusLon) > maxLon { maxLon = lon + radiusLon }
        if (lon - radiusLon) < minLon { minLon = lon - radiusLon }
        
    }
    
    let centerLat = (minLat + maxLat) / 2
    let centerLon = (minLon + maxLon) / 2
    let deltaLat = maxLat - centerLat
    let deltaLon = maxLon - centerLon
    
    let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(centerLat, centerLon), span: MKCoordinateSpan(latitudeDelta: deltaLat * 2.1, longitudeDelta: deltaLon * 2.1))
    view.mapView.setRegion(region, animated: true)
}
