//
//  ClickOnChannelOrPlaylistViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/22/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit

class ClickOnChannelOrPlaylistViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var curSettings = [Settings]()
    
    @IBOutlet weak var searchBar: UISearchBar! //nao sei ainda o que fazer com isso
    @IBOutlet weak var collectionView: UICollectionView!
    
    var ids = ["RirbY3yKqpw", "E8xEbat6-cg", "TTYOpfGvlwc", "abJfcRUMS_Y"]
    var videoPicThumbnails = ["c.jpg", "lt.jpg", "mb.jpg", "pc.jpg", "pp.jpg"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (ids.count * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clickOnChannelCVC", for: indexPath) as! ClickOnChannelCollectionViewCell
        cell.thumbnailImage.image = UIImage(named: videoPicThumbnails[(indexPath.row % (ids.count))])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.layer.frame.width - 20, height: CGFloat((CGFloat(collectionView.layer.frame.width - 20) * 9) / 16))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        curSettings = fetchSettings(data)
        
    }

}
