//
//  MenuButtonLabel.swift
//  swiftui-liquid-glass
//
//  Created by Huisoo on 7/22/25.
//

import SwiftUI

struct MenuButtonLabel: View {
    var type: ButtonType = .home
    var body: some View {
        Image(systemName: type.systemImage)
            .foregroundStyle(.white)
            .fontWeight(.medium)
            .frame(width: 32, height: 32)
            .font(.system(size: 16))
            .background(content: {
                Image(systemName: "hexagon.fill")
                    .foregroundStyle(type.backgroundColor)
                    .font(.system(size: 32))
                    .frame(width: 32, height: 32)
            })
            .padding(10)
    }
}

#Preview {
    MenuButtonLabel()
}
