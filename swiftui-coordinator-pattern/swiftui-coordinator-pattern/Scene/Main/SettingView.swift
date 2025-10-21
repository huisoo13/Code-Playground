//
//  SettingView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(AppCoordinator.self) var appCoordinator

    var body: some View {
        VStack(spacing: 16) {
            Button {
                appCoordinator.push(Main.Path.profile)
            } label: {
                Text("PUSH PROFILE")
            }
            
            Color.black
                .frame(height: 1)

            Button {
                appCoordinator.push(Main.Path.termsDetail)
            } label: {
                Text("PUSH TERMS DETAIL")
            }
            
            Color.black
                .frame(height: 1)

            Button {
                appCoordinator.reset()
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
}
