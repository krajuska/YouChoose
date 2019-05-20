//
//  ApplyOnAllScreens.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/10/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//mudar nome da função (navBarSetup)
func setHeader<T: UIViewController>(_ view: T) {
    view.navigationItem.title = "YouChoose"
    view.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    if view is MainViewController {        
        let menuBtn = UIButton(type: .custom)
        let frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.frame = frame
        menuBtn.setImage(UIImage(named:"relogio.png"), for: .normal)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true

        let menuBtn2 = UIButton(type: .custom)
        menuBtn2.frame = frame
        menuBtn2.setImage(UIImage(named:"engrenagem.png"), for: .normal)
        let menuBarItem2 = UIBarButtonItem(customView: menuBtn2)
        let currWidth2 = menuBarItem2.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth2?.isActive = true
        let currHeight2 = menuBarItem2.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight2?.isActive = true
        view.navigationItem.rightBarButtonItems = [menuBarItem, menuBarItem2]
    }
}

//func setUpMenuButton<T: UIViewController>(_ view: T) {
//    if view is MainViewController {
//        let menuBtn = UIButton(type: .custom)
//        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
//        menuBtn.setImage(UIImage(named:"menuIcon"), for: .normal)
//        menuBtn.addTarget(view, action: #selector(vc.onMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
//
//        let menuBarItem = UIBarButtonItem(customView: menuBtn)
//        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
//        currWidth?.isActive = true
//        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
//        currHeight?.isActive = true
//        view.navigationItem.leftBarButtonItem = menuBarItem
//    }
//}

func getSettings(_ view: SettingsViewController) {
//    do {
//        view.fetchedSettings = try view.context.fetch(view.settingsFetch) as! [Settings]
//    } catch {
//        fatalError("Failed to fetch settings: \(error)")
//    }
}
