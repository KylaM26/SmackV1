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
                print(self.channels[0].channelTitle);
                print("Here!");
                completion(true);
            } else {
                completion(false);
                debugPrint(response.result.error as Any);
            }
        }
    }
}
