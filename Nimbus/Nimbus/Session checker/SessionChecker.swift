//
//  SessionChecker.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/26/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

class UserSessionChecker {
    static var defaults = UserDefaults.standard
    static var accessTokenKey = NetworkKeys.UserDefaults.accessToken
    
    static var isUserLoggedIn: Bool {
        return defaults.value(forKey: accessTokenKey) != nil
    }
    
    static func clearUserDefaults() {
        let dictionary = defaults.dictionaryRepresentation()
        for key in dictionary.keys {
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
}
