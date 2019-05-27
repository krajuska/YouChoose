//
//  ManageContentTableViewCell.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/27/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit

class ManageContentTableViewCell: UITableViewCell {

    var channel = Channel()
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setChannelOnCell(_ channel: Channel) {
        self.img.image = UIImage(named: channel.channelImg!)
        self.label.text! = channel.channelName!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
