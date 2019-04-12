//
//  StoryBoard.swift
//  Nimbus
//
//  Created by Nutan Niraula on 4/11/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import UIKit

protocol ViewControllerIdentifiable { }

extension ViewControllerIdentifiable where Self: UIViewController {
    static var name: String {
        return String(describing: self)
    }
}

protocol StoryboardIdentifiable: ViewControllerIdentifiable {
    var name: String {get}
}

extension StoryboardIdentifiable {
    private func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.name, bundle: nil)
    }
    
    func viewController<T: UIViewController>(_: T.Type) -> T where T: ViewControllerIdentifiable {
        return storyboard().instantiateViewController(withIdentifier:T.name) as! T
    }
}

enum Storyboard: String, StoryboardIdentifiable {
    
    var name: String {
        return self.rawValue
    }
    
    case test = "Test"
    
}
