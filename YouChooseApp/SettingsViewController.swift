//
//  SettingsViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/8/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor.red
        nav?.tintColor = UIColor.white
        navigationItem.title = "YouChoose"
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
}
