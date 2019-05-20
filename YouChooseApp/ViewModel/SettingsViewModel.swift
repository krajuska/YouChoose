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

func createFirstSettingsInstance(_ view: SettingsViewController) /*-> NSManagedObject*/ {
    var numSettings = try! view.data.count(for: NSFetchRequest.init(entityName: "Settings"))
    print(numSettings)
    if numSettings == 0 {
        let curSetting = NSEntityDescription.insertNewObject(forEntityName: "Settings", into: view.data) as! Settings
        curSetting.totalTimeInMinutes = 0
        curSetting.endTime = 15.5
        curSetting.pinNumber = "1234"
        curSetting.hideSettings = false
        curSetting.locationOn = false
        curSetting.maxTimeOn = false
        curSetting.pinSet = true
        curSetting.timeOn = true
    }
    
    numSettings = try! view.data.count(for: NSFetchRequest.init(entityName: "Settings"))
    print(numSettings)
    
    do {
        try view.data.save()
    } catch {
        fatalError()
    }
    
    let fetchSettings: NSFetchRequest<Settings> = Settings.fetchRequest()
    do {
        var savedcurSettings = try view.data.fetch(fetchSettings)
        print("\n curSettings após o save \n")
        print(savedcurSettings)
        print("\n")
    } catch {
        print("Error: \(error)")
    }
}
