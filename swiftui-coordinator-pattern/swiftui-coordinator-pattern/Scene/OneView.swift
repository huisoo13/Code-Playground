//
//  OneView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/25/25.
//

import SwiftUI

struct OneView: View {

    @Environment(Coordinator.self) var coordinator

    var body: some View {
        Text("Hello, World!")
            .navigationStyle("1",
                             leftToolBarItems: [.back],
                             rightToolBarItems: [
                                .custom(
                                    imageName: "circle",
                                    action: {
                                        coordinator.present(.sheet)
                                    }
                                )
                             ]
            )
    }
}

#Preview {
    OneView()
}
