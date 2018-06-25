//
//  UserDataService.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/25/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService();
    
    private(set) public var id = "";
    private(set) public var name = "";
    private(set) public var email = "";
    private(set) public var avatarName = "";
    private(set) public var avatarColor = "";
    
    func SetUserData(ID: String, name: String, email: String, avatarName: String, avatarColor: String) {
        self.id = ID;
        self.name = name;
        self.email = email;
        self.avatarName = avatarName;
        self.avatarColor = avatarColor;
    }
    
    func SetAvatarName(avatarName: String) {
        self.avatarName = avatarName;
    }
}
