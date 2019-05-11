//
//  ViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 4/26/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import YoutubePlayerView

class ViewController: UIViewController {

    @IBOutlet weak var playerView: YoutubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        playerView.loadWithVideoId("bIQBtAe9jOs", with: ["playsinline" : 1])
    }

}

