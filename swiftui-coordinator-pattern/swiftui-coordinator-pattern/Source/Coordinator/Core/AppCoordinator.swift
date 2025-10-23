//
//  AppCoordinator.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

@MainActor @Observable
class AppCoordinator {
    
    private var activeCoordinatorIDs: [AnyHashable] = []
    private var navigationCoordinators: [AnyHashable: NavigationCoordinator] = [:]
    private var navigationCoordinator: NavigationCoordinator? {
        // nil이 있다면 제거
        self.navigationCoordinators = navigationCoordinators.compactMapValues { $0 }
        
        guard let id = activeCoordinatorIDs.last else { return nil }
        return navigationCoordinators[id]
    }
    
    var root: AnyIdentifiable?
    
    // MARK: App
    
    func set(_ root: any Identifiable) {
        guard root is RootProtocol else {
            fatalError("Only values conforming to both Hashable and Root protocols are allowed for \(#function).")
        }
        
        withAnimation {
            navigationCoordinators.removeAll()
            self.root = AnyIdentifiable(root)
        }
    }
    
    func reset() {
        navigationCoordinators.removeAll()
        root = nil
    }
    
    func addNavigationCoordinator(_ coordinator: NavigationCoordinator, with id: AnyHashable) {
        activeCoordinatorIDs.append(id)
        navigationCoordinators[id] = coordinator
    }
    
    func removeCoordinator(with id: AnyHashable) {
        navigationCoordinators.removeValue(forKey: id)
        activeCoordinatorIDs.removeAll(where: { $0 == id })
    }
    
    // MARK: Navigation
    
    func push(_ destination: AnyHashable) {
        guard let navigationCoordinator else { return }
        navigationCoordinator.push(destination)
    }
    
    func present(_ destination: any Identifiable) {
        guard let navigationCoordinator else { return }
        navigationCoordinator.present(destination)
    }
    
    func dismiss() {
        guard let navigationCoordinator else { return }
        navigationCoordinator.dismiss()
    }
    
    func dismissAll() {
        guard let navigationCoordinator else { return }
        navigationCoordinator.dismissAll()
    }
}
