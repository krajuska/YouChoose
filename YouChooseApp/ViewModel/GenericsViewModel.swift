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
    
//    if view is MainViewController {
//        let mainView = MainViewController()
//        let menuBtn = UIButton(type: .custom)
//        let frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
//        menuBtn.frame = frame
//        menuBtn.setImage(UIImage(named:"canal.png"), for: .normal)
//        menuBtn.setImage(UIImage(named:"canal.png"), for: .selected)
//        mainView.gearButton = UIBarButtonItem(customView: menuBtn)
//        let currWidth = mainView.gearButton.customView?.widthAnchor.constraint(equalToConstant: 25)
//        currWidth?.isActive = true
//        let currHeight = mainView.gearButton.customView?.heightAnchor.constraint(equalToConstant: 25)
//        currHeight?.isActive = true
//
//        let menuBtn2 = UIButton(type: .custom)
//        menuBtn2.frame = frame
//        menuBtn2.setImage(UIImage(named:"canal.png"), for: .normal)
//        menuBtn2.setImage(UIImage(named:"canal.png"), for: .selected)
//        mainView.clockButton = UIBarButtonItem(customView: menuBtn2)
//        let currWidth2 = mainView.clockButton.customView?.widthAnchor.constraint(equalToConstant: 25)
//        currWidth2?.isActive = true
//        let currHeight2 = mainView.clockButton.customView?.heightAnchor.constraint(equalToConstant: 25)
//        currHeight2?.isActive = true
//        view.navigationItem.rightBarButtonItems = [mainView.gearButton, mainView.clockButton]
//    }
}

func getSettings(_ view: SettingsViewController) {
//    do {
//        view.fetchedSettings = try view.context.fetch(view.settingsFetch) as! [Settings]
//    } catch {
//        fatalError("Failed to fetch settings: \(error)")
//    }
}
