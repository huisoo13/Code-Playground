//
//  LoginView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AppCoordinator.self) var appCoordinator
    @Environment(NavigationCoordinator.self) var navigationCoordinator

    var body: some View {
        VStack(spacing: 16) {
            Button {
                appCoordinator.set(.main)
            } label: {
                Text("LOGIN")
            }
            
            Color.black
                .frame(height: 1)

            Button {
                navigationCoordinator.push(Login.Path.terms)
            } label: {
                Text("SIGN UP")
            }
        }
        .padding(.horizontal ,16)
        .foregroundStyle(.black)
        .background()
        .navigationStyle("LOGIN")
    }
}

#Preview {
    LoginView()
        .environment(AppCoordinator())
        .environment(NavigationCoordinator())
}
