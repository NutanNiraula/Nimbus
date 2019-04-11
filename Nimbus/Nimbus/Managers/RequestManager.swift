//
//  RequestManager.swift
//  Nimbus
//
//  Created by Nutan Niraula on 1/3/19.
//  Copyright © 2019 Insight Workshop. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireRequestManager: RequestCancellable {
    
    var request: URLSessionTask?
    
    init() {
        
    }
    
    init(withAlamofirerequest req: DataRequest) {
        self.request = req.task
    }
    
    func cancel() {
        guard let req = request else {
            print("******* NIL REQUEST ******")
            return
        }
        req.cancel()
        print("******* REQUEST CANCELLED ******")
    }
    
    func resume() {
        guard let req = request else {
            print("******* NIL REQUEST ******")
            return
        }
        req.resume()
         print("******* REQUEST RESUMED ******")
    }
    
    func pause() {
        guard let req = request else {
            print("******* NIL REQUEST ******")
            return
        }
        req.suspend()
         print("******* REQUEST PAUSED ******")
    }
}
