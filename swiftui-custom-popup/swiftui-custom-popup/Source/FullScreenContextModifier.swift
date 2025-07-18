//
//  FullScreenContextModifier.swift
//  swiftui-custom-popup
//
//  Created by Huisoo on 6/30/25.
//

import SwiftUI

struct OverScreenContextModifier<Item: Identifiable, PopupContent: View>: ViewModifier {

    @Binding var item: Item?
    
    let onDismiss: (() -> Void)?
    
    @ViewBuilder let popupContent: (Item) -> PopupContent
        
    @State private var itemToRender: Item?
    @State private var opacity: Double = 0.0
    
    // 애니메이션 지속 시간
    private let animationDuration = 0.3
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if let currentItem = itemToRender {
                        Color.black.opacity(0.25)
                            .ignoresSafeArea()
                            .onTapGesture {
                                self.item = nil
                            }
                        
                        popupContent(currentItem)
                    }
                }
                .opacity(opacity)
            )
            .onChange(of: item?.id) { _, newItemId in
                if newItemId != nil {
                    itemToRender = item
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        opacity = 1.0
                    }
                } else {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        opacity = 0.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                        itemToRender = nil
                        onDismiss?()
                    }
                }
            }
    }
}

extension View {
    func overScreenContext<Item: Identifiable, Content: View>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        modifier(
            OverScreenContextModifier(
                item: item,
                onDismiss: onDismiss,
                popupContent: content
            )
        )
    }
}
