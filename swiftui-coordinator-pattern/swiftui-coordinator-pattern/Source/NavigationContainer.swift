//
//  NavigationContainer.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/24/25.
//

import SwiftUI

struct NavigationContainer<Content: View>: View {
    
    @State private var coordinator: NavigationCoordinator = NavigationCoordinator()
    
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
                .sheet(item: $coordinator.sheet) { sheet in
                    ViewFactory.sheet(sheet, parentCoordinator: coordinator)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                    ViewFactory.fullScreenCover(fullScreenCover, parentCoordinator: coordinator)
                }
        }
        .overCurrentContext(item: $coordinator.overCurrentContext) { overCurrentContext in
            ViewFactory.overCurrentContext(overCurrentContext, parentCoordinator: coordinator)
        }
        .environment(coordinator)
    }
}
