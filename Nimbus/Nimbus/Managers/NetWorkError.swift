//
//  NetWorkError.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/28/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case notConnectedToInternet
    case timeOut
    case cancelled
    case badUrl
    case networkConnectionLost
    case networkResourceUnavailable
    case apiError(message: String)
    case cannotParseJsonError
    case noMobileDataAvailable //return 410 status code
    case sixtyAttemptsExceededInOneMinute
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notConnectedToInternet:
            break
        case .timeOut:
            break
        case .cancelled:
            break
        case .badUrl:
            break
        case .networkConnectionLost:
            break
        case .networkResourceUnavailable:
            break
        case .apiError(let message):
            return NSLocalizedString(message, comment: "came from api error")
        case .cannotParseJsonError:
            break
        case .noMobileDataAvailable:
            break
        case .sixtyAttemptsExceededInOneMinute:
            break
        }
        return NSLocalizedString("Unknown error", comment: "came from localized custom error")
    }
}

//TODO: test errors before uncommenting, add localizedString computed variable in String extension
//extension NetworkError: LocalizedError  {
//    public var errorDescription: String? {
//        switch self {
//        case .notConnectedToInternet :
//            return NSLocalizedString("noConnection_error".localizedString, comment: "No Internet")
//        case .timeOut :
//            return NSLocalizedString("timeOut_error".localizedString, comment: "Request timed out")
//        case .cancelled :
//            return NSLocalizedString("requestCancelled_error".localizedString, comment: "Request cancelled")
//        case .badUrl :
//            return NSLocalizedString("badUrl_error".localizedString, comment: "Invalid url")
//        case .networkConnectionLost :
//            return NSLocalizedString("connectionLost_error".localizedString, comment: "Connection lost")
//        case .networkResourceUnavailable :
//            return NSLocalizedString("networkResource_error".localizedString, comment: "Resource unavailable")
//        case .apiError (let msg, _) :
//            return NSLocalizedString(msg, comment: "Error unknown")
//        case .cannotParseJsonError :
//            return NSLocalizedString("Cannot parse JSON", comment: "No Internet")
//        case .noMobileDataAvailable :
//            return NSLocalizedString("noConnection_error".localizedString, comment: "No Internet")
//        case .sixtyAttemptsExceededInOneMinute :
//            return NSLocalizedString("You have exceeded your limit of 60 requests in one minute", comment: "No Internet")
//        }
//    }
//}
