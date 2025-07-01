//
//  ThreeView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/25/25.
//

import SwiftUI

struct ThreeView: View {
    
    @Environment(Coordinator.self) var coordinator

    var text: String  = ""
    
    var body: some View {
        Text(text)
            .navigationStyle("3",
                             leftToolBarItems: [.close],
                             rightToolBarItems: [
                                .custom(
                                    imageName: "circle",
                                    action: {
                                        coordinator.present(.overCurrentContext)
                                    }
                                )
                             ]
            )
    }
}

#Preview {
    ThreeView()
}
