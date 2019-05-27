//
//  ClickOnChannelOrPlaylistViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/22/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit

class ClickOnChannelOrPlaylistViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var curSettings = [Settings]()
    var videos = [Video]()
    
    @IBOutlet weak var searchBar: UISearchBar! //nao sei ainda o que fazer com isso
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var gearButton: UIBarButtonItem!
    @IBOutlet var clockButton: UIBarButtonItem!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //todo -- NOT WORKING PROPERLY
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clickOnChannelCVC", for: indexPath) as! ClickOnChannelCollectionViewCell
        let video = videos[indexPath.row]
        cell.thumbnailImage.image = getVideoThumbnail(self, video)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = mainStoryBoard.instantiateViewController(withIdentifier: "player") as! PlayerViewController
        let video = videos[indexPath.row]
        destination.videos = self.videos
        destination.id = video.id!
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.layer.frame.width - 20, height: CGFloat((CGFloat(collectionView.layer.frame.width - 20) * 9) / 16))
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        goToSettings(self, data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    

}
