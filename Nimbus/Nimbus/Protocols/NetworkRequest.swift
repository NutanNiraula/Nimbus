//
//  NetworkRequest.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

protocol BaseRequestModel: Encodable {}

extension BaseRequestModel {
    func getRequestParameters() -> [String: Any]? {
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(self) {
            do {
                return  try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
}
