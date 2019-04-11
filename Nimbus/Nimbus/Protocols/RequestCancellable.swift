//
//  RequestCancellable.swift
//  Nimbus
//
//  Created by Nutan Niraula on 1/3/19.
//  Copyright © 2019 Insight Workshop. All rights reserved.
//

import Foundation

protocol RequestCancellable {
    var request: URLSessionTask? {get set}
    func cancel()
    func resume()
    func pause()
}
