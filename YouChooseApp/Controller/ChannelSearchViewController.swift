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

//
//  SearchListRequest.swift
//  YoutubeKit
//
//  Created by Ryo Ishikawa on 12/30/2017
//
// Essa classe está aqui porque o parâmetro "type" (resourceType) era encodado
// de modo errado na biblioteca orginal :(


/// SeeAlso: https://developers.google.com/youtube/v3/docs/search/list
public struct SearchListRequestFix: Requestable {
    
    public typealias Response = SearchList
    
    public var path: String {
        return "search"
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var isAuthorizedRequest: Bool {
        switch filter {
        case .forContentOwner(_)?:
            return true
        case .forMine(_)?:
            return true
        case .relatedToVideoID(_)?:
            return false
        case .none:
            return false
        }
    }
    
    func appendQuery(_ q: inout [String:Any], key:String, value:Any?) {
        if let value = value {
            q[key] = value
        }
    }
    func appendQuery<T: RawRepresentable>(_ q: inout [String:Any], key: String, value: T?) where T.RawValue == String {
        if let value = value {
            q[key] = value.rawValue
        }
    }
    
    public var queryParameters: [String : Any] {
        var q: [String: Any] = [:]
        
        let part = self.part
            .map { $0.rawValue }
            .joined(separator: ",")
        appendQuery(&q, key: "part", value: part)
        
        if let filterParam = filter?.keyValue {
            q[filterParam.key] = filterParam.value
        }
        
        appendQuery(&q, key: "channelId", value: channelID)
        appendQuery(&q, key: "q", value: searchQuery)
        appendQuery(&q, key: "topicId", value: topicID)
        if let resourceType = resourceType {
            appendQuery(&q, key:"type", value: resourceType.map({ $0.rawValue }).joined(separator: ","))
        }
        appendQuery(&q, key: "videoCategoryId", value: videoCategoryID)
        appendQuery(&q, key: "channelType", value: channelType)
        appendQuery(&q, key: "eventType", value: eventType)
        appendQuery(&q, key: "maxResults", value: maxResults)
        appendQuery(&q, key: "onBehalfOfContentOwner", value: onBehalfOfContentOwner)
        appendQuery(&q, key: "order", value: order)
        appendQuery(&q, key: "pageToken", value: pageToken)
        appendQuery(&q, key: "publishedAfter", value: publishedAfter)
        appendQuery(&q, key: "publishedBefore", value: publishedBefore)
        appendQuery(&q, key: "regionCode", value: regionCode)
        appendQuery(&q, key: "safeSearch", value: safeSearch)
        appendQuery(&q, key: "videoCaption", value: videoCaption)
        appendQuery(&q, key: "videoDefinition", value: videoDefinition)
        appendQuery(&q, key: "videoDimension", value: videoDimension)
        appendQuery(&q, key: "videoDuration", value: videoDuration)
        appendQuery(&q, key: "videoEmbeddable", value: videoEmbeddable)
        appendQuery(&q, key: "videoLicense", value: videoLicense)
        appendQuery(&q, key: "videoSyndicated", value: videoSyndicated)
        appendQuery(&q, key: "videoType", value: videoType)
        
        return q
    }
    
    // MARK: - Required parameters
    
    public let part: [Part.SearchList]
    
    // MARK: - Option parameters
    
    public let filter: Filter.SearchList?
    public let channelID: String?
    public let channelType: String?
    public let eventType: SearchEventType?
    public let maxResults: Int?
    public let onBehalfOfContentOwner: String?
    public var order: ResultOrder.Search?
    public let pageToken: String?
    public let publishedAfter: Date?
    public let publishedBefore: Date?
    public let searchQuery: String?
    public let regionCode: String?
    public let safeSearch: SearchSafeMode?
    public let topicID: String?
    public let resourceType: [SearchResourceType]?
    public let videoCaption: SearchVideoCaption?
    public let videoCategoryID: VideoCategoryID?
    public let videoDefinition: SearchVideoDefinition?
    public let videoDimension: SearchVideoDimension?
    public let videoDuration: SearchVideoDuration?
    public let videoEmbeddable: SearchVideoEmbeddable?
    public let videoLicense: SearchVideoLicense?
    public let videoSyndicated: SearchVideoSyndicated?
    public let videoType: SearchVideoType?
    
    public init(part: [Part.SearchList],
                filter: Filter.SearchList? = nil,
                channelID: String? = nil,
                channelType: String? = nil,
                eventType: SearchEventType? = nil,
                maxResults: Int? = nil,
                onBehalfOfContentOwner: String? = nil,
                order: ResultOrder.Search? = nil,
                pageToken: String? = nil,
                publishedAfter: Date? = nil,
                publishedBefore: Date? = nil,
                searchQuery: String? = nil,
                regionCode: String? = nil,
                safeSearch: SearchSafeMode? = nil,
                topicID: String? = nil,
                resourceType: [SearchResourceType]? = nil,
                videoCaption: SearchVideoCaption? = nil,
                videoCategoryID: VideoCategoryID? = nil,
                videoDefinition: SearchVideoDefinition? = nil,
                videoDimension: SearchVideoDimension? = nil,
                videoDuration: SearchVideoDuration? = nil,
                videoEmbeddable: SearchVideoEmbeddable? = nil,
                videoLicense: SearchVideoLicense? = nil,
                videoSyndicated: SearchVideoSyndicated? = nil,
                videoType: SearchVideoType? = nil) {
        self.part = part
        self.filter = filter
        self.channelID = channelID
        self.channelType = channelType
        self.eventType = eventType
        self.maxResults = maxResults
        self.onBehalfOfContentOwner = onBehalfOfContentOwner
        self.order = order
        self.pageToken = pageToken
        self.publishedAfter = publishedAfter
        self.publishedBefore = publishedBefore
        self.searchQuery = searchQuery
        self.regionCode = regionCode
        self.safeSearch = safeSearch
        self.topicID = topicID
        self.resourceType = resourceType
        self.videoCaption = videoCaption
        self.videoCategoryID = videoCategoryID
        self.videoDefinition = videoDefinition
        self.videoDimension = videoDimension
        self.videoDuration = videoDuration
        self.videoEmbeddable = videoEmbeddable
        self.videoLicense = videoLicense
        self.videoSyndicated = videoSyndicated
        self.videoType = videoType
    }
}

// mudar para um nome mais generico pq isso busca qq coisa :)
class ChannelSearchViewController: UIViewController, UITableViewDataSource,  UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var resultsView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results = [SearchResult]()
    var nextPageToken : String?
    var searchMode : [SearchResourceType]?
    var waitingForSearch = false
    var onValueSelected : ((SearchResult)->Void)?
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let onValueSelected = onValueSelected {
            onValueSelected(results[indexPath.row])
        }
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
            var request = SearchListRequestFix(part: [.id,.snippet], maxResults: 50, searchQuery: text, safeSearch: SearchSafeMode.strict, resourceType: self.searchMode)
            if self.searchMode != nil && self.searchMode![0] == .channel && self.searchMode!.count == 1 {
                request.order = .viewCount
            }
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
