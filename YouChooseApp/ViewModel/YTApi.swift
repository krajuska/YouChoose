//
//  YTApi.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/27/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import Foundation
import CoreData
import YoutubeKit

let youtubeApiKey = "AIzaSyDoDP5Hgig-HTNKsCvWtQPYrwWyIHQQDFo"

func getChannelThumbnail(_ channelId:String, _ callback:@escaping (String?)->Void) {
    let task = URLSession.shared.dataTask(with: URL(string: "https://www.googleapis.com/youtube/v3/channels?part=snippet&fields=items%2Fsnippet%2Fthumbnails%2Fdefault&id=\(channelId)&key=\(youtubeApiKey)")!) { (data, rawResponse, error) in
        if let error = error {
            print(error)
            DispatchQueue.main.async {
                callback(nil)
            }
            return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, AnyObject>
            // $channelOBJ->items[0]->snippet->thumbnails->default->url;
            if let items = json == nil ? nil : json!["items"] as? Array<NSObject> {
                if let item = items[0] as? Dictionary<String, AnyObject> {
                    if let snippet = item["snippet"] as? Dictionary<String, AnyObject> {
                        if let thumbnails = snippet["thumbnails"] as? Dictionary<String, AnyObject> {
                            if let def = thumbnails["default"] as? Dictionary<String, AnyObject> {
                                if let url = def["url"] as? String {
                                    DispatchQueue.main.async {
                                        callback(url)
                                    }
                                    return
                                }
                            }
                        }
                    }
                }
            }
        } catch _ {
        }
        DispatchQueue.main.async {
            callback(nil)
        }
    }
    task.resume()
}

func getChannelFromId(_ data: NSManagedObjectContext, _ channelId:String, _ callback:@escaping (Channel?)->Void) {
    getChannelThumbnail(channelId) { thumbnail in
        if let thumbnail = thumbnail {
            let request = SearchListRequest(part: [.id, .snippet], channelID: channelId, maxResults:50, order:ResultOrder.Search.date, safeSearch: SearchSafeMode.strict)
            ApiSession.shared.send(request) { results in
                switch results {
                case .success(let results):
                    if (results.items.count == 0) {
                        callback(nil)
                        return
                    }
                    let channel = NSEntityDescription.insertNewObject(forEntityName: "Channel", into: data) as! Channel
                    for result in results.items {
                        if let video = getVideoFromResult(data, result) {
                            channel.addToVideos(video)
                        }
                    }
                    channel.channelID = channelId
                    channel.channelImg = thumbnail
                    channel.channelName = results.items[0].snippet.channelTitle
                    callback(channel)
                case .failed(let error):
                    print(error)
                    callback(nil)
                }
            }
        } else {
            callback(nil)
        }
    }
}

func getVideoFromResult(_ data: NSManagedObjectContext, _ result:SearchResult) -> Video? {
    if result.id.videoID == nil {
        return nil
    }
    
    let video = NSEntityDescription.insertNewObject(forEntityName: "Video", into: data) as! Video
    video.id = result.id.videoID!
    video.thumbnail = result.snippet.thumbnails.high.url
    video.title = result.snippet.title
    return video
}
