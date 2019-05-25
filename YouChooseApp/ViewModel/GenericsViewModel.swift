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
    
//    if view is MainViewController {
//        let mainView = MainViewController()
//        let menuBtn = UIButton(type: .custom)
//        let frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
//        menuBtn.frame = frame
//        menuBtn.setImage(UIImage(named:"canal.png"), for: .normal)
//        menuBtn.setImage(UIImage(named:"canal.png"), for: .selected)
//        mainView.gearButton = UIBarButtonItem(customView: menuBtn)
//        let currWidth = mainView.gearButton.customView?.widthAnchor.constraint(equalToConstant: 25)
//        currWidth?.isActive = true
//        let currHeight = mainView.gearButton.customView?.heightAnchor.constraint(equalToConstant: 25)
//        currHeight?.isActive = true
//
//        let menuBtn2 = UIButton(type: .custom)
//        menuBtn2.frame = frame
//        menuBtn2.setImage(UIImage(named:"canal.png"), for: .normal)
//        menuBtn2.setImage(UIImage(named:"canal.png"), for: .selected)
//        mainView.clockButton = UIBarButtonItem(customView: menuBtn2)
//        let currWidth2 = mainView.clockButton.customView?.widthAnchor.constraint(equalToConstant: 25)
//        currWidth2?.isActive = true
//        let currHeight2 = mainView.clockButton.customView?.heightAnchor.constraint(equalToConstant: 25)
//        currHeight2?.isActive = true
//        view.navigationItem.rightBarButtonItems = [mainView.gearButton, mainView.clockButton]
//    }
}

func fetchSettings(_ data: NSManagedObjectContext) -> [Settings] {
    var settings = [Settings]()
    
    let request: NSFetchRequest<Settings> = Settings.fetchRequest()
    do {
        settings = try data.fetch(request)
    } catch  {
        print("Erro ao ler o contexto - fetchSettings: \(error) ")
    }
    
    return settings
}

func printSettings(_ settings: Settings) {
    print("\n\n\nSettings:\n")
    print("Pin number: \(settings.pinNumber ?? "pinnumber")")
    print("Horário máximo: \(settings.endTime)")
    print("Hide settings: \(settings.hideSettings)")
    print("Location on: \(settings.locationOn)")
    print("Max time on: \(settings.maxTimeOn)")
    print("Time on: \(settings.timeOn)")
    print("Total time in Minutes: \(settings.totalTimeInMinutes)")
    print("\n\n\n")
}

func dummySettings(_ data: NSManagedObjectContext) -> Settings {
    
    let settingsEntity = NSEntityDescription.entity(forEntityName: "Settings", in: data)
    let curSetting = NSManagedObject(entity: settingsEntity!, insertInto: data)

    curSetting.setValue("6666", forKey: "pinNumber")
    curSetting.setValue(17.5, forKey: "endTime")
    curSetting.setValue(true, forKey: "hideSettings")
    curSetting.setValue(false, forKey: "locationOn")
    curSetting.setValue(false, forKey: "maxTimeOn")
    curSetting.setValue(true, forKey: "timeOn")
    curSetting.setValue(Int16(90), forKey: "totalTimeInMinutes")
    
    do {
        try data.save()
    } catch {
        fatalError()
    }
    
    return curSetting as! Settings
}

func createDefaultPlaylists(_ data: NSManagedObjectContext) -> [Playlist] {
    
    var playlistArray = [Playlist]()
    
    let playlist1 = NSEntityDescription.insertNewObject(forEntityName: "Playlist", into: data) as! Playlist
    let video1 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video2 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video3 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video4 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video5 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video6 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    
    playlist1.playlistName = "Sid, O Cientista"
    
    video1.id! = "EwgfG0OJqjI"
    video1.title = "Sid o cientista episodio 02 A Lupa"
//    video1.thumbnail = ""
    video2.id! = "o3K_XKf7Pds"
    video2.title = "Sid O cientista - Pulmões"
//    video2.thumbnail = ""
    video3.id! = "8lZaZk_9V2Q"
    video3.title = "Sid Vai Chover1"
//    video3.thumbnail = ""
    video4.id! = "e7dUPBXNpAg"
    video4.title = "Sid o cientista episodio 01 A Ficha"
//    video4.thumbnail = ""
    video5.id! = "OfykZ-osZhc"
    video5.title = "Sid Estragou 2"
//    video5.thumbnail = ""
    video6.id! = "9XZPu4MJhqU"
    video6.title = "Sid o cientista (estômago)"
//    video6.thumbnail = ""
    
    playlist1.video = video1
    playlist1.video = video2
    playlist1.video = video3
    playlist1.video = video4
    playlist1.video = video5
    playlist1.video = video6
    
    playlistArray.append(playlist1)
    
    do {
        try data.save()
    } catch {
        fatalError()
    }
    
    return playlistArray
    
}
// lista de videos da playlist default
//
// EwgfG0OJqjI
// o3K_XKf7Pds
// 8lZaZk_9V2Q
// e7dUPBXNpAg
// OfykZ-osZhc
// 9XZPu4MJhqU

