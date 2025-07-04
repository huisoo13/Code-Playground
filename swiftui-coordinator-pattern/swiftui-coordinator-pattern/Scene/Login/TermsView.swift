//
//  TermsView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

struct TermsView: View {
    
    @Environment(NavigationCoordinator.self) var navigationCoordinator

    var body: some View {
        VStack(spacing: 16) {
            Button {
                navigationCoordinator.present(Login.Sheet.termsDetail)
            } label: {
                Text("OPEN DETAIL")
            }
            
            Color.black
                .frame(height: 1)

            Button {
                navigationCoordinator.push(Login.Path.profile)
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
        .environment(NavigationCoordinator())
}
