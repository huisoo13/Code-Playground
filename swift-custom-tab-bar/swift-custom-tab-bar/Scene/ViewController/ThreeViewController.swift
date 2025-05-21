//
//  ThreeViewController.swift
//  Swift-Playground
//
//  Created by 정희수 on 5/21/25.
//

import UIKit

class ThreeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
    }
}

extension ThreeViewController: RootViewDelegate {
    func rootViewController(_ viewController: UIViewController) {
        viewController.title = "TAB 3"
    }
}
