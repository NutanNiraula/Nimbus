//
//  Uploadable.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/28/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

public protocol Uploadable {
    var formData: Data {get}
    var fileName: String {get}
    var type: String? {get}
    var key: String {get}
}

struct ProfileData: Uploadable {
    var formData: Data
    var fileName: String
    var type: String?
    var key: String
}
