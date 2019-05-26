//
//  PlayerViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/23/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import YoutubePlayerView

class PlayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var curSettings = [Settings]()
    var providers = [VideoProvider]()

    @IBOutlet weak var playerView: YoutubePlayerView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var id = String()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getVideoProviderVideos(providers[section]).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosOnPlayerViewCell", for: indexPath) as! PlayerCollectionViewCell
        let videos = getVideoProviderVideos(providers[indexPath.section])
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
        let videos = getVideoProviderVideos(providers[indexPath.section])
        let video = videos[indexPath.row]
        self.id = video.id!
        viewDidLoad()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader(self)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        curSettings = fetchSettings(data)
        if curSettings.count < 1 {
            curSettings[0] = dummySettings(data)
        }
        
        providers = getEveryChannelAndPlaylist(self, data)
        playerView.loadWithVideoId(id, with: ["playsinline" : 1])
        
//        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
//            layout.minimumLineSpacing = 5
//            layout.minimumInteritemSpacing = 5
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            let size = CGSize(width:(collectionView!.bounds.width), height: collectionView!.bounds.width)
//            layout.itemSize = size
//        }
        
    }
    
}
