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

//func createFirstSettingsInstance(_ view: SettingsViewController) /*-> NSManagedObject*/ {
//    var numSettings = try! view.data.count(for: NSFetchRequest.init(entityName: "Settings"))
//    print(numSettings)
//    if numSettings == 0 {
//        let curSetting = NSEntityDescription.insertNewObject(forEntityName: "Settings", into: view.data) as! Settings
//        curSetting.totalTimeInMinutes = 0
//        curSetting.endTime = 15.5
//        curSetting.pinNumber = "1234"
//        curSetting.hideSettings = false
//        curSetting.locationOn = false
//        curSetting.maxTimeOn = false
//        curSetting.timeOn = true
//    }
//
//    numSettings = try! view.data.count(for: NSFetchRequest.init(entityName: "Settings"))
//    print(numSettings)
//
//    do {
//        try view.data.save()
//    } catch {
//        fatalError()
//    }
//
//    let fetchSettings: NSFetchRequest<Settings> = Settings.fetchRequest()
//    do {
//        var savedcurSettings = try view.data.fetch(fetchSettings)
//        print("\n curSettings após o save \n")
//        print(savedcurSettings)
//        print("\n")
//    } catch {
//        print("Error: \(error)")
//    }
//}

//func updateSettings(_ view: SettingsViewController, _ changes: [Bool]) {
//    let test = try? view.data.fetch(NSFetchRequest.init(entityName: "Settings"))
//    let objectUpdate = test![0] as! NSManagedObject
//    
//    
//    objectUpdate.setValue(self.newPin, forKey: "pinNumber")
//    do {
//        try data.save()
//    } catch {
//        fatalError()
//    }
//    
//}

//settings
//
//endTime - double
//hideSettings - boolean
//locationOn - boolean
//maxTimeOn - boolean
//pinNumber - string
//pinSet - boolean >> deletar esse pinSet? acho que nao faz sentido...
//timeOn - boolean
//totalTimeInMinutes - integer 16
//
//como testar pra salvar?
//
//um array com todos os valores que estão SALVOS
//um array todo de booleans de tipo "mudou isso"
//var changes -> [endTime [0], hideSettings[1], locationOn[2], maxTimeOn[3], pinNumber[4], timeOn[5], totalTimeInMinutes[6]]
//comparar e daí atualizar
