//
//  NimbusConfigurator.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

class NimbusConfigurator {
    static let shared = NimbusConfigurator()
    var sessionConfiguration: URLSessionConfiguration
    var requestTimeOutInterval: Double = 45
    var responseTimeOutInterval: Double = 45
    var cachePolicy: NSURLRequest.CachePolicy = .returnCacheDataElseLoad
    
    init() {
        self.sessionConfiguration = URLSessionConfiguration.default // can be ephemeral and background
        sessionConfiguration.timeoutIntervalForRequest = requestTimeOutInterval
        sessionConfiguration.timeoutIntervalForResource = responseTimeOutInterval
        sessionConfiguration.requestCachePolicy = cachePolicy
        URLCache.shared = {
            URLCache(memoryCapacity: 100 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
        }()
        //        if diskPath == xxxx, the Cache.db file is store at:
        //        (App Folder)/Library/Caches/com.mycompany.appname/xxxx/Cache.db
    }
}
