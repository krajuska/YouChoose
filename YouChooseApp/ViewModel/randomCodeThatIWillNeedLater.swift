//
//  randomCodeThatIWillNeedLater.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/20/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import CoreData
import UIKit

var fetchedPlaylists = [Playlist]()
var fetchedChannels = [Channel]()

//tem uma search bar que acho que daria pra integrar com o api do youtube

let playlistFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Playlist")
let channelFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Channel")

func forWhenINeedToFetchPlaylistsAndChannel(_ view: SettingsViewController) {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedPlaylists.count
}

func createTestPlaylistInstance(_ view: SettingsDetailsViewController) {
    
    //ainda nao testei isso aqui
    
    for i in 0...10 {
        let playlists = NSEntityDescription.insertNewObject(forEntityName: "Playlist", into: view.data) as! Playlist
        playlists.playlistName = "teste \(i)"
        playlists.videoIDs = ["MZu8SplrKF0", "6OoqAmUD9EU", "WZYfJaf-V2o", "EXYRsQ1HllE"]
        playlists.playlistImg = "playlist.png"
    }
    
    let playlistsCount = try! view.data.count(for: NSFetchRequest.init(entityName: "Playlist"))
    print(">>> playlist count: \n \(playlistsCount)\n")
    
    do {
        try view.data.save()
    } catch {
        fatalError()
    }
    
    let playlistFetch: NSFetchRequest<Settings> = Settings.fetchRequest()
    do {
        let savedPlaylists = try view.data.fetch(playlistFetch)
        print("\n savedPlaylists após o save \n")
        print(savedPlaylists)
        print("\n")
    } catch {
        print("Error: \(error)")
    }
}
