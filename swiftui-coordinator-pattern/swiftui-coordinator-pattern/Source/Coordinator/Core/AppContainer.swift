//
//  AppContainer.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 10/21/25.
//

import SwiftUI

struct AppContainer<Content: View>: View {
    
    @Environment(AppCoordinator.self) var coordinator
    
    private var content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            if let root = coordinator.root {
                ViewFactory.root(root)
            } else {
                content
            }
        }
        .environment(coordinator)
    }
}
