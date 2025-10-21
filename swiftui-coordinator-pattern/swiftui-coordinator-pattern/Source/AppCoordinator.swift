//
//  AppCoordinator.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

@MainActor @Observable
class AppCoordinator {
    
    private var id: AnyHashable?
    private var navigationCoordinators: [AnyHashable: NavigationCoordinator] = [:]
    private var navigationCoordinator: NavigationCoordinator? {
        self.navigationCoordinators = navigationCoordinators.compactMapValues { $0 }
        return navigationCoordinators.first(where: { $0.key == id })?.value
    }
    
    var root: AnyIdentifiable?
    
    // MARK: App
    
    func set(_ root: any Identifiable) {
        guard root is RootProtocol else {
            fatalError("Only values conforming to both Hashable and Root protocols are allowed for \(#function).")
        }
        
        withAnimation {
            navigationCoordinators.values.forEach { $0.dismissAll() }
            navigationCoordinators.removeAll()
            self.root = AnyIdentifiable(root)
        }
    }
    
    func reset() {
        navigationCoordinators.values.forEach { $0.dismissAll() }
        navigationCoordinators.removeAll()
        root = nil
    }
    
    func addNavigationCoordinator(_ coordinator: NavigationCoordinator, with id: AnyHashable) {
        self.id = id
        navigationCoordinators[id] = coordinator
    }
    
    func removeCoordinator(with id: AnyHashable) {
        navigationCoordinators.removeValue(forKey: id)
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
