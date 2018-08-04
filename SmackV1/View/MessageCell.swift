//
//  MessageCell.swift
//  SmackV1
//
//  Created by Kyla Wilson on 8/4/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageTxtLbl: UILabel!

    func UpdateCell(message: Message) {
        userImage.image = UIImage(named: message.userAvatar);
        userImage.backgroundColor = UserDataService.instance.ReturnUIColor(components: message.userAvatarColor);
        usernameLbl.text = message.username;
        messageTxtLbl.text = message.message;
    }
}
