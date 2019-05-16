//
//  SettingsViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/8/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var choices = ["0h15m", "0h30m", "0h45m", "1h00m",
                   "1h15m", "1h30m", "1h45m", "2h00m",
                   "2h15m", "2h30m", "2h45m", "3h00m",
                   "3h15m", "3h30m", "3h45m", "4h00m",
                   "4h15m", "4h30m", "4h45m", "5h00m"]
    var pickerView = UIPickerView()
    var typeValue = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(choices.count)
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(choices[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            typeValue = (row+1) * 15
        } else if row == 1 {
            typeValue = (row+1) * 15
        } else if row == 2 {
            typeValue = (row+1) * 15
        } else if row == 3 {
            typeValue = (row+1) * 15
        } else if row == 4 {
            typeValue = (row+1) * 15
        } else if row == 5 {
            typeValue = (row+1) * 15
        } else if row == 6 {
            typeValue = (row+1) * 15
        } else if row == 7 {
            typeValue = (row+1) * 15
        } else if row == 8 {
            typeValue = (row+1) * 15
        } else if row == 9 {
            typeValue = (row+1) * 15
        } else if row == 10 {
            typeValue = 165
        } else if row == 11 {
            typeValue = 180
        } else if row == 12 {
            typeValue = 195
        } else if row == 13{
            typeValue = 210
        } else if row == 14 {
            typeValue = 225
        } else if row == 15 {
            typeValue = 240
        } else if row == 16 {
            typeValue = 255
        } else if row == 17 {
            typeValue = 270
        } else if row == 18 {
            typeValue = 285
        } else if row == 19 {
            typeValue = 300
        }
    }
    
    @IBAction func getHorario(_ sender: Any) {
        let alert = UIAlertController(title: "Tempo máximo de exibição diária:", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 200))
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { (UIAlertAction) in
            print("Tempo máximo: \(self.typeValue)")
            if self.typeValue != 0 {
                self.settingsSwitches[2].isOn = true
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet var settingsSwitches: [UISwitch]!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //mudar o label caso o pinSet seja true para "redefinir"
    @IBOutlet weak var setPinLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader(self)
        getSettings(self)
        setSwitchColor(settingsSwitches)
    }
  
    @IBAction func setSchedule(_ sender: Any) {
        let popup = UIAlertController(title: "Tempo máximo de exibição (em minutos)", message: "\n\n\n\n\n\n\n", preferredStyle: .alert)
        popup.addAction(UIAlertAction(title: "Salvar", style: .default, handler: {action in
            let result = String()
            //função pra salvar
        }))
        popup.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(popup, animated: true)
    }

    @IBAction func setTimer(_ sender: Any) {
        
    }
    @IBAction func setPIN(_ sender: Any) {
        
    }
    @IBAction func hideSettings(_ sender: Any) {
        
    }
    
    
}
