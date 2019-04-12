//
//  JsonReader.swift
//  NimbusTests
//
//  Created by Nutan Niraula on 2/14/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

class JsonReader {
    
    static func createData(fromJSONFile fileName: String) -> Data {
        guard let path = TestBundle().returnPath(forResource: fileName, ofType: "json") else {
            fatalError("couldnt find path")
        }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return data
    }
    
}
