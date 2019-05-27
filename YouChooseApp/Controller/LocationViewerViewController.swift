//
//  LocationViewerViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/24/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import MapKit
import LocationPickerViewController

//class BlockedLocationAnnotationView : MKAnnotationView {
//
//}

class LocationViewerViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, UISearchBarDelegate {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var curSettings = [Settings]()
    var blockedLocations = [BlockedLocation]()

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        curSettings = fetchSettings(data)
        blockedLocations = fetchBlockedLocations(data)
        showPins(blockedLocations, self)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is BlockedLocationPin {
            let customPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            customPinView.canShowCallout = true
            
            // adaptado https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/LocationAwarenessPG/AnnotatingMaps/AnnotatingMaps.html#//apple_ref/doc/uid/TP40009497-CH6-SW28
            let rightButton = UIButton(type: .custom)
            rightButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
            rightButton.setImage(UIImage(named:"canal.png"), for: [])
            customPinView.rightCalloutAccessoryView = rightButton
            return customPinView
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let blocked = view.annotation as? BlockedLocationPin
        {
            data.delete(blocked.blockedLocation)
            blockedLocations.removeAll(where: { $0 == blocked.blockedLocation })
            refreshMap();
            do {
                try data.save()
            } catch  {
                print("Erro ao salvar o contexto: \(error) ")
            }
        }
    }

    func refreshMap() {
        showPins(blockedLocations, self)
    }
    
    // adaptado https://stackoverflow.com/questions/9056451/draw-a-circle-of-1000m-radius-around-users-location-in-mkmapview
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.red
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        }
        return MKPolylineRenderer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPickerView" {
            let locationPicker = segue.destination as! LocationPicker
            locationPicker.pickCompletion = { (pickedLocationItem) in
                if pickedLocationItem.coordinate == nil {
                    return
                }
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
                        let blocked = NSEntityDescription.insertNewObject(forEntityName: "BlockedLocation", into: self.data) as! BlockedLocation
                        blocked.latitude = pickedLocationItem.coordinate!.latitude
                        blocked.longitude = pickedLocationItem.coordinate!.longitude
                        blocked.name = receivedName
                        blocked.radius = 100
                        
                        do {
                            try self.data.save()
                        } catch {
                            fatalError()
                        }
                        
                        self.blockedLocations.append(blocked)
                        let newPinSetAlert = UIAlertController(title: "Nova localização configurada.", message: "", preferredStyle: .alert)
                        newPinSetAlert.addAction(UIKit.UIAlertAction(title: "Ok", style: .default, handler: nil))
                        
                        self.present(newPinSetAlert, animated: true, completion: nil)
                        self.refreshMap()
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}






