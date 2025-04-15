//
//  AppCoordinator.swift
//  swift-coordinator
//
//  Created by 정희수 on 4/15/25.
//


import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
        
    // MARK: - Configure
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Start
    func start() {
        let viewController = ViewController.instantiate()
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: false)
    }
}
