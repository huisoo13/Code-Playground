//
//  SafariBottomBar.swift
//  swiftui-safari-collapsible-bottom-bar
//
//  Created by Huisoo on 11/4/26.
//

import SwiftUI

struct SafariBottomAction: Identifiable {
    private(set) var id: String = UUID().uuidString
    var symbol: String
    var action: () -> ()
}

@resultBuilder
struct SafariBottomActionBuilder {
    static func buildBlock(_ components: SafariBottomAction...) -> [SafariBottomAction] {
        components
    }
}

struct SafariBottomBar: View {
    @FocusState.Binding var isFocused: Bool

    @Binding var text: String
    @Binding var isMinimised: Bool
    @Binding var progress: CGFloat
    var safeArea: EdgeInsets
    
    @SafariBottomActionBuilder var actions: [SafariBottomAction]
    
    /// View Properties
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: isMinimised ? 0 : 10) {
            ZStack {
                if isMinimised {
                    Text(text.isEmpty ? "Search here" : text)
                        .font(isMinimised ? .caption : .body)
                        .foregroundStyle(text.isEmpty ? .secondary : .primary)
                        .lineLimit(1)
                        .padding(.horizontal, 20)
                } else {
                    Capsule()
                        .fill(.clear)
                }
            }
            .frame(height: isMinimised ? 32 : 45)

            HStack(spacing: 0) {
                ForEach(actions) { action in
                    actionView(action )
                }
            }
            .compositingGroup()
            .opacity(isMinimised ? 0 : 1)
            .blur(radius: isMinimised ? 10 : 0)
            .frame(width: isMinimised ? 0 : nil, height: isMinimised ? 0 : nil, alignment: .top)
            .padding(.horizontal, isMinimised ? 0 : -15)
        }
        .geometryGroup()
        .padding(isMinimised ? 0 : 18)
        .clipShape(.rect(cornerRadius: 30))
        .overlay {
            if isMinimised {
                Rectangle()
                    .foregroundStyle(.clear)
                    .contentShape(.rect)
                    .onTapGesture {
                        isMinimised = false
                    }
                    .transition(.identity)
            }
        }
        .glassEffect(.regular.interactive(isMinimised), in: ConcentricRectangle(corners: .concentric(minimum: .fixed(30)), isUniform: true))
        .animation(animation.speed(1.5), body: {
            $0.opacity(isFocused ? 0 : 1)
        })
        .overlay(alignment: isFocused ? .bottom : .top) {
            searchBar()
                .padding(isFocused || isMinimised ? 0 : 18)
                .opacity(isMinimised ? 0 : 1)
                .allowsHitTesting(!isMinimised)
        }
        .padding([.horizontal, .bottom], 18)
        .scaleEffect(1 + (isMinimised ? 0.1 : -0.1) * progress, anchor: .bottom)
        .frame(maxWidth: isMinimised ? 180 : nil)
        .animation(animation, value: isMinimised)
    }
    
    @ContentBuilder
    private func searchBar() -> some View {
        ZStack(alignment: .leading) {
            Image(systemName: "magnifyingglass")
                .font(.callout)
                .opacity(isFocused ? 0 : 1)
            
            TextField("Search Here", text: $text)
                .padding(.leading, isFocused ? 0 : 30)
        }
        .padding(.horizontal, 15)
        .frame(height: isMinimised ? 32 : 45)
        .background {
            if colorScheme == .dark {
                Capsule()
                    .fill(.black)
            } else {
                Capsule()
                    .fill(.regularMaterial)
            }
        }
        .tint(Color.white)
        .environment(\.colorScheme, .dark)
        .padding(.trailing, isFocused ? 55 : 0)
        .background(alignment: .trailing) {
            Button {
                isFocused = false
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 20, height: 30)
            }
            .buttonStyle(.glass)
            .animation(animation.speed(2)) {
                $0.opacity(isFocused ? 1 : 0)
            }
        }
        .focused($isFocused)
        .offset(y: isFocused ? -safeArea.bottom : 0)
        .animation(animation, value: isFocused)
    }
    
    @ContentBuilder
    private func actionView(_ action: SafariBottomAction) -> some View {
        Button {
            action.action()
        } label: {
            Image(systemName: action.symbol)
                .font(.title3)
                .frame(width: 45, height: 45)
                .foregroundStyle(Color.primary)
                .contentShape(.rect)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var animation: Animation {
        .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
    }
}

#Preview {
    ContentView()
}
