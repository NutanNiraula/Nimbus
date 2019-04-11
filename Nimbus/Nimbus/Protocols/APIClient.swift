//
//  APIClient.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import UIKit

protocol APIClient {
    var endPoint: EndPointProtocol { get set }
    var cancellableRequest: RequestCancellable { get set }
    var code: Int? { get set }
    func request(withObject object: BaseRequestModel?, completion: @escaping ((NetworkResult<Data?>) -> ()))
    func upload(data: Data,key: String,type: String?, progressValue: @escaping (_ progress: Progress?) -> (), completion: @escaping ((NetworkResult<Data?>) -> ()))
    func sendMultipartData(imgObject: [String: [Data]], requestObj: BaseRequestModel?,  completion: @escaping ((NetworkResult<Data?>) -> ()))
}

extension APIClient {
    
    func animateNetworkIndicator(start: Bool = true) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = start
    }
    
}
