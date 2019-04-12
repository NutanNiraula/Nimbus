//
//  NetworkKeys.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/26/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

struct NetworkKeys {
    static let DeviceType = "ios"
    
    struct UserDefaults {
        static let accessToken = "access_token"
        static let refreshToken = "refresh_token"
        static let deviceToken = "device_token"
    }
    
    struct Headers {
        static let Authorization = "Authorization"
        static let ContentType = "Content-Type"
        static let DeviceId = "Device-Id"
        static let Platform = "Platform"
        static let Locale = "Locale"
    }
    
    struct LanguageCode {
        static let English = "en"
    }
}
