//
//  SettingsDetailsViewModel.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/19/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func viewSetUp(_ view: SettingsDetailsViewController) {
    getImage(view)
    getLabels(view)
}

func getImage(_ view: SettingsDetailsViewController) {
    if view.destination == "playlists" {
        view.imgViewOutlet.image = UIImage(named: "playlist.png")
    } else if view.destination == "channels" {
        view.imgViewOutlet.image = UIImage(named: "canal.png")
    }
}

func getLabels(_ view: SettingsDetailsViewController) {
    if view.destination == "playlists" {
        view.labelText.text! = "Criar playlist:" //add um textfield pro nome???
        view.buscarText.setTitle("Adicionar vídeo", for: .normal)
    } else if view.destination == "channels" {
        view.labelText.text! = "Selecionar canais:"
        view.buscarText.setTitle("Buscar canal", for: .normal)
    }
}

func dummyPlaylists(_ view: SettingsDetailsViewController) -> [String] {
    var ids = ["RirbY3yKqpw", "E8xEbat6-cg", "TTYOpfGvlwc", "abJfcRUMS_Y"]
    var videos = [String]()
    for i in 0..<ids.count {
        videos.append("video \(i) - \(ids[i])")
    }
    return videos
}

func buscarAlert(_ view: SettingsDetailsViewController) {
    var title = String()
    let dest = view.destination
    
    if dest == "playlists" {
        title = "Buscar vídeo no YouTube"
    } else if dest == "channels" {
        title = "Buscar canal no YouTube"
    }
    
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
        textField.delegate = view
        textField.keyboardType = .namePhonePad
    })
    alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { (UIAlertAction) in
        
        var receivedName = alert.textFields![0].text!
        
        if dest == "playlists" {
            if receivedName.count == 0 {
                receivedName = "video \(view.videosSelected.count+1)"
            }
            view.videosSelected.append(receivedName)
        } else if dest == "channels" {
            if receivedName.count == 0 {
                receivedName = "canal \(view.channelsSelected.count+1)"
            }
            view.channelsSelected.append(receivedName)
        }
        
        print("ReceivedName after if: \(receivedName)")
        
        refresh(view)
    }))
    
    view.present(alert, animated: true, completion: nil)
}

func refresh(_ view: SettingsDetailsViewController) {
    DispatchQueue.main.async {
        view.tableview.reloadData()
    }
}

//alert pra escolher o nome da playlist, else "playlist count+1"

