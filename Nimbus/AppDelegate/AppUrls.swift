//
//  AppUrls.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/22/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

struct AppUrls {
    private static let urlBuilder = URLBuilder().set(scheme: "https").set(host: "jsonplaceholder.typicode.com")
    
    static func getAppUrl(fromPath path: String) -> URL? {
        return AppUrls.urlBuilder.set(path: path).build()
    }
}

//TODO: remove the test code
// just to check the configuration of custom url
struct ThirdPartyTestEndPoint: EndPointProtocol {
    var url: URL? = URLBuilder()
        .set(scheme: "https")
        .set(host: "host")
        .set(path: "path")
        .build()
    var method: HTTPMethods = .get
}
