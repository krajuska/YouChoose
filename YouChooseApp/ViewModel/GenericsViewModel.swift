//
//  ApplyOnAllScreens.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/10/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import UIKit

func setHeader<T>(_ view: T) {
    let viewController = view as! UIViewController
    let nav = viewController.navigationController?.navigationBar
    nav?.barTintColor = UIColor.red
    nav?.tintColor = UIColor.white
    nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    viewController.navigationItem.title = "YouChoose"
}
