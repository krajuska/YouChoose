//
//  ApplyOnAllScreens.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/10/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//mudar nome da função (navBarSetup)
func setHeader<T: UIViewController>(_ view: T) {
    view.navigationItem.title = "YouChoose"
    view.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
}

func getSettings(_ view: SettingsViewController) {
//    do {
//        view.fetchedSettings = try view.context.fetch(view.settingsFetch) as! [Settings]
//    } catch {
//        fatalError("Failed to fetch settings: \(error)")
//    }
}
