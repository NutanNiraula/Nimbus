//
//  AppCoordinator.swift
//  Nimbus
//
//  Created by Nutan Niraula on 4/11/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation
import UIKit

enum CoordinatorList: String {
    case authCoordinator
    case driverCoordinator
    case shipperCoordinator
}

class AppCoordinator {
    
    var navigationController: UINavigationController?
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    init(navigationController nc: UINavigationController) {
        navigationController = nc
    }
    
    func setInitialPage(isUserLoggedIn isLoggedIn: Bool) {
        let testVC = Storyboard.test.viewController(ViewController.self)
        appDelegate.window?.rootViewController = testVC
        appDelegate.window?.makeKeyAndVisible()
    }
    
}
