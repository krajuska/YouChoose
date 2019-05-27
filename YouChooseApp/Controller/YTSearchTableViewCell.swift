//
//  YTSearchTableViewCell.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/26/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import YoutubeKit

class YTSearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var info: UILabel!
    
    var result:SearchResult?
    var uniqueId:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setResult(result:SearchResult) {
        self.result = result
        print(result)
        var isChannel = false
        if let channelId = result.id.channelID {
            self.name.text = result.snippet.channelTitle
            uniqueId = channelId
            isChannel = true
        } else {
            self.name.text = result.snippet.title
            uniqueId = result.id.videoID!
        }
        var image = result.snippet.thumbnails.medium.url
        if image == nil {
            image = result.snippet.thumbnails.high.url
        }
        let currentUniqueId = self.uniqueId!
        if let url = image == nil ? nil : URL(string: image!) {
            DispatchQueue.global().async { [weak self] in
                guard let strongSelf = self
                    else {
                        return
                }
                
                //busca da imagem remota e construção do objeto a partir dos bytes
                if let bytes = try? Data(contentsOf: url) {
                    if let image = UIImage(data: bytes) {
                        DispatchQueue.main.async {
                            if (strongSelf.uniqueId == currentUniqueId) {
                                strongSelf.img.image = image
                                if isChannel {
                                    strongSelf.img.layer.cornerRadius = strongSelf.img.frame.height/2
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
