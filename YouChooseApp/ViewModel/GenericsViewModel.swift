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

func getVideoThumbnail<T: UIViewController>(_ view: T, _ video: Video) -> UIImage? {
    if let bytes = try? Data(contentsOf: URL(string: video.thumbnail!)!) {
        if let image = UIImage(data: bytes) {
            return image
        }
    }
    return nil
}

func getChannelAndPlaylistThumbnail<T: UIViewController>(_ view: T, _ url: String) -> UIImage? {
    if let bytes = try? Data(contentsOf: URL(string: url)!) {
        if let image = UIImage(data: bytes) {
            return image
        }
    }
    return nil
}

//func refresh<T: UIViewController>(_ view: T) {
//    DispatchQueue.main.async {
//        view.collectionView.reloadData()
//    }
//}

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

func fetchVideos(_ data: NSManagedObjectContext) -> [Playlist] {
    var videos = [Playlist]()
    
    let request: NSFetchRequest<Playlist> = Playlist.fetchRequest()
    do {
        videos = try data.fetch(request)
    } catch  {
        print("Erro ao ler o contexto - fetchVideos: \(error) ")
    }
    
    return videos
}

func fetchChannels(_ data: NSManagedObjectContext) -> [Channel] {
    var channels = [Channel]()
    
    let request: NSFetchRequest<Channel> = Channel.fetchRequest()
    do {
        channels = try data.fetch(request)
    } catch {
        print("Erro ao ler o contexto - fetchChannels: \(error)")
    }
    
    return channels
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


