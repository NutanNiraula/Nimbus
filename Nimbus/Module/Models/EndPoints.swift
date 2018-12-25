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
    var method: HttpMethod = .post
}

