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
    
    @IBOutlet weak var pin1: UITextField!
    @IBOutlet weak var pin2: UITextField!
    
    var videos = [Playlist]()
    var destination = String()
    
    @IBOutlet var gearButton: UIBarButtonItem!
    @IBOutlet var clockButton: UIBarButtonItem!
    
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var playlistsView: UIView!
    @IBOutlet weak var videosView: UICollectionView!
    
    var channelsThumbnail = ["FC.jpg", "RTG.jpg", "M.jpg", "JM.jpg", "CSC.jpg"]
    var videoPicThumbnails = ["c.jpg", "lt.jpg", "mb.jpg", "pc.jpg", "pp.jpg"]
    
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == thumbnailCollectionView {
            return channelsThumbnail.count
        } else {
            return videoPicThumbnails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == thumbnailCollectionView { //channels
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelsOnMainCollectionViewCell", for: indexPath) as! ChannelsOnMainCollectionViewCell
            cell.thumbnailImageView.image = UIImage(named: channelsThumbnail[indexPath.row])
            cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
            cell.thumbnailImageView.clipsToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailsOnMainCollectionViewCell", for: indexPath) as! ThumbnailsCollectionViewCell
            cell.videoThumbnails.image = UIImage(named: videoPicThumbnails[indexPath.row])
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
        
        createTestPlaylistInstance(self)
        videos = loadAvailableContent(self)

//        let requisicao: NSFetchRequest<Settings> = Settings.fetchRequest()
//        do {
//            curSettings = try data.fetch(requisicao)
//        } catch  {
//            print("Erro ao ler o contexto: \(error) ")
//        }
        
        setView(self)
        
//        self.smsButton.frame = CGRectMake(0, 0, 30, 30);
//        self.lockButton.frame = CGRectMake(0, 0, 30, 30);
//        
//        gearButton.customView?.frame = CGRect(x: 60, y: 0, width: 25, height: 25)
//        clockButton.customView?.frame = CGRect(x: 60, y: 0, width: 25, height: 25)
        
        //(for: UIBarMetrics(rawValue: -60)!)
        
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

    override func viewDidAppear(_ animated: Bool) {
        setHeader(self)
    }
    
    @IBAction func settingsButton(_ sender: Any) {
    
        let alert = UIAlertController(title: "Insira o PIN para acessar as configurações", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.delegate = (self as UITextFieldDelegate)
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Verificar", style: .default, handler: { (UIAlertAction) in
            let receivedPin = alert.textFields![0].text!
            print("ReceivedPin: \(receivedPin)")
            if receivedPin.count < 4 || receivedPin != self.curSettings[0].pinNumber {
                let newAlert = UIAlertController(title: "PIN inválido", message: nil, preferredStyle: .alert)
                newAlert.addAction(UIKit.UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(newAlert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "goToSettings", sender: (Any).self)
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

