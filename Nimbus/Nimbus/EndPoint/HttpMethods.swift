//
//  HttpMethods.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/22/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethods: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case connect = "CONNECT"
    case trace = "TRACE"
    case options = "OPTIONS"
    
    func alamofireEquivalentHTTPMethod() -> HTTPMethod {
        switch self {
        case .options:
            return HTTPMethod.options
        case .get:
            return HTTPMethod.get
        case .head:
            return HTTPMethod.head
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .patch:
            return HTTPMethod.patch
        case .delete:
            return HTTPMethod.delete
        case .trace:
            return HTTPMethod.trace
        case .connect:
            return HTTPMethod.connect
        }
    }
}
