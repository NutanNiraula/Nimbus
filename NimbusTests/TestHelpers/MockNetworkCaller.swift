//
//  MockNetworkCaller.swift
//  NimbusTests
//
//  Created by Nutan Niraula on 2/14/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation
@testable import Nimbus

enum ApiResponse {
    case failure(jsonFileName: String)
    case success(jsonFileName: String)
}

//TODO: improve mock caller by integrating endpoint urls to fetch file
class MockNetworkCaller: APIClient {
    
    func sendMultipartData(imgObject: [String : [Data]], requestObj: BaseRequestModel?, completion: @escaping ((NetworkResult<Data?>) -> ())) {
        
    }
    
    var code: Int?
    
    var endPoint: EndPointProtocol
    var cancellableRequest: RequestCancellable
    var response: ApiResponse?
    
    private class fakeEndPoint: EndPointProtocol {
        var url: URL?
        var method: HTTPMethods = .get
    }
    
    private class fakeRequest: RequestCancellable {
        var request: URLSessionTask?
        
        func cancel() {}

        func resume() {}
        
        func pause() {}
    }
    
    init() {
        endPoint = fakeEndPoint()
        cancellableRequest = fakeRequest()
    }
    
    func request(withObject object: BaseRequestModel?, completion: @escaping ((NetworkResult<Data?>) -> ())) {
        guard let mockResponse = response else {
            fatalError("response of success and failure must be provided")
        }
        switch mockResponse {
        case .success(let jsonFileName):
            let data = JsonReader.createData(fromJSONFile: jsonFileName)
            completion(NetworkResult.success(data))
        case .failure(let jsonFileName):
            let errorData = JsonReader.createData(fromJSONFile: jsonFileName)
            let parsedError = parseErrorMessage(fromData: errorData)
            completion(NetworkResult.failure(parsedError))
        }
    }
    
    private func parseErrorMessage(fromData data: Data) -> Error {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let errorMessage = (json.first?.value as? [String])?.first {
                let err = NetworkError.apiError(message: errorMessage)
                return err
            }
        } catch let error {
            return error
        }
        return NetworkError.apiError(message: "Unknown Error")
    }
    
    func upload(data: Data, key: String, type: String?, progressValue: @escaping (Progress?) -> (), completion: @escaping ((NetworkResult<Data?>) -> ())) {
        
    }
    
}
