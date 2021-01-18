//
//  constants.swift
//  Flash Chat iOS13
//
//  Created by Fady Magdy on 1/13/21.
//  Copyright © 2021 Fady Magdy. All rights reserved.
//
struct K {
    static let welcomeToLogin = "welcomeToLogin"
    static let welcomeToRegester = "welcomeToRegester"
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "loginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
