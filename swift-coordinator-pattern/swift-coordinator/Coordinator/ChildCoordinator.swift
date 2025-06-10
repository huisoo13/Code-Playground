//
//  ChildCoordinator.swift
//  swift-coordinator
//
//  Created by 정희수 on 4/16/25.
//

import UIKit

class ChildCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()

    func start() {
        let viewController = ChildViewController.nib()
        viewController.coordinator = self
        
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController.modalPresentationStyle = .overCurrentContext
        
        let parent = self.parentCoordinator?.navigationController.viewControllers.last
        parent?.present(self.navigationController, animated: true)
    }
    
    func finish() {
        self.parentCoordinator?.removeChildCoordinator(self)
        self.parentCoordinator?.dismiss(animated: true)
    }
}
