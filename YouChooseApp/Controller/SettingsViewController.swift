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
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var curSettings = [Settings]()

    var choices = ["0h15m", "0h30m", "0h45m", "1h00m",
                   "1h15m", "1h30m", "1h45m", "2h00m",
                   "2h15m", "2h30m", "2h45m", "3h00m",
                   "3h15m", "3h30m", "3h45m", "4h00m",
                   "4h15m", "4h30m", "4h45m", "5h00m"]
    
    var pickerView = UIPickerView()
    var setHorario = 0
    var setTempoMaximo = 0
    var setPIN = 0
    var hideAccess = false
    
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
        setHorario = (row+1) * 15
        setTempoMaximo = (row+1) * 2
        setPIN = 6924
        hideAccess = true
    }
    
    @IBOutlet var settingsSwitches: [UISwitch]!
    
    
    //mudar o label caso o pinSet seja true para "redefinir"
    @IBOutlet weak var setPinLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeader(self)
        getSettings(self)
        setSwitchColor(settingsSwitches)
        createFirstSettingsInstance(self)
        
        let fetchSettings: NSFetchRequest<Settings> = Settings.fetchRequest()
        do {
            curSettings = try data.fetch(fetchSettings)
            print(curSettings)
        } catch {
            print("Error: \(error)")
        }
    }
  
    @IBAction func saveSettings(_ sender: Any) {
        curSettings[0].totalTimeInMinutes = Int16(setTempoMaximo)
        curSettings[0].pinNumber = Int16(setPIN)
        curSettings[0].hideSettings = hideAccess
        curSettings[0].maxTimeOn = true
        curSettings[0].pinSet = true
        curSettings[0].hideSettings = true
        curSettings[0].endTime = Int16(setHorario)
        curSettings[0].initTime = Int16(setHorario / 2)
        curSettings[0].timeOn = true
        do {
            try data.save()
        } catch  {
            print("Erro ao salvar o contexto: \(error) ")
        }
        
        var printSettings = [Settings]()
        let requisicao: NSFetchRequest<Settings> = Settings.fetchRequest()
        do {
            printSettings = try data.fetch(requisicao)
        } catch  {
            print("Erro ao ler o contexto: \(error) ")
        }
        print(printSettings[0])
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
            print("Tempo máximo: \(self.setHorario)")
            
            if self.setHorario != 0 {
                self.settingsSwitches[2].isOn = true
            }
        }))
        self.present(alert, animated: true, completion: nil)
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
}
