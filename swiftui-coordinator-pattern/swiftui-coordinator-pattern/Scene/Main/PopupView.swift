//
//  PopupView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct PopupView: View {

    @Environment(NavigationCoordinator.self) var coordinator

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
            coordinator.dismiss()
        }
    }
}

#Preview {
    PopupView()
        .environment(NavigationCoordinator())
}
