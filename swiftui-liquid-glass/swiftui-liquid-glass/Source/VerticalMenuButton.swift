//
//  VerticalMenuButton.swift
//  swiftui-liquid-glass
//
//  Created by Huisoo on 7/22/25.
//

import SwiftUI

struct VerticalMenuButton: View {
    @Binding var isExpanded: Bool
    @Binding var isAnimating: Bool
    
    @Namespace var glassNamespace

    var body: some View {
        GlassEffectContainer {
            ZStack {
                VStack(spacing: 16) {
                    if isExpanded {
                        VStack(spacing: 8) {
                            ForEach(ButtonType.allCases) { type in
                                Button {
                                    print("SELECT")
                                } label: {
                                    MenuButtonLabel(type: type)
                                }
                                .glassEffect(.clear, in: .rect(cornerRadius: 16))
                                .glassEffectID(type.label, in: glassNamespace)
                            }
                        }
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
                    .glassEffectID("menu", in: glassNamespace)
                    .disabled(isAnimating)

                }
            }
        }
    }
}

#Preview {
    @Previewable @State var isExpanded: Bool = false
    @Previewable @State var isAnimating: Bool = false
    ZStack {
        Color.gray.opacity(0.1)
        
        VerticalMenuButton(isExpanded: $isExpanded, isAnimating: $isAnimating)
    }
}
