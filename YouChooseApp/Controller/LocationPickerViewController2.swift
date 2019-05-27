//
//  LocationPickerViewController2.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/26/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import LocationPickerViewController

class LocationPickerViewController2: LocationPicker {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
