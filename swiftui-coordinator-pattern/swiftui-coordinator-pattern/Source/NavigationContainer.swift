//
//  NavigationContainer.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/24/25.
//

import SwiftUI

struct NavigationContainer<Content: View>: View {
    
    @Environment(AppCoordinator.self) var appCoordinator

    @State private var coordinator: NavigationCoordinator = NavigationCoordinator()
    
    private let id: UUID = UUID()
    private var content: Content
    init(parentCoordinator: NavigationCoordinator? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.coordinator.parentCoordinator = parentCoordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            content
                .navigationDestination(for: AnyHashable.self) { path in
                    ViewFactory.view(path)
                }
                .sheet(item: $coordinator.sheet, onDismiss: {
                    updateCoordinator()
                }) { sheet in
                    ViewFactory.sheet(sheet, parentCoordinator: coordinator)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover, onDismiss: {
                    updateCoordinator()
                }) { fullScreenCover in
                    ViewFactory.fullScreenCover(fullScreenCover, parentCoordinator: coordinator)
                }
        }
        .overCurrentContext(item: $coordinator.overCurrentContext, onDismiss: {
            updateCoordinator()
        }) { overCurrentContext in
            ViewFactory.overCurrentContext(overCurrentContext, parentCoordinator: coordinator)
        }
        .onAppear {
            updateCoordinator()
        }
        .onDisappear {
            appCoordinator.removeCoordinator(with: id)
        }
    }
    
    private func updateCoordinator() {
        appCoordinator.addNavigationCoordinator(coordinator, with: id)
    }
}
