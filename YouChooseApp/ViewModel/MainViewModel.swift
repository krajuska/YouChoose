//
//  MainViewModel.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/21/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
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
