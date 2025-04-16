//
//  ChildCoordinator.swift
//  swift-coordinator
//
//  Created by 정희수 on 4/16/25.
//

import UIKit

class ChildCoordinator: Coordinator {
    var parentCoordinator: AppCoordinator?
    fileprivate var parent: UIViewController?

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()

    func start() {
        let viewController = ChildViewController.nib()
        viewController.coordinator = self
        
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController.modalPresentationStyle = .overCurrentContext
        
        self.parent = self.parentCoordinator?.navigationController.viewControllers.last
        self.parent?.present(self.navigationController, animated: true)
    }
    
    func finish() {
        self.parentCoordinator?.removeChildCoordinator(self)
        self.parent?.dismiss(animated: true)
    }
}
