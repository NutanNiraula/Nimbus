//
//  EndPoints.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/22/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

struct LoginEndPoint: EndPointProtocol {
    var url: URL?  = AppUrls.getAppUrl(fromPath: "api/login")
    var method: HttpMethod = .post
}

struct ThirdPartyTestEndPoint: EndPointProtocol {
    var url: URL? = URLBuilder()
        .set(scheme: "https")
        .set(host: "host")
        .set(path: "path")
        .build()
    var method: HttpMethod = .get
}
