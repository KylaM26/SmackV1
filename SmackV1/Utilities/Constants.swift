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
let AVATAR_PICKER_SEGUE: String = "AvatarPickerVC";
// User deafults
let TOKEN_KEY: String = "token";
let LOGGED_IN_KEY: String = "loggedIn";
let USER_EMAIL: String = "userEmail";

// URL constants
let BASE_URL: String = "https://smackapplication.herokuapp.com/v1/"; // Added v1 because in the api v1 is behind the URL.
let URL_REGISTER: String = "\(BASE_URL)account/register"; // The URL for registering a user
let URL_LOGIN: String = "\(BASE_URL)account/login";
let URL_USER_ADD: String = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL: String = "\(BASE_URL)user/byEmail/";
let URL_GET_CHANNELS: String = "\(BASE_URL)/channel/"
let URL_GET_MESSAGES: String = "\(BASE_URL)/message/byChannel/"


// API HEADERS
let HEADER = [
    "Content-Type":"application/json; charset=utf-8"
];

let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.offToken)",
    "Content-Type":"application/json; charset=utf-8"
];

// IDENTIFIERS
let CHANNEL_CELL_IDENTIFER = "ChannelCell";

// COLORS
let smackPurplePlaceholder = #colorLiteral(red: 0.5910333991, green: 0.5910333991, blue: 0.5910333991, alpha: 0.5)

// NOTIFICATIONS
let NOTIFICATION_USER_DATA_CHANGED = Notification.Name("NotificationUserDataChanged");
let NOTIFICATION_CHANNELS_LOADED = Notification.Name("NotificationChannelsLoaded");
let NOTIFICATION_CHANNEL_SELECTED = Notification.Name("NotificationChannelSelected");
