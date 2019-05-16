//
//  SettingsViewModel.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/15/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import UIKit

func setSwitchColor(_ switches: [UISwitch]) {
    for singleSwitch in switches {
        singleSwitch.onTintColor = UIColor.red
    }
}
