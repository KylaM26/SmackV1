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

    @IBOutlet weak var messageTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard();
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.HandleTap));
        view.addGestureRecognizer(tap);
        
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
    
    @IBAction func SendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelID = MessageService.instance.selectedChannel?.id else {return;}
            guard let message = messageTxtField.text else { return; }
            SocketService.instance.AddMessage(messageBody: message, userID: UserDataService.instance.id, channelID: channelID) { (success) in
                if success {
                    self.messageTxtField.text = "";
                    self.messageTxtField.resignFirstResponder();
                }
            }
        }
    }
    
    @objc func UserDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
            // Get channels
            GetMessagesOnLogin();
        } else {
            channelNameLbl.text = "Please Log In";
        }
    }
    
    @objc func ChannelSelected(_ notification: Notification) {
        UpdateWithChannel();
    }
    
    @objc func HandleTap() {
        view.endEditing(true);
    }

    func UpdateWithChannel() {
        let channelName =  MessageService.instance.selectedChannel?.channelTitle ?? "SMACK";
        channelNameLbl.text = "#\(channelName)";
        GetMessages();
    }
    
    func GetMessagesOnLogin() {
        MessageService.instance.FindAllChannels { (success) in
            if(success) {
                if MessageService.instance.channels.count > 0 { // If there is a channel
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]; // On default set the first channel as selected channel.
                    self.UpdateWithChannel();
                } else {
                    self.channelNameLbl.text = "No channels";
                }
            }
        }
    }
    
    func GetMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return; }
        MessageService.instance.FindAllMessagesForChannel(channelID: channelId) { (success) in
            if success {
                print("Messages Fetched!");
            }
        }
    }
}
