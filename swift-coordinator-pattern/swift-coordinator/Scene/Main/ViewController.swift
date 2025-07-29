//
//  ViewController.swift
//  swift-coordinator
//
//  Created by 정희수 on 4/15/25.
//

import UIKit

class ViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(foo)),
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(bar))
        ]
    }
    
    @objc func foo() {
        
    }
    
    @objc func bar() {
        
    }
    
    @IBAction func pushAction(_ sender: UIButton) {
        coordinator?.pushDetailViewController(animated: true)
    }
    
    @IBAction func presentAction(_ sender: UIButton) {
        coordinator?.presentChildViewController(animated: true)
    }
}

