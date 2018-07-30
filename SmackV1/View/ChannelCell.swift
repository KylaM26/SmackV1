//
//  ChannelCell.swift
//  SmackV1
//
//  Created by Kyla Wilson on 7/30/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    @IBOutlet weak var channelTitle: UILabel!;
    
    func UpdateCell(channel: Channel) {
        let title = channel.channelTitle ?? "";
        channelTitle.text = "#\(title)";
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor;
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor;
        }
    }

}
