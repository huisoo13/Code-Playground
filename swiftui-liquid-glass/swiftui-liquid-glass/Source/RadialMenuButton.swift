//
//  RadialMenuButton.swift
//  swiftui-liquid-glass
//
//  Created by Huisoo on 7/22/25.
//

import SwiftUI

struct RadialMenuButton: View {
    @Binding var isExpanded: Bool
    @Binding var isAnimating: Bool
    
    @Namespace var glassNamespace

    var body: some View {
        GlassEffectContainer {
            ZStack {
                ForEach(ButtonType.allCases) { type in
                    Button {
                        print("SELECT")
                    } label: {
                        MenuButtonLabel(type: type)
                            .opacity(isExpanded ? 1 : 0)
                    }
                    .glassEffect(.clear)
                    .glassEffectID(type.label, in: glassNamespace)
                    .offset(type.offset(expanded: isExpanded))
                    .animation(.spring(duration: 0.5, bounce: 0.2).delay(type.delay), value: isExpanded)
                }
                
                Button {
                    withAnimation {
                        isExpanded.toggle()
                        isAnimating.toggle()
                    } completion: {
                        isAnimating.toggle()
                    }
                } label: {
                    ToggleButtonLabel(isExpanded: isExpanded)
                }
                .glassEffect(.clear)
                .glassEffectID("toggle", in: glassNamespace)
                .disabled(isAnimating)
            }
        }
    }
}

#Preview {
    @Previewable @State var isExpanded: Bool = false
    @Previewable @State var isAnimating: Bool = false
    ZStack {
        Color.gray.opacity(0.1)
        
        RadialMenuButton(isExpanded: $isExpanded, isAnimating: $isAnimating)
    }
    
}
