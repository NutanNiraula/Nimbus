//
//  EndPointProtocol.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/22/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
    var url: URL? {get set}
    var method: HTTPMethods {get}
}
