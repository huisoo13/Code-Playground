//
//  ChildViewController.swift
//  swift-coordinator
//
//  Created by 정희수 on 4/16/25.
//

import UIKit

class ChildViewController: UIViewController {

    weak var coordinator: ChildCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishAction(_ sender: UIButton) {
        coordinator?.finish()
    }
}
