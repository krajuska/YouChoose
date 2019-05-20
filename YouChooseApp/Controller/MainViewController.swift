//
//  MainViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/10/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var engrenagemIcon: UIBarButtonItem!
    @IBOutlet weak var relogioIcon: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setHeader(self)
    }
    
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    @IBOutlet weak var videosCollectionView: UICollectionView!
        
    var thumbnailNames = ["FC.jpg", "RTG.jpg", "M.jpg", "JM.jpg", "CSC.jpg"]
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//            if fetchedRestaurants.count < 1 {
//                loadRestaurants(self)
//            }
//            fetchedRestaurantsByLabel = partitionByLabel(filter, fetchedRestaurants)
//        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnailNames.count
    }
        
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "thumbnailsCV", for: indexPath) as! ThumbnailsCollectionViewOnMainViewController
        thumbnailImageView.image? = UIImage(named: thumbnailNames[indexPath.section])!
        return headerView
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return thumbnailNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let destination = mainStoryBoard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
//            destination.restaurant = fetchedRestaurantsByLabel[indexPath.section].1[indexPath.row]
//            self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width)/3 - 10, height: 110)
    }
}

