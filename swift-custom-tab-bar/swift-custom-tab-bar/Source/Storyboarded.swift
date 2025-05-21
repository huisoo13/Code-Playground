//
//  Storyboarded.swift
//  MokokoRecord
//
//  Created by 정희수 on 2023/06/23.
//

import UIKit

protocol Storyboarded {
    static func instantiate(_ name: String) -> Self
    static func nib() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(_ name: String = "Main") -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
    
    static func nib() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        
        return Self(nibName: className, bundle: Bundle.main)
    }
}

extension UIViewController: Storyboarded { }
