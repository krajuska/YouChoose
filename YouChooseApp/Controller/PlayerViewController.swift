//
//  PlayerViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/23/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import YoutubePlayerView
import CoreLocation

class PlayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, YoutubePlayerViewDelegate {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var curSettings = [Settings]()
    var blockedLocations = [BlockedLocation]()
    var videos = [Video]()
    var id = String()
    
    var lastHeartbeatStamp:Double?
    
    var locationManager:CLLocationManager?
    
    @IBOutlet weak var playerView: YoutubePlayerView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var gearButton: UIBarButtonItem!
    @IBOutlet var clockButton: UIBarButtonItem!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosOnPlayerViewCell", for: indexPath) as! PlayerCollectionViewCell
        let video = videos[indexPath.row]
        cell.videoThumbnail.image = getVideoThumbnail(self, video)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let widthSize = collectionView.layer.frame.width / 2
        let heightSize = widthSize*9/16
        return CGSize(width: widthSize-15, height: heightSize-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = videos[indexPath.row]
        self.id = video.id!
        viewDidLoad()
    }
    
    func formatDate(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: date)
    }
   
    func playerView(_ playerView: YoutubePlayerView, didPlayTime time: Float) {
        let date = Date()
        
        var shouldSave = false
        let today = formatDate(date)
        
        if curSettings[0].today != today {
            curSettings[0].today = today
            curSettings[0].watchSecondsToday = 0
            shouldSave = true
        }
        
        let timestamp = Date().timeIntervalSince1970
        if let lastTimestamp = lastHeartbeatStamp {
            // valor de 5 segundos e' arbitrario - só precisa ser maior que o intervalo que essa função é chamada
            if timestamp - lastTimestamp < 5 {
                let oldWatchTime = curSettings[0].watchSecondsToday
                let newWatchTime = oldWatchTime + timestamp - lastTimestamp
                curSettings[0].watchSecondsToday = newWatchTime
                if Int(newWatchTime / 5) > Int(oldWatchTime / 5) { // salvando a cada 5 seg
                    shouldSave = true
                    print(newWatchTime)
                }
            }
        }
        
        lastHeartbeatStamp = timestamp
        
        if shouldSave {
            do {
                try data.save()
            } catch {
                fatalError()
            }
        }
        
        if !canViewVideo() {
            self.playerView.stop()
            // TODO mostrar tela falando que NAO PODE
        }
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        goToSettings(self, data)
    }
    
    func initLocation() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        }
    }
    
    func canViewVideo() -> Bool {
        let settings = curSettings[0]
        // checar se estamos na regiao correta
        if settings.locationOn {
            if locationManager == nil {
                initLocation()
            }
            if !CLLocationManager.locationServicesEnabled() {
                return false // evitando que desabilitem o location
            }
            if let location = locationManager?.location {
                for blocked in blockedLocations {
                    let max = locationMax(blocked.radius, (blocked.latitude,blocked.longitude))
                    let delta = (blocked.latitude-max.0, blocked.longitude-max.1)
                    if location.coordinate.latitude >= blocked.latitude - delta.0 && location.coordinate.latitude <= blocked.latitude + delta.0 && location.coordinate.longitude >= blocked.longitude - delta.1 && location.coordinate.longitude <= blocked.longitude + delta.1 {
                        return false
                    }
                }
            }
        }
        
        // checar se o horario esta ok
        if settings.maxTimeOn {
            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let hour = Double(components.hour!) + Double(components.minute!) / 60.0
            if components.hour! < 6 || hour > settings.endTime {
                return false
            }
        }
        
        // checar se temos tempo livre
        if settings.timeOn {
            if (formatDate(Date()) == curSettings[0].today && curSettings[0].watchSecondsToday > Double(curSettings[0].totalTimeInMinutes) * 60) {
                return false
            }
        }
        
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        blockedLocations = fetchBlockedLocations(data)
        
        if !canViewVideo() {
            self.playerView.stop()
            // TODO mostrar tela falando que NAO PODE
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        playerView.delegate = self
        
        curSettings = fetchSettings(data)
        blockedLocations = fetchBlockedLocations(data)
        if curSettings.count < 1 {
            curSettings[0] = dummySettings(data)
        }
        
        playerView.loadWithVideoId(id, with: ["playsinline" : 1])
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
//        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
//            layout.minimumLineSpacing = 5
//            layout.minimumInteritemSpacing = 5
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            let size = CGSize(width:(collectionView!.bounds.width), height: collectionView!.bounds.width)
//            layout.itemSize = size
//        }
        
    }
    
}
