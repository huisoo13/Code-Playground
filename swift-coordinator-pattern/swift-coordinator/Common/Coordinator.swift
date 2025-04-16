//
//  Coordinator.swift
//  swift-coordinator
//
//  Created by 정희수 on 2023/06/23.
//

/*
 Coordinator Pattern
 
 기존 ViewController에 있는 화면 전환 코드를 한곳에 모아 관리하기 쉽게 만드는 코딩 방식
 */

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
    
    func popToRootViewController(animated: Bool)
    func popViewController(animated: Bool)
    func dismiss(animated: Bool, completion: (()->Void)?)
    func removeLastDidPush()
    func removeLastWillPush()
    func removeChildCoordinator(_ childCoordinator: Coordinator?)
}

extension Coordinator {
    var isNavigationBarHidden: Bool {
        get {
            return self.navigationController.isNavigationBarHidden
        }
        
        set {
            self.navigationController.isNavigationBarHidden = newValue
        }
    }
    
    func setupInteractivePopGestureRecognizer() {
        /**
         더 이상 뒤로갈수 없을때 PopGestureRecognizer 비활성화
         
         관련 버그 링크: https://imjhk03.github.io/posts/enable-swipe-back-and-the-bug
         */
        self.navigationController.interactivePopGestureRecognizer?.isEnabled = self.navigationController.viewControllers.count > 1
    }
    
    // MARK: - Pop
    func popToRootViewController(animated: Bool) {
        self.navigationController.popToRootViewController(animated: animated)
    }
    
    func popViewController(animated: Bool) {
        self.navigationController.popViewController(animated: animated)
    }
    
    // MARK: - Dismiss
    func dismiss(animated: Bool, completion: (()->Void)? = nil) {
        self.navigationController.viewControllers.last?.dismiss(animated: animated, completion: completion)
    }
    
    // MARK: - Remove
    func removeLastDidPush() {
        self.navigationController.viewControllers.remove(at: self.navigationController.viewControllers.count - 2)
    }
    
    func removeLastWillPush() {
        self.navigationController.viewControllers.removeLast()
    }
    
    func removeChildCoordinator(_ childCoordinator: Coordinator?) {
        guard let index = self.childCoordinators.firstIndex(where: { coordinator in
            return coordinator === childCoordinator
        }) else { return }
        
        self.childCoordinators.remove(at: index)
    }
}
