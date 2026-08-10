//
//  StackedToast.swift
//  swiftui-stacked-toast
//
//  Created by Huisoo on 8/10/26.
//

import SwiftUI

struct Toast: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var symbol: String
    var title: String
    var description: String
    var tintColor: Color
    var autoDismissInterval: Double? = nil
}

struct StackedToast: View {
    
    var glassTintOpacity: CGFloat = 0
    
    @Binding var toasts: [Toast]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(toasts.reversed()) { toast in
                    let index = toasts.firstIndex(of: toast) ?? 0
                    
                    ToastView(glassTintOpacity: glassTintOpacity, toast: toast) {
                        toasts.removeAll(where: { $0.id == toast.id })
                    }
                    .visualEffect({ content, proxy in
                        let minY = proxy.frame(in: .scrollView).minY
                        let progress = minY / 64 /// ToastView height
                        let offset = min(progress * 10, 20)
                        let scale = min(progress * 0.05, 0.1)
                        
                        return content
                            .scaleEffect(1 - scale, anchor: .bottom)
                            .offset(y: -minY)
                            .offset(y: offset)
                    })
                    .zIndex(Double(index))
                    /// If toast is at top, use -500 offset.
                    .transition(.asymmetric(insertion: .offset(y: 500).combined(with: AnyTransition(.blurReplace)), removal: .move(edge: .leading).combined(with: AnyTransition(.blurReplace))))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .scrollDisabled(true)
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .frame(height: 90)
        .offset(y: 26 - max(min(CGFloat(toasts.count - 1) * 13, 26), 0)) /// 90 - 64 = 26
        .background {
            ScrollView(.vertical) { }
                .frame(height: 0)
                .allowsHitTesting(false)
                .safeAreaBar(edge: .bottom, spacing: 0) {
                    Text(" ")
                        .frame(maxWidth: .infinity)
                        .frame(height: 90)
                }
                .scrollEdgeEffectStyle(.soft, for: .bottom)
                .opacity(toasts.isEmpty ? 0 : 1)
        }
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: toasts)
        .allowsHitTesting(!toasts.isEmpty)
    }
}

fileprivate struct ToastView: View {
    var glassTintOpacity: CGFloat
    var toast: Toast
    var onDismiss: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: toast.symbol)
                .font(.title)
                .foregroundStyle(toast.tintColor.gradient)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(toast.title)
                    .font(.callout)
                    .foregroundColor(Color.primary)
                
                Text(toast.description)
                    .font(.caption2)
                    .foregroundColor(Color.secondary)
            }
            .lineLimit(1)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: 310, alignment: .leading)
        .frame(height: 64)
        .background {
            let row1 = Array(repeating: toast.tintColor.opacity(0.15), count: 3)
            let row2 = Array(repeating: toast.tintColor.opacity(0.1), count: 3)
            let row3 = Array(repeating: Color.clear, count: 3)
            
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [0.5, 0.5], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1],
                ],
                colors: row1 + row2 + row3
            )
            .clipShape(.capsule)
        }
        .glassEffect(.regular.tint(glassTint), in: .capsule)
        .contentShape(.capsule)
        .compositingGroup()
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 10)
        /// VStack supported swipe action from iOS 27+
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(action: onDismiss) {
                Image(systemName: "checkmark")
            }
            .tint(toast.tintColor)
        }
        .task {
            guard let autoDismissInterval = toast.autoDismissInterval else { return }
            try? await Task.sleep(for: .seconds(autoDismissInterval))
            if !Task.isCancelled {
                onDismiss()
            }
        }
    }
    
    var glassTint: Color {
        colorScheme == .dark
        ? Color.black
        : Color.white.opacity(glassTintOpacity)
    }
}

#Preview {
    ContentView()
}
