//
//  NetworkCallerExtensions.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/26/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation
import Alamofire

extension HTTPMethods {
    var encodingType:ParameterEncoding{
        switch self{
        case .get:
            return URLEncoding.default
        case .post:
            return JSONEncoding.default
        case .put:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
