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

    @IBOutlet weak var playerView: YoutubePlayerView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ids = ["RirbY3yKqpw", "E8xEbat6-cg", "TTYOpfGvlwc", "abJfcRUMS_Y"]
    var videoPicThumbnails = ["c.jpg", "lt.jpg", "mb.jpg", "pc.jpg", "pp.jpg"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ids.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosOnPlayerViewCell", for: indexPath) as! PlayerCollectionViewCell
        cell.videoThumbnail.image = UIImage(named: videoPicThumbnails[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let widthSize = collectionView.layer.frame.width / 2
        let heightSize = widthSize*9/16
        return CGSize(width: widthSize-15, height: heightSize-10)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader(self)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        curSettings = fetchSettings(data)
        
        playerView.loadWithVideoId("RirbY3yKqpw", with: ["playsinline" : 1])
        
//        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
//            layout.minimumLineSpacing = 5
//            layout.minimumInteritemSpacing = 5
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            let size = CGSize(width:(collectionView!.bounds.width), height: collectionView!.bounds.width)
//            layout.itemSize = size
//        }
        
    }
    
}
