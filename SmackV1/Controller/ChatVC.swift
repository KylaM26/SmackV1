//
//  ChatVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var revealBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!

    @IBOutlet weak var messageTxtField: UITextField!
    @IBOutlet weak var sendMessageBtn: UIButton!
    
    @IBOutlet weak var messageView: UITableView!
    
    var isTypingMessage: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageView.delegate = self;
        messageView.dataSource = self;
        
        // For dynamic sizing to message lbl.
        messageView.estimatedRowHeight = 80;
        messageView.rowHeight = UITableViewAutomaticDimension;
        
        sendMessageBtn.isHidden = true;
        sendMessageBtn.isEnabled = false;
        
        view.bindToKeyboard();
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.HandleTap));
        view.addGestureRecognizer(tap);
        
        revealBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: UIControlEvents.touchUpInside);
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer());
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer());
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.UserDataDidChange(_:)), name: NOTIFICATION_USER_DATA_CHANGED, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.ChannelSelected(_:)), name: NOTIFICATION_CHANNEL_SELECTED, object: nil);
        
        SocketService.instance.GetNewChatMessage { (success) in
            if success {
                self.messageView.reloadData();
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0);
                    self.messageView.scrollToRow(at: endIndex, at: .bottom, animated: true);
                }
            }
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.FindUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_CHANGED, object: nil);
            }
        }
    }
    
    @IBAction func EditingMessageTxtField(_ sender: Any) {
        if messageTxtField.text == "" {
            isTypingMessage = false;
        } else {
            isTypingMessage = true;
        }
        
        if isTypingMessage == false {
            sendMessageBtn.isEnabled = false;
            sendMessageBtn.isHidden = true;
        } else {
            sendMessageBtn.isEnabled = true;
            sendMessageBtn.isHidden = false;
        }
    }
    
    @IBAction func SendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn && messageTxtField.text != "" {
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
            messageView.reloadData();
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
                self.messageView.reloadData();
            }
        }
    }
    
    // TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = messageView.dequeueReusableCell(withIdentifier: MESSAGE_CELL_IDENTIFER, for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row];
            cell.UpdateCell(message: message);
            return cell;
        }
        return UITableViewCell();
    }

}
