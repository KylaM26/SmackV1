//
//  MessageService.swift
//  SmackV1
//
//  Created by Kyla Wilson on 7/25/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import Foundation
import Alamofire

class MessageService {
    static let instance = MessageService();
    
    var channels = [Channel]();
    var messages = [Message]();
    var selectedChannel: Channel?
    
    func FindAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                let json = response.result.value as? [Dictionary<String, Any>];
                for item in json! {
                    if let name = item["name"] as? String {
                        if let description = item["description"] as? String {
                            if let id = item["_id"] as? String {
                                let channel = Channel(channelTitle: name, channelDescription: description, id: id);
                                self.channels.append(channel);
                            }
                        }
                    }
                }
                NotificationCenter.default.post(name: NOTIFICATION_CHANNELS_LOADED, object: nil);
                completion(true);
            } else {
                completion(false);
                debugPrint(response.result.error as Any);
            }
        }
    }
    
    func ClearChannels() {
        channels.removeAll();
    }
    
    func FindAllMessagesForChannel(channelID: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelID)", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.ClearMessages();
                if let json = response.result.value as? [Dictionary<String, Any>] {
                    for item in json {
                        if let messageBody = item["messageBody"] as? String {
                            if let channelID = item["channelId"] as? String {
                                if let id = item["_id"] as? String {
                                    if let userName = item["userName"] as? String {
                                        if let userAvatar = item["userAvatar"] as? String {
                                            if let userAvatarColor = item["userAvatarColor"] as? String {
                                                if let timeStamp = item["timeStamp"] as? String {
                                                    let message = Message(message: messageBody, username: userName, channelID: channelID, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp);
                                                    print(self.messages);
                                                    print("User avatar: \(userAvatar)");
                                                    self.messages.append(message);
                                                    completion(true);
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
            } else {
                debugPrint(response.result.error as Any);
                completion(false);
            }
        }
    }
        
        func ClearMessages() {
            messages.removeAll();
        }
}
