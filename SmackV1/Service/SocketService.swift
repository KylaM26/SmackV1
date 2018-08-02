//
//  SocketService.swift
//  SmackV1
//
//  Created by Kyla Wilson on 7/31/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService();
    
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!); // Point to API url.
    
    override init() {
        super.init();
        
    }
    
    func EstablishConnection() {
        socket.connect(); // Connects to server.
    }
    
    func CloseConnection() {
        socket.disconnect(); // Disconnects from server.
    }
    
    func AddChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription);
        completion(true);
    }
    
    func GetChannel(completion: @escaping CompletionHandler) { // Listening for when a channel is created.
        socket.on("channelCreated") { (dataArray, ACK) in
            guard let channelName = dataArray[0] as? String else { return; }
            guard let channelDescription = dataArray[1] as? String else { return; }
            guard let channelID = dataArray[2] as? String else { return; }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelID);
            MessageService.instance.channels.append(newChannel);
            completion(true);
        }
    }
    
    func AddMessage(messageBody: String, userID: String, channelID: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance;
        socket.emit("newMessage", messageBody, userID, channelID, user.name, user.avatarName, user.avatarColor);
        completion(true);
    }
}
