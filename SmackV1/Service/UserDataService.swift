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
    
    func ReturnUIColor(components: String) -> UIColor {
        let scanner = Scanner(string: components);
        let skipped = CharacterSet(charactersIn: "[], "); // Skip these characters.
        let comma = CharacterSet(charactersIn: ",");
        
        scanner.charactersToBeSkipped = skipped;
        
        var r, g, b, a: NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r);
        scanner.scanUpToCharacters(from: comma, into: &g);
        scanner.scanUpToCharacters(from: comma, into: &b);
        scanner.scanUpToCharacters(from: comma, into: &a);
        
        let defaultColor = UIColor.lightGray;
        
        guard let rUnwrapped = r else { return defaultColor; }
        guard let gUnwrapped = g else { return defaultColor; }
        guard let bUnwrapped = b else { return defaultColor; }
        guard let aUnwrapped = a else { return defaultColor; }
        
        let rFloat = CGFloat(rUnwrapped.doubleValue);
        let gFloat = CGFloat(gUnwrapped.doubleValue);
        let bFloat = CGFloat(bUnwrapped.doubleValue);
        let aFloat = CGFloat(aUnwrapped.doubleValue);
        
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat);
        
        return newUIColor;
    }
    
    func LogoutUser() {
        id = "";
        avatarName = "";
        avatarColor = "";
        email = "";
        name = "";
        AuthService.instance.isLoggedIn = false;
        AuthService.instance.userEmail = "";
        AuthService.instance.offToken = "";
        MessageService.instance.ClearChannels();
        MessageService.instance.ClearMessages();
    }
}
