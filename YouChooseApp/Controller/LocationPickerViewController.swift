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

class LocationPickerViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, UISearchBarDelegate {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var curSettings = [Settings]()
    var blockedLocations = [BlockedLocation]()
    var curBLName = String()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        curSettings = fetchSettings(data)
        blockedLocations = fetchBlockedLocations(data)     
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
    @IBAction func newLocation(_ sender: Any) {
        let alert = UIAlertController(title: "Insira um nome para a nova localização", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.delegate = self
            textField.keyboardType = .default
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { (UIAlertAction) in
            let receivedName = alert.textFields![0].text!
            print("ReceivedName: \(receivedName)")
            if receivedName.count < 1 {
                let newAlert = UIAlertController(title: "Nome inválido", message: "Tente novamente.", preferredStyle: .alert)
                newAlert.addAction(UIKit.UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(newAlert, animated: true, completion: nil)
            } else {
                self.curBLName = receivedName
                let newPinSetAlert = UIAlertController(title: "Nova localização configurada.", message: "", preferredStyle: .alert)
                newPinSetAlert.addAction(UIKit.UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(newPinSetAlert, animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}






