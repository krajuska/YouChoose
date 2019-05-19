//
//  SettingsViewModel.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/15/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import CoreData
import UIKit

func setSwitchColor(_ switches: [UISwitch]) {
    for singleSwitch in switches {
        singleSwitch.onTintColor = UIColor.red
    }
}

func createFirstSettingsInstance(_ view: SettingsViewController) /*-> Settings*/ {
    let settings = NSEntityDescription.insertNewObject(forEntityName: "Settings", into: view.data) as! Settings
    settings.endTime = 0
    settings.pinNumber = "0"
    settings.totalTimeInMinutes = 0
    settings.hideSettings = false
    settings.locationOn = false
    settings.maxTimeOn = false
    settings.pinSet = false
    settings.timeOn = false
//    return settings
}
