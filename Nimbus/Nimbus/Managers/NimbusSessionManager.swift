//
//  NimbusSessionManager.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

class NimbusSessionManager: APIClient {
    var endPoint: EndPointProtocol
    var dataTask: URLSessionDataTask?
    
    init(withEndPoint endPoint: EndPointProtocol) {
        self.endPoint = endPoint
    }
    
    func request(withObject object: BaseRequestModel? = nil, completion: @escaping ((NetworkResult<Data?>) -> ())) {
        let sharedConfiguration = NimbusConfigurator.shared.sessionConfiguration
        let session = URLSession(configuration: sharedConfiguration)
        dataTask?.cancel()
        
        if object.self is Decodable.Type { //header fetchable uploadable
            
        }
        
        guard let url = endPoint.url else {return}
        dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil {
                completion(NetworkResult.success(data))
            } else {
                completion(NetworkResult.failure(error ?? NetworkError.apiError(message: "unknown error")))
            }
        }
        dataTask?.resume()
    }
}
