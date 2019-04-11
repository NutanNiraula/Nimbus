//
//  testBundle.swift
//  NimbusTests
//
//  Created by Nutan Niraula on 2/14/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

class TestBundle {
    
    func returnPath(forResource: String, ofType: String) -> String? {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: forResource, ofType: ofType) {
            return path
        } else {
            return nil
        }
    }
    
}
