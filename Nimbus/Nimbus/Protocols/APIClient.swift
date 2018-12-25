//
//  APIClient.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

protocol APIClient {
    var endPoint: EndPointProtocol { get set }
    func request(withObject object: BaseRequestModel?, completion: @escaping ((NetworkResult<Data?>) -> ()))
}
