//
//  NavigationContainer.swift
//  SwiftUI-Playground
//
//  Created by Huisoo on 6/24/25.
//

import SwiftUI

struct NavigationContainer<Content: View>: View {
    
    @State private var coordinator = Coordinator()
    
    private var content: Content
    init(parentCoordinator: Coordinator? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.coordinator.parentCoordinator = parentCoordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            content
                .navigationDestination(for: Page.self) { page in
                    ViewFactory.view(page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    ViewFactory.view(sheet, parentCoordinator: coordinator)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                    ViewFactory.view(fullScreenCover, parentCoordinator: coordinator)
                }
        }
        .fullScreenContext(item: $coordinator.fullScreenContext) { fullScreenContext in
            ViewFactory.view(fullScreenContext, parentCoordinator: coordinator)
        }
        .environment(coordinator)
    }
}
