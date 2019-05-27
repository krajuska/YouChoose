//
//  MainViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/10/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var curSettings = [Settings]()
    var providers = [VideoProvider]()
    
    var destination = String()
    
    @IBOutlet weak var pin1: UITextField!
    @IBOutlet weak var pin2: UITextField!
    
    @IBOutlet var gearButton: UIBarButtonItem!
    @IBOutlet var clockButton: UIBarButtonItem!
    
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var playlistsView: UIView!
    @IBOutlet weak var videosView: UICollectionView!
    
    var channelsThumbnail = ["FC.jpg", "RTG.jpg", "M.jpg", "JM.jpg", "CSC.jpg"]
    
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == thumbnailCollectionView {
            return providers.count
        } else {
            return getVideoProviderVideos(providers[section]).count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == thumbnailCollectionView {
            return 1
        } else {
            return providers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == thumbnailCollectionView { //channels
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelsOnMainCollectionViewCell", for: indexPath) as! ChannelsOnMainCollectionViewCell
            let provider = providers[indexPath.row]
            cell.thumbnailImageView.image = getChannelAndPlaylistThumbnail(self, getVideoProviderPic(provider))
            cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.height / 2
            cell.thumbnailImageView.clipsToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailsOnMainCollectionViewCell", for: indexPath) as! ThumbnailsCollectionViewCell
            let videos = getVideoProviderVideos(providers[indexPath.section])
            let video = videos[indexPath.row]
            cell.videoThumbnails.image = getVideoThumbnail(self, video)
            return cell
        }
//        let title = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: cell.bounds.size.width, height: cell.bounds.size.height))
//        title.textColor = UIColor.red
//        cell.contentView.addSubview(title)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == thumbnailCollectionView {
             return CGSize(width: collectionView.layer.frame.height-10, height: collectionView.layer.frame.height-10)
        }
        return CGSize(width: collectionView.layer.frame.width - 20, height: CGFloat((CGFloat(collectionView.layer.frame.width - 20) * 9) / 16))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == thumbnailCollectionView {
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let destination = mainStoryBoard.instantiateViewController(withIdentifier: "availableContent") as! ClickOnChannelOrPlaylistViewController
            destination.videos = getVideoProviderVideos(providers[indexPath.row])
            
            self.navigationController?.pushViewController(destination, animated: true)
        } else {
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let destination = mainStoryBoard.instantiateViewController(withIdentifier: "player") as! PlayerViewController
            let videos = getVideoProviderVideos(providers[indexPath.section])
            let video = videos[indexPath.row]
            destination.videos = videos
            destination.id = video.id!
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.count)! > 3 {
            return false
        }
        return true
    }
    
    @IBAction func tutorialSaveButton(_ sender: Any) {
        checkPin(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnailCollectionView.delegate = self
        thumbnailCollectionView.dataSource = self
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        
//        getChannelFromId(data, "UCSTzvPF1Fti4v7DBc9WfJGA") { channel in
//            do {
//                try
//                    self.data.save()
//            } catch(_) {
//                fatalError()
//            }
//        }
        
//        setView(self)
        
        curSettings = fetchSettings(data)
//        if curSettings.count < 1 {
//            curSettings[0] = dummySettings(data) //atualizar depois
//        }
        
//        createTestPlaylistInstance(self)
//        videos = loadAvailableContent(self)

//        let requisicao: NSFetchRequest<Settings> = Settings.fetchRequest()
//        do {
//            curSettings = try data.fetch(requisicao)
//        } catch  {
//            print("Erro ao ler o contexto: \(error) ")
//        }

        setView(self)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
//        self.smsButton.frame = CGRectMake(0, 0, 30, 30);
//        self.lockButton.frame = CGRectMake(0, 0, 30, 30);
    
        
        //(for: UIBarMetrics(rawValue: -60)!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        providers = getEveryChannelAndPlaylist(data)
        populateContent(self)
        self.thumbnailCollectionView.reloadData()
        self.videosCollectionView.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        gearButton.customView?.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
//        gearButton.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        gearButton.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
//
//
//        clockButton.customView?.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
//        clockButton.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        clockButton.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
//
//        self.navigationItem.rightBarButtonItems = [clockButton, gearButton]
//    }


    @IBAction func settingsButton(_ sender: Any) {
        goToSettings(self, data)
    }
}

