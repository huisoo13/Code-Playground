//
//  ProfileView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(AppCoordinator.self) var appCoordinator
    @Environment(NavigationCoordinator.self) var navigationCoordinator

    enum ViewType: String {
        case create = "CREATE"
        case update = "UPDATE"
    }
    
    private let type: ViewType
    init(type: ViewType) {
        self.type = type
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(type.rawValue)
                .foregroundStyle(.blue)
            + Text(" PROFILE")

            Color.black
                .frame(height: 1)

            Button {
                switch type {
                case .create:
                    appCoordinator.set(.main)
                case .update:
                    navigationCoordinator.dismiss()
                }
            } label: {
                Text("DONE")
            }
        }
        .padding(.horizontal ,16)
        .foregroundStyle(.black)
        .navigationStyle("PROFILE", leftToolBarItems: [.back])
    }
}

#Preview {
    ProfileView(type: .create)
        .environment(AppCoordinator())
        .environment(NavigationCoordinator())
}
