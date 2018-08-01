//
//  ChatVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var revealBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        revealBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside);
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer());
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.UserDataDidChange(_:)), name: NOTIFICATION_USER_DATA_CHANGED, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.ChannelSelected(_:)), name: NOTIFICATION_CHANNEL_SELECTED, object: nil);
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.FindUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil);
            }
        }
    }
    
    @objc func UserDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
            // Get channels
            GetChannels();
        } else {
            channelNameLbl.text = "Please Log In";
        }
    }
    
    @objc func ChannelSelected(_ notification: Notification) {
        UpdateWithChannel();
    }

    func UpdateWithChannel() {
        let channelName =  MessageService.instance.selectedChannel?.channelTitle ?? "SMACK";
        channelNameLbl.text = "#\(channelName)";
    }
    
    func GetChannels() {
        MessageService.instance.FindAllChannels { (success) in
            
        }
    }
}
