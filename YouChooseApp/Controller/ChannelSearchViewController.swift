//
//  ChannelSearchViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/26/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import struct YoutubeKit.Channel
import YoutubeKit

// mudar para um nome mais generico pq isso busca qq coisa :)
class ChannelSearchViewController: UIViewController, UITableViewDataSource,  UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var resultsView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results = [SearchResult]()
    var nextPageToken : String?
    var searchMode = [SearchResourceType]()
    var waitingForSearch = false
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func refresh() {
        self.resultsView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result") as! YTSearchTableViewCell
        cell.setResult(result: results[indexPath.row])
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if waitingForSearch {
            return
        }
        waitingForSearch = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.waitingForSearch = false
            self.performSearch()
        }
    }
    
    func performSearch() {
        if let text = searchBar.text {
            let request = SearchListRequest(part: [.id,.snippet], maxResults: 50, searchQuery: text, safeSearch: SearchSafeMode.strict, resourceType: self.searchMode)
            ApiSession.shared.send(request) { result in
                switch result {
                case .success(let response):
                    self.results = response.items
                    self.nextPageToken = response.nextPageToken
                    self.refresh()
                case .failed(let error):
                    print(error)
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsView.delegate = self
        resultsView.dataSource = self
        searchBar.delegate = self

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
