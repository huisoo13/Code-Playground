//
//  TermsView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct TermsView: View {
    
    @Environment(AppCoordinator.self) var appCoordinator

    var body: some View {
        VStack(spacing: 16) {
            Button {
                appCoordinator.present(Login.Sheet.termsDetail)
            } label: {
                Text("OPEN DETAIL")
            }
            
            Color.black
                .frame(height: 1)

            Button {
                appCoordinator.push(Login.Path.profile)
            } label: {
                Text("NEXT")
            }
        }
        .padding(.horizontal ,16)
        .foregroundStyle(.black)
        .navigationStyle("TERMS", leftToolBarItems: [.back])
    }
}

#Preview {
    TermsView()
        .environment(AppCoordinator())
}
