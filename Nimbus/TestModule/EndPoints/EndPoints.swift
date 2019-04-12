//
//  EndPoints.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/22/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

struct ToDoDataEndPoint: EndPointProtocol {
    var url: URL?  = AppUrls.getAppUrl(fromPath: "todos")
    var method: HTTPMethods = .get
}

struct PlaceHolderImageEndPoint: EndPointProtocol {
    var url: URL? = URLBuilder().set(scheme: "https").set(host: "via.placeholder.com").set(path: "1500").build()
    var method: HTTPMethods = .get
}
