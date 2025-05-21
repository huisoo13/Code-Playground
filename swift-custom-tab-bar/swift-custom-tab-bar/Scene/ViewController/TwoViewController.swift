//
//  TwoViewController.swift
//  Swift-Playground
//
//  Created by 정희수 on 5/21/25.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray5
    }
}

extension TwoViewController: RootViewDelegate {
    func rootViewController(_ viewController: UIViewController) {
        viewController.title = "TAB 2"
    }
}
