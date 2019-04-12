//
//  ViewControllerUtility.swift
//  Nimbus
//
//  Created by Nutan Niraula on 3/19/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import UIKit

struct ViewControllerUtility {
    static func getTop(from window: UIWindow?) -> UIViewController? {
        if let wrappedWindow = window, var topController = wrappedWindow.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    static func getTopMostVC() -> UIViewController? {
        guard var topVC = ViewControllerUtility.getTop(from: AppDelegate.getCurrentWindow()) else { return nil }
        if let top =  topVC as? UINavigationController, let navTop = top.topViewController {
            topVC = navTop
        } else {
            if let vc = topVC as? UINavigationController {
                topVC = vc.viewControllers.first!
            }
        }
        return topVC
    }
}

extension AppDelegate {
    static func getCurrentWindow() -> UIWindow? {
        return (UIApplication.shared.delegate as! AppDelegate).window
    }
}
