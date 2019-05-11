//
//  ApplyOnAllScreens.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/10/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import UIKit

func setHeader<T: UIViewController>(_ view: T) {
    let nav = view.navigationController?.navigationBar
    nav?.barTintColor = UIColor.red
    nav?.tintColor = UIColor.white
    nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    view.navigationItem.title = "YouChoose"
}
