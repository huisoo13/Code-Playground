//
//  ViewController.swift
//  swift-coordinator
//
//  Created by 정희수 on 4/15/25.
//

import UIKit

class ViewController: UIViewController {

    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func pushAction(_ sender: UIButton) {
        coordinator?.pushDetailViewController(animated: true)
    }
    
    @IBAction func presentAction(_ sender: UIButton) {
        coordinator?.presentDetailViewController(animated: true)
    }
}

