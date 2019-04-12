//
//  NetworkResult.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import UIKit

enum NetworkResult<Value> {
    case success(Value)
    case failure(Error)
}

//enum NetworkError: Error {
//    case apiError(message: String)
//}

extension NetworkResult {
    func returnValue() throws -> Value {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

extension NetworkResult where Value == Data? {
    func decodeJson<ResponseType: Decodable>(toType: ResponseType.Type) -> NetworkResult<ResponseType>  {
        switch self {
        case .success(let data):
            do {
                guard let data = data else {
                    return NetworkResult<ResponseType>.failure(NetworkError.apiError(message: "data is nil"))
                }
                let decoder = JSONDecoder()
                let decodedResult = try decoder.decode(ResponseType.self, from: data)
                print("decoded \(decodedResult)")
                return NetworkResult<ResponseType>.success(decodedResult)
            } catch let error {
                print("error \(error.localizedDescription)")
                return NetworkResult<ResponseType>.failure(error)
            }
        case .failure(let error):
            return NetworkResult<ResponseType>.failure(error)
        }
    }
    
    func getPNGImage() -> NetworkResult<UIImage>  {
        switch self {
        case .success(let data):
                guard let imgData = data, let image = UIImage(data: imgData) else {
                    return NetworkResult<UIImage>.failure(NetworkError.apiError(message: "image couldn't be decoded"))
                }
                return NetworkResult<UIImage>.success(image)
        case .failure(let error):
            return NetworkResult<UIImage>.failure(error)
        }
    }
}
