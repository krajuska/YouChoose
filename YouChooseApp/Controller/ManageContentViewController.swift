//
//  ManageContentViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/27/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit

class ManageContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var channels = [Channel]()
    var playlists = [Playlist]()
    var destination = String()
    
    @IBOutlet weak var tableViewContent: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewContent.delegate = self
        tableViewContent.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if destination == "playlist" {
            return playlists.count
        } else if destination == "channel" {
            return channels.count
        }
        return 0
    }
    
    func refresh() {
        self.tableViewContent.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "content") as! ManageContentTableViewCell
        cell.setChannelOnCell(channels[indexPath.row])
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
