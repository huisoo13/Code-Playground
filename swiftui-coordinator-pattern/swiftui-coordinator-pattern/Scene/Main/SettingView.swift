//
//  SettingView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(AppCoordinator.self) var appCoordinator
    @Environment(NavigationCoordinator.self) var navigationCoordinator

    var body: some View {
        VStack(spacing: 16) {
            Button {
                navigationCoordinator.push(Main.Path.profile)
            } label: {
                Text("PUSH PROFILE")
            }
            
            Color.black
                .frame(height: 1)

            Button {
                navigationCoordinator.push(Main.Path.termsDetail)
            } label: {
                Text("PUSH TERMS DETAIL")
            }
            
            Color.black
                .frame(height: 1)

            Button {
                appCoordinator.set(.login)
            } label: {
                Text("SIGN OUT")
                    .foregroundStyle(.red)
            }
        }
        .padding(.horizontal ,16)
        .foregroundStyle(.black)
        .navigationStyle("SETTING", leftToolBarItems: [.back])
    }
}

#Preview {
    SettingView()
        .environment(AppCoordinator())
        .environment(NavigationCoordinator())
}
