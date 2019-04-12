//
//  NetworkAdapter.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/26/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation
import Alamofire

class NetworkAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequestConfig = urlRequest
        if !UserSessionChecker.isUserLoggedIn {
            //handle headers when user is not logged in
            
        }
        if  let uuid = UIDevice.current.identifierForVendor?.uuidString {
            urlRequestConfig.setValue(uuid, forHTTPHeaderField: NetworkKeys.Headers.DeviceId)
        }
        urlRequestConfig.setValue("ios", forHTTPHeaderField: NetworkKeys.Headers.Platform)
        guard let authToken = TokenManager.shared.accessToken else {
            return urlRequestConfig
        }
        urlRequestConfig.setValue(String(format:"Token %@", authToken), forHTTPHeaderField: NetworkKeys.Headers.Authorization)
        return urlRequestConfig
    }
}
