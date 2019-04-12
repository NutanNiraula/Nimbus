//
//  Extensions.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    func value() -> String {
        return self ?? "N/A"
    }
}

extension Optional where Wrapped == Int {
    func value() -> Int {
        return self ?? 0
    }
}
