//
//  ChannelVC.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var channelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60; // For slide panel.
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.UserDataDidChange(_:)), name: NOTIFICATION_USER_DATA_CHANGED, object: nil);
        channelView.delegate = self;
        channelView.dataSource = self;
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelsLoaded(_:)), name: NOTIFICATION_CHANNELS_LOADED, object: nil);
        
        SocketService.instance.GetChannel { (success) in // Check for channels.
            print("Function called");
            if success {
                print("Was successful.");
                self.channelView.reloadData();
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SetUpUserInfo();
    }

    @IBAction func LoginPressed(_ sender: Any) {
        if(AuthService.instance.isLoggedIn) {
            let profile = ProfileVC();
            profile.modalPresentationStyle = UIModalPresentationStyle.custom;
            present(profile, animated: true, completion: nil);
        } else {
            performSegue(withIdentifier: LOGIN_SEGUE, sender: nil);
        }
    }
    
    @IBAction func PrepareForUnwindSegue(segue: UIStoryboardSegue){}
    
    @IBAction func AddChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannelVC = AddChannelVC();
            addChannelVC.modalPresentationStyle =  UIModalPresentationStyle.custom;
            present(addChannelVC, animated: true, completion: nil);
        }
    }
    
    @objc func UserDataDidChange(_ notification: Notification) {
        SetUpUserInfo();
    }
    
    @objc func ChannelsLoaded(_ notification: Notification) {
        channelView.reloadData();
    }
    
    func SetUpUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: UIControlState.normal);
            userImage.image = UIImage(named: UserDataService.instance.avatarName);
            userImage.backgroundColor = UserDataService.instance.ReturnUIColor(components: UserDataService.instance.avatarColor);
        } else {
            loginBtn.setTitle("LOGIN", for: UIControlState.normal);
            userImage.image = UIImage(named: "menuProfileIcon");
            userImage.backgroundColor = UIColor.clear;
            channelView.reloadData();
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = channelView.dequeueReusableCell(withIdentifier: CHANNEL_CELL_IDENTIFER, for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row];
            cell.UpdateCell(channel: channel);
            return cell;
        }
        print("Channel view failed to load channel cells.");
        return UITableViewCell();
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChannel = MessageService.instance.channels[indexPath.row];
        MessageService.instance.selectedChannel = selectedChannel;
        NotificationCenter.default.post(name: NOTIFICATION_CHANNEL_SELECTED, object: nil);
        
        self.revealViewController().revealToggle(animated: true);
    }
}
