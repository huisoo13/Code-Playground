//
//  ToggleButtonLabel.swift
//  swiftui-liquid-glass
//
//  Created by Huisoo on 7/22/25.
//

import SwiftUI

struct ToggleButtonLabel: View {
    var isExpanded: Bool
    
    var body: some View {
        Label(isExpanded ? "Hide Badges" : "Show Badges", systemImage: isExpanded ? "xmark" : "hexagon.fill")
            .foregroundStyle(.black)
            .font(.system(size: 16))
            .labelStyle(.iconOnly)
            .fontWeight(.medium)
            .imageScale(.large)
            .frame(width: 32, height: 32)
            .padding(8)
    }
}

#Preview {
    ToggleButtonLabel(isExpanded: false)
}
