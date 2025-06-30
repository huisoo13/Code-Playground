//
//  TwoView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/25/25.
//

import SwiftUI

struct TwoView: View {
    
    @Environment(Coordinator.self) var coordinator

    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Hello, World!!")
            Text("Hello, World!!!")
            Text("Hello, World!!!!")
        }
        .navigationStyle("2",
                         leftToolBarItems: [.back],
                         rightToolBarItems: [
                            .custom(
                                imageName: "circle",
                                action: {
                                    coordinator.push(.three("AAA"))
                                }
                            )
                         ]
        )
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
    TwoView()
        .environment(Coordinator())
}
