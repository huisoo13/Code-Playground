//
//  PopupView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct PopupView: View {

    @Environment(AppCoordinator.self) var appCoordinator

    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .cornerRadius(8)
        .background()
        .padding(.horizontal, 20)
        .onTapGesture {
            appCoordinator.dismiss()
        }
    }
}

#Preview {
    PopupView()
        .environment(AppCoordinator())
}
