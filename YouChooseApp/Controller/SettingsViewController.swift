//
//  SettingsViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/8/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import CoreData
import YoutubeKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var curSettings = [Settings]()
    var destination = String()
    var tempEndTime = Double()
    var tempTotalTimeInMinutes = Int16()

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.count)! > 3 {
            return false
        }
        return true
    }

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
            tempTotalTimeInMinutes = Int16((row+1) * 15)
        } else if pickerView == limitTimePickerView {
            tempEndTime = Double((15 + (Float(row)/2)))
        }
    }
    //end pickerview stuff

    @IBOutlet var settingsSwitches: [UISwitch]!
    
    @IBAction func setLocalizacao(_ sender: Any) {
        if self.settingsSwitches[0].isOn {
            curSettings[0].locationOn = true
            performSegue(withIdentifier: "goToMaps", sender: sender)
        } else {
            curSettings[0].locationOn = false
        }
    }
    
    @IBAction func setTempoMax(_ sender: Any) {
        if self.settingsSwitches[1].isOn {
            let alert = UIAlertController(title: "Tempo máximo de exibição diária:", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
            alert.isModalInPopover = true
            maxTimePickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 200))
            alert.view.addSubview(maxTimePickerView)
            maxTimePickerView.dataSource = self
            maxTimePickerView.delegate = self
            alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { (UIAlertAction) in
                if self.tempTotalTimeInMinutes == 0 {
                    self.curSettings[0].totalTimeInMinutes = Int16(15)
                } else {
                    self.curSettings[0].totalTimeInMinutes = self.tempTotalTimeInMinutes
                }
                self.curSettings[0].timeOn = true
                }))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.settingsSwitches[1].isOn = false
            curSettings[0].timeOn = false
        }
    }
    
    @IBAction func setHorario(_ sender: Any) {
        if self.settingsSwitches[2].isOn {
            let alert = UIAlertController(title: "Horário limite de exibição:", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
            alert.isModalInPopover = true
            limitTimePickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 200))
            alert.view.addSubview(limitTimePickerView)
            limitTimePickerView.dataSource = self
            limitTimePickerView.delegate = self
            alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { (UIAlertAction) in
                self.curSettings[0].endTime = self.tempEndTime
                self.curSettings[0].maxTimeOn = true
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.settingsSwitches[2].isOn = false
            curSettings[0].maxTimeOn = false
        }
    }
    
    @IBAction func setPIN(_ sender: Any) {
        let alert = UIAlertController(title: "PIN de segurança", message: "Seu PIN deve ser composto por 4 dígitos numéricos.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.delegate = self
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { (UIAlertAction) in
            let receivedPin = alert.textFields![0].text!
            print("ReceivedPin: \(receivedPin)")
            if receivedPin.count < 4 {
                let newAlert = UIAlertController(title: "PIN inválido", message: "Seu PIN deve ser composto por 4 dígitos numéricos. Tente novamente.", preferredStyle: .alert)
                newAlert.addAction(UIKit.UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(newAlert, animated: true, completion: nil)
            } else {
                self.curSettings[0].pinNumber = receivedPin
                let newPinSetAlert = UIAlertController(title: "Novo PIN configurado", message: "Lembre-se: após salvar, sua nova senha será \(self.curSettings[0].pinNumber ?? "error").", preferredStyle: .alert)
                newPinSetAlert.addAction(UIKit.UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(newPinSetAlert, animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func hideSettings(_ sender: Any) {
        if settingsSwitches[3].isOn {
            curSettings[0].hideSettings = true
        } else {
            curSettings[0].hideSettings = false
        }
    }
    
    
    @IBAction func saveSettings(_ sender: Any) {
        printSettings(curSettings[0])
        
        let settings = fetchSettings(data)
        let objectUpdate = settings[0] as NSManagedObject
        
        objectUpdate.setValue(curSettings[0].endTime, forKey: "endTime")
        objectUpdate.setValue(curSettings[0].hideSettings, forKey: "hideSettings")
        objectUpdate.setValue(curSettings[0].locationOn, forKey: "locationOn")
        objectUpdate.setValue(curSettings[0].maxTimeOn, forKey: "maxTimeOn")
        objectUpdate.setValue(curSettings[0].pinNumber, forKey: "pinNumber")
        objectUpdate.setValue(curSettings[0].timeOn, forKey: "timeOn")
        objectUpdate.setValue(curSettings[0].totalTimeInMinutes, forKey: "totalTimeInMinutes")
        
        do {
            try data.save()
        } catch {
            fatalError()
        }
        
        printSettings(curSettings[0])
    }
    
    @IBAction func createPlaylist(_ sender: Any) {
        destination = "playlists"
        print("destination: \n \(destination)\n")
    }
    
    @IBAction func addChannels(_ sender: Any) {
        destination = "channels"
        print("destination: \n \(destination)\n")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwitchColor(settingsSwitches)
        curSettings = fetchSettings(data)
        setSwitches(settingsSwitches, curSettings[0])
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChannelSearchViewController {
            if segue.identifier == "add_channels" {
                destination.searchMode = [SearchResourceType.channel]
                destination.onValueSelected = { value in
                    getChannelFromId(self.data, value.id.channelID!, { channel in
                        self.navigationController?.popViewController(animated: true)
                        // TODO adicionar mensagem
                        do {
                            try self.data.save()
                        } catch {
                            fatalError()
                        }
                    })
                }
            } else if segue.identifier == "add_playlists" {
                destination.searchMode = [SearchResourceType.playlist]
            }
        }
        if segue.destination is SettingsDetailsViewController {
            let settingsDetailsView = segue.destination as! SettingsDetailsViewController
            if self.destination == "playlists" {
                settingsDetailsView.destination = "playlists"
            } else if self.destination == "channels" {
                settingsDetailsView.destination = "channels"
            }
        }
    }
}
