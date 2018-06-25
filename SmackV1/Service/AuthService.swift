//
//  AuthService.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/22/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import Foundation
import Alamofire
 // Will handle login, create, and register user functions, etc.

class AuthService {
    
    static let instance = AuthService();
    
    // Persistant variables.
    // Ex: Keeping up with weather the user has logged in and logged out(so the user won't have to type pass word evertime app is reopened.), offToken, and Email.
    let defaults = UserDefaults.standard; // An interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app.
    
    // Getters & Setters, Readable and Writable. Will be persistant across application lauches
    var isLoggedIn: Bool {
        get { // For get, look into the user deafults and see if a value exist.
            return defaults.bool(forKey: LOGGED_IN_KEY);
        } set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY); // newValue means whatever we set this to when We call it.
        }
    }
    
    var offToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String;
        } set {
            defaults.set(newValue, forKey: TOKEN_KEY);
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String;
        } set {
            defaults.set(newValue, forKey: USER_EMAIL);
        }
    }
    
    // Register User with AlmoFire
    
    // This function job is to post a new user into the server.
    func RegisterUser(email: String, password: String, completion: @escaping CompletionHandler) { // Two parameters in Register User POST
        // Create a completion handler(constants), because when the data is being fetched we have to wait until it is back, or else we will be looking for data does not exist which will result in a crash.
        let lowercaseEmail = email.lowercased();
        
        // API Header
        let header = [
            "Content-Type":"application/json; charset=utf-8"
        ];
        
        // API Body
        let body: [String: Any] = [
            "email": lowercaseEmail,
            "password": password
        ];
        
        // POST REQUEST
        // The url to the register, what kind of http is it?, The body parameters, Regular JSON data, The header
        Alamofire.request(URL_REGISTER, method: HTTPMethod.post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil { // If there is no error.
                completion(true); // We succesfully retrieved the data from the server.
            } else {
                completion(false);
                debugPrint(response.result.error as Any); //  What went wrong.
            }
        };
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
