//
//  SettingsDetailsViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/13/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit

class SettingsDetailsViewController: UIViewController {

    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var iconOutlet: UIImageView!
    
    var titleLabel = String()
    var imageName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleOutlet.text = titleLabel
        iconOutlet.image = UIImage(named: imageName)
    }
}
