//
//  SplashView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct SplashView: View {
    
    @Environment(AppCoordinator.self) var appCoordinator

    var body: some View {
        Text("SPLASH")
            .task { @MainActor in
                try? await Task.sleep(for: .seconds(2))
                appCoordinator.set(.login)
            }
    }
}

#Preview {
    SplashView()
        .environment(AppCoordinator())
}
