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

    //init pickerview stuff
    var tempoMaxChoices = ["0h15m", "0h30m", "0h45m", "1h00m",
                           "1h15m", "1h30m", "1h45m", "2h00m",
                           "2h15m", "2h30m", "2h45m", "3h00m",
                           "3h15m", "3h30m", "3h45m", "4h00m",
                           "4h15m", "4h30m", "4h45m", "5h00m"]
    
    var horarioMaxChoices = ["15h00", "15h30", "16h00", "16h30",
                             "17h00", "17h30", "18h00", "18h30",
                             "19h00", "19h30", "20h00", "20h30",
                             "21h00", "21h30", "22h00"]
    
    var maxTimePickerView = UIPickerView()
    var limitTimePickerView = UIPickerView()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == maxTimePickerView {
            return tempoMaxChoices.count
        } else if pickerView == limitTimePickerView {
            return horarioMaxChoices.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == maxTimePickerView {
            return tempoMaxChoices[row]
        } else if pickerView == limitTimePickerView {
            return horarioMaxChoices[row]
        }
        return "error"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == maxTimePickerView {
            tempoMax = (row+1) * 15
        } else if pickerView == limitTimePickerView {
            horarioMax = Double((15 + (Float(row)/2)))
        }
    }
    //end pickerview stuff
    
    //tempo maximo vars
    var tempoMax = 0
    var tempoMaxIsSet = false //conferir se houve alteração caso nao salve pelo botão
    var insideSetTempoMax = false
    
    //horario maximo vars
    var horarioMax = 0.0 //double pq pode ser tipo 22h30 >> 22.5
    var horarioMaxIsSet = false //conferir se houve alteração caso nao salve pelo botão
    var insideSetHorario = false
    
    //dai da um prompt de "ei voce mudou coisas, deseja salvar?"

    @IBOutlet var settingsSwitches: [UISwitch]!
    
    @IBAction func setTempoMax(_ sender: Any) {
        insideSetTempoMax = true
        if self.settingsSwitches[1].isOn {
            let alert = UIAlertController(title: "Tempo máximo de exibição diária:", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
            alert.isModalInPopover = true
            maxTimePickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 200))
            alert.view.addSubview(maxTimePickerView)
            maxTimePickerView.dataSource = self
            maxTimePickerView.delegate = self
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {(UIAlertAction) in
                self.settingsSwitches[1].isOn = false //ver se esse bug é do simulador ou no iphone tb
            }))
            alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { (UIAlertAction) in
                print("Tempo máximo: \(self.tempoMax)")
                self.tempoMaxIsSet = true
                }))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.tempoMaxIsSet = false
            print(tempoMaxIsSet)
        }
        insideSetTempoMax = false
    }
    
    @IBAction func setHorario(_ sender: Any) {
        insideSetHorario = true
        if self.settingsSwitches[2].isOn {
            let alert = UIAlertController(title: "Horário limite de exibição:", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
            alert.isModalInPopover = true
            limitTimePickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 200))
            alert.view.addSubview(limitTimePickerView)
            limitTimePickerView.dataSource = self
            limitTimePickerView.delegate = self
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: {(UIAlertAction) in
                self.settingsSwitches[2].isOn = false //ver se esse bug é do simulador ou no iphone tb
            }))
            alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { (UIAlertAction) in
                print("Tempo máximo: \(self.horarioMax)")
                self.horarioMaxIsSet = true
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.horarioMaxIsSet = false
            print(horarioMaxIsSet)
        }
        insideSetHorario = false
    }
    
    @IBAction func saveSettings(_ sender: Any) {
        curSettings[0].totalTimeInMinutes = Int16(tempoMax)
        curSettings[0].endTime = horarioMax
        curSettings[0].maxTimeOn = tempoMaxIsSet
        curSettings[0].timeOn = horarioMaxIsSet
        print(curSettings)
//        curSettings[0].pinNumber = Int16(setPIN)
//        curSettings[0].hideSettings = hideAccess
//        curSettings[0].pinSet = true
//        curSettings[0].hideSettings = true
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
}
