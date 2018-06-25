//
//  Constants.swift
//  SmackV1
//
//  Created by Kyla Wilson on 6/21/18.
//  Copyright © 2018 Kyla. All rights reserved.
//

import Foundation

// Type Alias --> Renaming a type
typealias CompletionHandler = (_ Succcess: Bool) -> (); // A closure, once it is completed it will pass in true or false

// Segues
let LOGIN_SEGUE: String = "LoginVC";
let CREATE_ACCOUNT_SEGUE: String = "CreateAccountVC";
let UNWIND_CHANNEL: String = "UnwindToChannel";

// User deafults
let TOKEN_KEY: String = "token";
let LOGGED_IN_KEY: String = "loggedIn";
let USER_EMAIL: String = "userEmail";

// URL constants
let BASE_URL: String = "https://smackapplication.herokuapp.com/v1/"; // Added v1 because in the api v1 is behind the URL.
let URL_REGISTER: String = "\(BASE_URL)account/register"; // The URL for registering a user
