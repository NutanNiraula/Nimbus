//
//  NimbusSessionManager.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/25/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation
import Alamofire

class NimbusSessionManager: APIClient {
    var cancellableRequest: RequestCancellable
    var endPoint: EndPointProtocol
    var alamofireSessionManger: Alamofire.SessionManager!
    var code: Int?
    
    init(endPoint: EndPointProtocol){
        self.endPoint = endPoint
        self.alamofireSessionManger = Alamofire.SessionManager(configuration: NimbusConfigurator.shared.sessionConfiguration)
        alamofireSessionManger.adapter = NetworkAdapter()
        self.cancellableRequest = AlamofireRequestManager()
        //TODO: uncomment after implementing Oauth flow in app
        //        alamofireSessionManger.retrier = NetworkRetrier()
    }
    
    func request(withObject object: BaseRequestModel? = nil, completion: @escaping ((NetworkResult<Data?>) -> ())) {
        self.animateNetworkIndicator(start: true)
        guard let url = self.endPoint.url else {return}
        var headers: [String: String]?
        if let headerfetchableObject = object as? HeaderFetchable {
            headers = headerfetchableObject.headers
        }
        
        let request = alamofireSessionManger.request(url, method: self.endPoint.method.alamofireEquivalentHTTPMethod(), parameters: object?.getRequestParameters(), encoding: self.endPoint.method.encodingType, headers: headers).validate(statusCode: 200...499)
        
        self.cancellableRequest = AlamofireRequestManager(withAlamofirerequest: request)
        
        print("*** API REQUEST *** \n REQUEST URL: \(String(describing: request.request))\n REQUEST HEADERS: \(String(describing: request.request?.allHTTPHeaderFields))\n REQUEST BODY: \(String(describing: request.request?.httpBody?.prettyPrintedJson()))")
        //        print(request.request?.allHTTPHeaderFields)
        
        request.responseData { [weak self] (dataResponse) in
            switch dataResponse.result {
            case .success(let data):
                print("\(data.prettyPrintedJson())")
                let code = dataResponse.response!.statusCode
                self?.code = code
                // this is pattern matching code which is same as if code >= 400 && code <= 499
                if 400 ... 499 ~= code {
                    //condition for session expiry
                    if code == 401 {
                        self?.expireSession()
                        return
                    }
                    completion(NetworkResult.failure((self?.parseErrorMessage(fromData: data))!))
                } else if 200 ... 299 ~= code {
                    completion(NetworkResult.success(data))
                }
            case .failure(let error):
                completion(NetworkResult.failure(error))
            }
        }
        self.animateNetworkIndicator(start: false)
    }
    
    func expireSession() {
        UserSessionChecker.clearUserDefaults()
        let alert = UIAlertController(title: "Session expired.", message: "Relogin to continue",preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { (action) in
            let mainNavController = UINavigationController()
            let appCoordinator = AppCoordinator(navigationController: mainNavController)
            appCoordinator.setInitialPage()
        }))
        let topVC = ViewControllerUtility.getTopMostVC()
        if topVC?.presentedViewController == nil {
            topVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    func parseErrorMessage(fromData data: Data) -> Error {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            if let errorMessage = (json.first?.value as? [String])?.first {
                let err = NetworkError.apiError(message: errorMessage)
                return err
            }
        } catch let error {
            return error
        }
        return NetworkError.apiError(message: "Unknown Error")
    }
    
    func upload(data: Data,key: String,type: String? = nil, progressValue: @escaping (_ progress: Progress?) -> () = { _ in }, completion: @escaping ((NetworkResult<Data?>) -> ()))  {
        guard let url = self.endPoint.url else {return}
        let multipartFormData = MultipartFormData()
        multipartFormData.append(data, withName: key, fileName: "\(key).jpg", mimeType:data.mimeType)
        if let temp = type {
            multipartFormData.append(temp.data(using: .utf8)!, withName: "type")
        } else {
            print("Type not set for this image")
        }
        guard let data = try? multipartFormData.encode() else {
            fatalError("Couldnot decode data")
        }
        animateNetworkIndicator(start: true)
        let request = alamofireSessionManger.upload(data,
                                                    to: url,
                                                    method: .post,
                                                    headers: ["Content-Type": multipartFormData.contentType])
        self.cancellableRequest = AlamofireRequestManager(withAlamofirerequest: request)
        request.responseData(completionHandler: {(response) in
            switch response.result {
            case .success(let data):
                completion(NetworkResult.success(data))
            case .failure(let error):
                completion(NetworkResult.failure(error))
            }
            self.animateNetworkIndicator(start: false)
        })
        request.uploadProgress(closure: { (progress) in
            progressValue(progress)
        })
    }
    
    func sendMultipartData(imgObject: [String: [Data]], requestObj: BaseRequestModel? = nil,  completion: @escaping ((NetworkResult<Data?>) -> ())) {
        
        // This function is used to convert [String:Any] to jsonString
        func convertDictionaryToJsonString(dict: [String: Any]) -> String {
            let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions())
            if let jsonString = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue) {
                return "\(jsonString)"
            }
            return ""
        }
        
        guard let url = self.endPoint.url else {return}
        let multipartFormData = MultipartFormData()
        
        if let reqObj = requestObj, let param = reqObj.getRequestParameters() {
            for (key, value) in param {
                if let nestedJson = value as? [String: Any] {
                    let str = convertDictionaryToJsonString(dict: nestedJson)
                    multipartFormData.append(str.data(using: .utf8)!, withName: key)
                    print("converted \(String(describing: str)) \(key))")
                } else {
                    // if it is not nested json convert all other type to string and encode it to utf8
                    multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
                    print("converted \(String(describing: value)) \(key))")
                }
            }
        }
        
        for (key, value) in imgObject {
            for (_, data) in value.enumerated() {
                multipartFormData.append(data, withName: key, fileName: "\(key).jpg", mimeType: data.mimeType)
            }
        }
        
        guard let data = try? multipartFormData.encode() else {
            fatalError("Couldnot decode data")
        }
        animateNetworkIndicator(start: true)
        
        let request = alamofireSessionManger.upload(data,
                                                    to: url,
                                                    method: endPoint.method.alamofireEquivalentHTTPMethod(),
                                                    headers: ["Content-Type": multipartFormData.contentType]).validate(statusCode: 200...499)
        self.cancellableRequest = AlamofireRequestManager(withAlamofirerequest: request)
        
        print("*** API REQUEST *** \n REQUEST URL: \(String(describing: request.request))\n REQUEST HEADERS: \(String(describing: request.request?.allHTTPHeaderFields))\n REQUEST BODY: \(String(describing: request.request?.httpBody?.prettyPrintedJson()))")
        
        request.responseData(completionHandler: {[weak self] (response) in
            switch response.result {
            case .success(let data):
                print("DATA: \(data.prettyPrintedJson())")
                let code = response.response!.statusCode
                self?.code = code
                // this is pattern matching code which is same as if code >= 400 && code <= 499
                if 400 ... 499 ~= code {
                    //condition for session expiry
                    if code == 401 {
                        self?.expireSession()
                        return
                    }
                    completion(NetworkResult.failure((self?.parseErrorMessage(fromData: data))!))
                } else if 200 ... 299 ~= code {
                    completion(NetworkResult.success(data))
                }
            case .failure(let error):
                completion(NetworkResult.failure(error))
            }
            self?.animateNetworkIndicator(start: false)
        })
        
        request.uploadProgress(closure: { (progress) in
            print("PROGRESS \(progress)")
        })
    }
    
}
