//
//  HeaderFetchable.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/26/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

protocol HeaderFetchable {
    var headers : [String : String] {get}
}
