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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}

extension TwoViewController: RootViewDelegate {
    func rootViewController(_ viewController: UIViewController) {
        viewController.title = "TAB 2"
    }
}

