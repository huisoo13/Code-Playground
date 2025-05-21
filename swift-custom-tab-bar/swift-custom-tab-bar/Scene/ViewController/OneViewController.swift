//
//  OneViewController.swift
//  Swift-Playground
//
//  Created by 정희수 on 5/21/25.
//

import UIKit

class OneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
    }
}

extension OneViewController: RootViewDelegate {
    func rootViewController(_ viewController: UIViewController) {
        viewController.title = "TAB 1"
    }
}
