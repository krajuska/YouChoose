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

enum VideoProvider {
    case playlist(Playlist)
    case channel(Channel)
}

func loadAvailableContent(_ view: MainViewController) -> [Playlist] {
    
    var savedPlaylists = [Playlist]()
    
    let request: NSFetchRequest<Playlist> = Playlist.fetchRequest()
    do {
        savedPlaylists = try view.data.fetch(request)
    } catch {
        fatalError()
    }
    
//    for i in 0..<savedPlaylists.count {
//        print(savedPlaylists[i])
//        print("\n\n")
//    }
    
    return savedPlaylists
}

//func createTestPlaylistInstance(_ view: MainViewController) {
//
//    let thumbnails = ["c.jpg", "lt.jpg", "mb.jpg", "pc.jpg", "pp.jpg"]
//    let ids = ["MZu8SplrKF0", "6OoqAmUD9EU", "WZYfJaf-V2o", "EXYRsQ1HllE"]
//
//    for i in 0...20 {
//        let playlist = NSEntityDescription.insertNewObject(forEntityName: "Playlist", into: view.data) as! Playlist
//        let video = NSEntityDescription.insertNewObject(forEntityName: "Video", into: view.data) as! Video
//        playlist.playlistName = "teste \(i)"
//        playlist.video = video
//        video.id = ids[Int.random(in: 0..<ids.count)]
//        video.title = "video number \(i+1)"
//        video.thumbnail = thumbnails[Int.random(in: 0..<thumbnails.count)]
//    }
//
//    let playlistsCount = try! view.data.count(for: NSFetchRequest.init(entityName: "Playlist"))
//    print(">>> playlist count: \n \(playlistsCount)\n")
//
//    do {
//        try view.data.save()
//    } catch {
//        fatalError()
//    }
//
//    let playlistFetch: NSFetchRequest<Playlist> = Playlist.fetchRequest()
//    do {
//        _ = try view.data.fetch(playlistFetch)
//    } catch {
//        print("Error: \(error)")
//    }
//}

func setView(_ view: MainViewController) {
    
    view.curSettings = fetchSettings(view.data)
    
    if view.curSettings.count < 1 {
        setTutorialView(view)
    } else {
        setMainView(view)
    }
}

func populateContent(_ view: MainViewController) {
    if view.videos.count < 1 {
        view.videos = createDefaultContent(view.data)["videos"] as! [Playlist]
    }
    if view.channels.count < 1 {
        view.channels = createDefaultContent(view.data)["channels"] as! [Channel]
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
            if view.pin1.isEditing {
                view.pin1.isSecureTextEntry = true
            }
            view.pin2.text! = "Confirmar PIN"
            if view.pin1.isEditing {
                view.pin1.isSecureTextEntry = true
            }
        }))
        view.present(alert, animated: true, completion: nil)
    }
}

func savePin(_ view: MainViewController, _ pin: String) {

    let settings = NSEntityDescription.insertNewObject(forEntityName: "Settings", into: view.data) as! Settings
    
    settings.pinNumber = pin
    settings.endTime = -1.0
    settings.hideSettings = false
    settings.locationOn = false
    settings.maxTimeOn = false
    settings.timeOn = false
    settings.totalTimeInMinutes = -1
    
    
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

func createDefaultContent(_ data: NSManagedObjectContext) -> [String : Any] {
    
    var returnValues = [String : Any]()
    
    //insert default playlist
    
    var playlistArray = [Playlist]()
    
    let playlist1 = NSEntityDescription.insertNewObject(forEntityName: "Playlist", into: data) as! Playlist
    let video1 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video2 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video3 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video4 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video5 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    let video6 = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    
    playlist1.playlistName = "Sid, O Cientista"
    
    video1.id = "EwgfG0OJqjI"
    video1.title = "Sid o cientista episodio 02 A Lupa"
    getThumbnailURL(video1)
    video2.id = "o3K_XKf7Pds"
    video2.title = "Sid O cientista - Pulmões"
    getThumbnailURL(video2)
    video3.id = "8lZaZk_9V2Q"
    video3.title = "Sid Vai Chover1"
    getThumbnailURL(video3)
    video4.id = "e7dUPBXNpAg"
    video4.title = "Sid o cientista episodio 01 A Ficha"
    getThumbnailURL(video4)
    video5.id = "OfykZ-osZhc"
    video5.title = "Sid Estragou 2"
    getThumbnailURL(video5)
    video6.id = "9XZPu4MJhqU"
    video6.title = "Sid o cientista (estômago)"
    getThumbnailURL(video6)
    
    var myVideos = [Video]()
    
    myVideos.append(video1)
    myVideos.append(video2)
    myVideos.append(video3)
    myVideos.append(video4)
    myVideos.append(video5)
    myVideos.append(video6)
    
    playlist1.videos = NSOrderedSet(array: myVideos)
    
    playlistArray.append(playlist1)
    
    returnValues["videos"] = playlistArray
    
    //insert default channels
    
    let channel1 = NSEntityDescription.insertNewObject(forEntityName: "Channel", into: data) as! Channel
    let channel2 = NSEntityDescription.insertNewObject(forEntityName: "Channel", into: data) as! Channel
    let channel3 = NSEntityDescription.insertNewObject(forEntityName: "Channel", into: data) as! Channel
    let channel4 = NSEntityDescription.insertNewObject(forEntityName: "Channel", into: data) as! Channel
    let channel5 = NSEntityDescription.insertNewObject(forEntityName: "Channel", into: data) as! Channel
    let channel6 = NSEntityDescription.insertNewObject(forEntityName: "Channel", into: data) as! Channel
    
    channel1.channelName = "Castelo Rá-Tim-Bum"
    channel1.channelImg = "https://yt3.ggpht.com/a/AGF-l7_nhaFa-lOlZeFv9cVwKlVpULMHLT2Xrcg67g=s288-mo-c-c0xffffffff-rj-k-no"
    channel2.channelName = "Canal do Júlio"
    channel2.channelImg = "https://yt3.ggpht.com/a/AGF-l7_PcWs_IyZ7W5IySMaLHWYC9qDCZWknEo3QRA=s288-mo-c-c0xffffffff-rj-k-no"
    channel3.channelName = "cordel animado"
    channel3.channelImg = "https://yt3.ggpht.com/a/AGF-l78bDHbsGOZcCDlQdNNA2NkMDXgxhAkfahfxBw=s288-mo-c-c0xffffffff-rj-k-no"
    channel4.channelName = "Fafá conta histórias"
    channel4.channelImg = "https://yt3.ggpht.com/a/AGF-l7-VJY0w0WJmGC_OQO4xkXAAuNYOdzgFoa4YhA=s288-mo-c-c0xffffffff-rj-k-no"
    channel5.channelName = "Palavra Cantada Oficial"
    channel5.channelImg = "https://yt3.ggpht.com/a/AGF-l78j4Y6cl4M2sHpdJsE_sImQecphyKdWXnN76w=s288-mo-c-c0xffffffff-rj-k-no"
    channel6.channelName = "Ticolicos - Canal Infantil"
    channel6.channelImg = "https://yt3.ggpht.com/a/AGF-l7-1DCVXe5SnxzXY1uJD9uADBV61ASTtkX1Lmw=s288-mo-c-c0xffffffff-rj-k-no"
    
    var myChannels = [Channel]()
    
    myChannels.append(channel1)
    myChannels.append(channel2)
    myChannels.append(channel3)
    myChannels.append(channel4)
    myChannels.append(channel5)
    myChannels.append(channel6)
    
    returnValues["channels"] = myChannels
    
    do {
        try data.save()
    } catch {
        fatalError()
    }
    
    return returnValues
    
}

func getThumbnailURL(_ video: Video) {
    video.thumbnail = "https://img.youtube.com/vi/\(video.id!)/0.jpg"
}

func countAvailableVideos(_ playlists: [Playlist]) -> Int {
    var num = 0
    for i in 0..<playlists.count {
        for _ in 0..<playlists[i].videos!.count {
            num += 1
        }
    }
    return num
}

func getEveryChannelAndPlaylist(_ view: MainViewController) -> [VideoProvider] {
    let playlists = fetchVideos(view.data)
    let channels = fetchChannels(view.data)
    var providers = [VideoProvider]()
    
    for playlist in playlists {
        providers.append(VideoProvider.playlist(playlist))
    }
    
    for channel in channels {
        providers.append(VideoProvider.channel(channel))
    }
    
    //    print("\n\n\n\n\n")
    //    for (key, value) in imgsURL {
    //        print("\n\n\(key), \(value)\n\n")
    //    }
    //    print("\n\n\n\n\n")
    //
    return providers
}

func getVideoProviderName(_ provider:VideoProvider) -> String {
    switch provider {
    case .channel(let chan):
        return chan.channelName!
    case .playlist(let playlist):
        return playlist.playlistName!
    }
}

func getVideoProviderPic(_ provider:VideoProvider) -> String {
    switch provider {
    case .channel(let chan):
        return chan.channelImg!;
    case .playlist(let playlist):
        let curPL = playlist.videos?.object(at: 0) as! Video;
        return curPL.thumbnail!
    }
}

func getEveryChannelAndPlaylistPic(_ view: MainViewController) -> [(String, String)] {
    let playlists = fetchVideos(view.data)
    let channels = fetchChannels(view.data)
    var imgsURL = [(String, String)]()
    
    for playlist in playlists {
        let curPL = playlist.videos?.object(at: 0) as! Video
        imgsURL.append((playlist.playlistName!, curPL.thumbnail!))
    }
    
    for channel in channels {
        imgsURL.append((channel.channelName!, channel.channelImg!))
    }
    
//    print("\n\n\n\n\n")
//    for (key, value) in imgsURL {
//        print("\n\n\(key), \(value)\n\n")
//    }
//    print("\n\n\n\n\n")
//
    return imgsURL
    
}

func convertGECAPPReturn(_ functionReturn: [String : String]) -> [String] {
    var returnArray = [String]()
    
    for value in functionReturn {
        returnArray.append(value.value)
    }
    
    print("\n\n\n\n\n")
    for result in returnArray {
        print("\n\n\(result)\n\n")
    }
    print("\n\n\n\n\n")
    
    return returnArray
}

func countAvailableChannelsAndPlaylists(_ channels: [Channel], _ playlists: [Playlist]) -> Int {
    return (channels.count + playlists.count)
}

func setChannelsAndPlaylistsPics(_ view: MainViewController) {
    
}
