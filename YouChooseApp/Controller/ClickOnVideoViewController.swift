//
//  ClickOnVideoViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/22/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit

class ClickOnVideoViewController: UIViewController {

    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var curSettings = [Settings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curSettings = fetchSettings(data)
    }
}
