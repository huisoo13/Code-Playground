//
//  swiftui_coordinator_patternApp.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/25/25.
//

import SwiftUI

@main
struct swiftui_coordinator_patternApp: App {
    
    var appCoordinator: AppCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appCoordinator)
        }
    }
}
