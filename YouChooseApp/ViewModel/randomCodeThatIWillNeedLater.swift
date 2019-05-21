//
//  randomCodeThatIWillNeedLater.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/20/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import CoreData
import UIKit

var fetchedPlaylists = [Playlist]()
var fetchedChannels = [Channel]()

//tem uma search bar que acho que daria pra integrar com o api do youtube

let playlistFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Playlist")
let channelFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Channel")

func forWhenINeedToFetchPlaylistsAndChannel(_ view: SettingsViewController) {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedPlaylists.count
}
