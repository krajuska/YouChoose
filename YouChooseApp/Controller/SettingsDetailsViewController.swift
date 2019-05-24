//
//  SettingsDetailsViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/13/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import CoreData

class SettingsDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var curSettings = [Settings]()
    
    var videosSelected = [String]()
    var channelsSelected = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if destination == "playlists" {
            return videosSelected.count
        } else if destination == "channels" {
            return channelsSelected.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")
        var text = String()
        
        if destination == "playlists" {
            text = videosSelected[indexPath.row]
        } else if destination == "channels" {
            text = channelsSelected[indexPath.row]
        }
        
        cell!.textLabel!.text = text
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            videosSelected.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var imgViewOutlet: UIImageView!
    @IBOutlet weak var buscarText: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    var destination = String()
    
    @IBAction func buscarButton(_ sender: Any) {
        buscarAlert(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        viewSetUp(self)
        videosSelected = dummyPlaylists(self)
        
        curSettings = fetchSettings(data)
        
        refresh(self)
    }
}
