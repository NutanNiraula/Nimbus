//
//  NetworkCallerFactory.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/26/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

enum NetworkCallerTypes {
    case http
    case mockHttp(mockCaller: APIClient)
}

class NetworkCallerFactory {
    
    var callerType: NetworkCallerTypes
    
    init(callerType type: NetworkCallerTypes = .http) {
        callerType = type
    }
    
    func createNetworkCaller(endPoint ep: EndPointProtocol) -> APIClient {
        switch callerType {
        case .http:
            return NimbusSessionManager(endPoint: ep)
        case .mockHttp(let mockCaller):
            return mockCaller
        }
    }
}
