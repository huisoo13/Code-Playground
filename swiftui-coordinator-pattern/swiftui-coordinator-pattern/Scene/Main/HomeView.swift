//
//  HomeView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(AppCoordinator.self) var appCoordinator

    var body: some View {
        VStack(spacing: 16) {
            Button {
                appCoordinator.push(Main.Path.setting)
            } label: {
                Text("PUSH SETTING")
            }
            
            Color.black
                .frame(height: 1)

            Button {
                appCoordinator.present(Main.OverCurrentContext.popup)
            } label: {
                Text("POPUP")
            }
        }
        .padding(.horizontal ,16)
        .foregroundStyle(.black)
        .navigationStyle("HOME")
    }
}

#Preview {
    HomeView()
        .environment(AppCoordinator())
}
