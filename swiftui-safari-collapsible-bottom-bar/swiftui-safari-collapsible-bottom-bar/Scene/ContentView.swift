//
//  ContentView.swift
//  swiftui-safari-collapsible-bottom-bar
//
//  Created by Huisoo on 11/4/26.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @State private var isMinimised: Bool = false
    @State private var safeArea: EdgeInsets = .init()
    @State private var progress: CGFloat = 0
    
    @GestureState private var isDragging: Bool = false
    
    @FocusState private var isFocused: Bool

    var body: some View {
        ScrollView(.vertical) {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 2000)
        }
        .scrollDismissesKeyboard(.interactively)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(.rect)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isDragging) { _, out, _ in
                    out = true
                }
                .onEnded { value in
                    onGestureEnd(value: value)
                }
        )
        .onScrollGeometryChange(for: CGFloat.self, of: {
            $0.contentOffset.y + $0.contentInsets.top
        }, action: { oldValue, newValue in
            guard isDragging else { return }
        })
        .safeAreaInset(edge: .bottom, spacing: 0) {
            SafariBottomBar(isFocused: $isFocused, text: $text, isMinimised: $isMinimised, progress: $progress, safeArea: safeArea) {
                SafariBottomAction(symbol: "chevron.left") {
                    
                }
                
                SafariBottomAction(symbol: "chevron.right") {
                    
                }
                
                SafariBottomAction(symbol: "square.and.arrow.up") {
                    
                }
                
                SafariBottomAction(symbol: "bookmark") {
                    
                }
                
                SafariBottomAction(symbol: "square.on.square") {
                    
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onGeometryChange(for: EdgeInsets.self) { proxy in
            proxy.safeAreaInsets
        } action: { newValue in
            safeArea = newValue
        }
    }
    
    private func handleScroll(oldValue: CGFloat, newValue: CGFloat) {
        guard !isFocused else { return }
        let delta = (newValue - oldValue) / transitaionDistance
        let progress = max(0, progress + (isMinimised ? -delta : delta))
        if progress >= 1 {
            withAnimation(animation) {
                isMinimised.toggle()
                self.progress = 0
            }
        } else {
            self.progress = 0
        }
    }
    
    private func onGestureEnd(value: DragGesture.Value) {
        guard !isFocused else { return }
        let velocity = -value.velocity.height * 0.1
        let velocityProgress = velocity / transitaionDistance
        
        let progress = progress + (isMinimised ? -velocityProgress : velocityProgress)
        withAnimation(animation) {
            if progress >= 0.5 {
                isMinimised.toggle()
            }
            
            self.progress = 0
        }
    }
    
    private var transitaionDistance: CGFloat {
        return 120
    }
    
    private var animation: Animation {
        .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
    }
}

#Preview {
    ContentView()
}
