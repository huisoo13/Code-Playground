//
//  ContentView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/25/25.
//

import SwiftUI

struct ContentView: View {

    @Environment(AppCoordinator.self) var appCoordinator
    
    var body: some View {
        ZStack {
            switch appCoordinator.root {
            case .splash:
                ViewFactory.view(Splash.Path.splash)
                    .transition(.asymmetric(insertion: .move(edge: .trailing),
                                            removal: .move(edge: .leading)))
            case .login:
                NavigationContainer {
                    ViewFactory.view(Login.Path.login)
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing),
                                        removal: .move(edge: .leading)))
            case .main:
                NavigationContainer {
                    ViewFactory.view(Main.Path.home)
                }
                .id(UUID()) // 해당 뷰로 전환 시 무조건 재생성
                .transition(.asymmetric(insertion: .move(edge: .trailing),
                                        removal: .move(edge: .leading)))
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AppCoordinator())
}
