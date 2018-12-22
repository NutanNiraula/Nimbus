//
//  AppUrls.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/22/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

struct AppUrls {
    private static let urlBuilder = URLBuilder().set(scheme: "http").set(host: "insightworkshop.io")
    
    static func getAppUrl(fromPath path: String) -> URL? {
        return AppUrls.urlBuilder.set(path: path).build()
    }
}
