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
    
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor.systemBackground
        navigationBarAppearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appCoordinator)
        }
    }
}
