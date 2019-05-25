//
//  LocationPickerViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/24/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import MapKit

class LocationPickerViewController: UIViewController, MKMapViewDelegate {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var curSettings = [Settings]()

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        loadData(self)
        testIfEmpty(self)
        
        curSettings = fetchSettings(data)
        if curSettings.count < 1 {
            curSettings[0] = dummySettings(data)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        if let annotation = view.annotation as? RestaurantPin
//        {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let next = storyBoard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
//            next.self.restaurant = annotation.restaurant
//            self.navigationController?.pushViewController(next, animated: true)
//        }
    }
}
