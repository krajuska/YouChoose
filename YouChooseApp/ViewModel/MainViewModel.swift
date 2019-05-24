//
//  MainViewModel.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/21/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func loadAvailableContent(_ view: MainViewController) -> [Playlist] {
    
    var savedPlaylists = [Playlist]()
    
    let request: NSFetchRequest<Playlist> = Playlist.fetchRequest()
    do {
        savedPlaylists = try view.data.fetch(request)
    } catch {
        fatalError()
    }
    
    for i in 0..<savedPlaylists.count {
        print(savedPlaylists[i])
        print("\n\n")
    }
    
    return savedPlaylists
}

func createTestPlaylistInstance(_ view: MainViewController) {
    
    let thumbnails = ["c.jpg", "lt.jpg", "mb.jpg", "pc.jpg", "pp.jpg"]
    let ids = ["MZu8SplrKF0", "6OoqAmUD9EU", "WZYfJaf-V2o", "EXYRsQ1HllE"]
    
    for i in 0...20 {
        let playlist = NSEntityDescription.insertNewObject(forEntityName: "Playlist", into: view.data) as! Playlist
        let video = NSEntityDescription.insertNewObject(forEntityName: "Video", into: view.data) as! Video
        playlist.playlistName = "teste \(i)"
        playlist.video = video
        video.id = ids[Int.random(in: 0..<ids.count)]
        video.title = "video number \(i+1)"
        video.thumbnail = thumbnails[Int.random(in: 0..<thumbnails.count)]
    }
    
    let playlistsCount = try! view.data.count(for: NSFetchRequest.init(entityName: "Playlist"))
    print(">>> playlist count: \n \(playlistsCount)\n")
    
    do {
        try view.data.save()
    } catch {
        fatalError()
    }
    
    let playlistFetch: NSFetchRequest<Playlist> = Playlist.fetchRequest()
    do {
        _ = try view.data.fetch(playlistFetch)
    } catch {
        print("Error: \(error)")
    }
}

func setView(_ view: MainViewController) {
    
    let requisicao: NSFetchRequest<Settings> = Settings.fetchRequest()
    do {
        view.curSettings = try view.data.fetch(requisicao)
    } catch {
        fatalError()
    }
    
    if view.curSettings.count < 1 {
        setTutorialView(view)
    } else {
        setMainView(view)
    }
}

func setTutorialView(_ view: MainViewController) {
    view.tutorialView.isHidden = false
    view.playlistsView.isHidden = true
    view.videosView.isHidden = true
    view.gearButton.isEnabled = false
    view.clockButton.isEnabled = false
    view.pin1.keyboardType = .numberPad
    view.pin1.delegate = view
    view.pin2.keyboardType = .numberPad
    view.pin2.delegate = view
}

func checkPin(_ view: MainViewController) {
    let pin1 = view.pin1.text!
    let pin2 = view.pin2.text!
    
    if pin1 == pin2 {
        savePin(view, pin1)
    } else {
        let alert = UIAlertController(title: "PIN inválido", message: "Tente novamente.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            view.pin1.text! = "Inserir PIN"
            view.pin2.text! = "Confirmar PIN"
        }))
        view.present(alert, animated: true, completion: nil)
    }
}

func savePin(_ view: MainViewController, _ pin: String) {
    let entity = NSEntityDescription.entity(forEntityName: "Settings", in: view.data)
    let settings = NSManagedObject(entity: entity!, insertInto: view.data)

    settings.setValue(pin, forKey: "pinNumber")
    
    do {
        try view.data.save()
        let alert = UIAlertController(title: "PIN configurado com sucesso", message: "Lembre-se: seu novo PIN é \(pin). Se julgar necessário, anote-o em um lugar seguro.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            setMainView(view)
        }))
        view.present(alert, animated: true, completion: nil)
    } catch {
        fatalError()
    }
}

func setMainView(_ view: MainViewController) {
    view.tutorialView.isHidden = true
    view.playlistsView.isHidden = false
    view.videosView.isHidden = false
    view.gearButton.isEnabled = true
    view.clockButton.isEnabled = true
    
    
}
