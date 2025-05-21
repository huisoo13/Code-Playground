//
//  FourViewController.swift
//  Swift-Playground
//
//  Created by 정희수 on 5/21/25.
//

import UIKit

class FourViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray3
    }
}

extension FourViewController: RootViewDelegate {
    func rootViewController(_ viewController: UIViewController) {
        viewController.title = "TAB 4"
    }
}
