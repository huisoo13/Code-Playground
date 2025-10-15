//
//  HighlightContainer.swift
//  swiftui-view-highlight
//
//  Created by Huisoo on 10/15/25.
//


import SwiftUI

// PreferenceKey
fileprivate struct HighlightPreferenceKey: PreferenceKey {
    static var defaultValue: [Highlight] = []
    static func reduce(value: inout [Highlight], nextValue: () -> [Highlight]) {
        value.append(contentsOf: nextValue())
    }
}

fileprivate struct Highlight: Equatable {
    let id: AnyHashable
    let style: HighlightStyle
    let rect: CGRect
    let onDismiss: () -> Void
    
    static func == (lhs: Highlight, rhs: Highlight) -> Bool {
        lhs.id == rhs.id
    }
}

enum HighlightStyle {
    case circle(diameter: CGFloat, margin: CGFloat = 0)
    case roundedRectengle(cornerRadius: CGFloat, margin: CGFloat = 0)
}

struct HighlightView<Content: View>: View {
    
    @State var id: AnyHashable
    
    private(set) var style: HighlightStyle = .circle(diameter: 32)
    private(set) var onDismiss: () -> Void = { }

    let content: Content
    init(_ id: AnyHashable, @ViewBuilder content: @escaping () -> Content) {
        self.id = id
        self.content = content()
    }

    var body: some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: HighlightPreferenceKey.self,
                            value: [Highlight(id: id, style: style, rect: geometry.frame(in: .global), onDismiss: onDismiss)]
                        )
                })
    }
    
    func highlightStyle(_ style: HighlightStyle) -> Self {
        var newView = self
        newView.style = style
        return newView
    }
    
    func onHighlightsDismissed(_ perform: @escaping () -> Void) -> Self {
        var newView = self
        newView.onDismiss = perform
        return newView
    }
}

struct HighlightContainer<Content: View>: View {
    @Binding var id: AnyHashable?
    @State private var highlights: [Highlight] = []
    
    let content: Content
    init(_ id: Binding<AnyHashable?>, @ViewBuilder content: @escaping () -> Content) {
        self._id = id
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
                .onPreferenceChange(HighlightPreferenceKey.self) { highlights in
                    self.highlights = highlights
                }

            if let id,
               let highlight = highlights.first(where: { $0.id == id }) {
                ZStack {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                        .onTapGesture {
                            self.id = nil
                            highlight.onDismiss()
                        }

                    switch highlight.style {
                    case .circle(let diameter, let margin):
                        Circle()
                            .frame(width: diameter + margin, height: diameter + margin)
                            .position(x: highlight.rect.midX, y: highlight.rect.midY)
                            .blendMode(.destinationOut)
                    case .roundedRectengle(let radius, let margin):
                        RoundedRectangle(cornerRadius: radius)
                            .frame(width: highlight.rect.width + margin, height: highlight.rect.height + margin)
                            .position(x: highlight.rect.midX, y: highlight.rect.midY)
                            .blendMode(.destinationOut)
                    }
                }
                .compositingGroup()
                .ignoresSafeArea()
                .transition(.opacity.animation(.easeInOut(duration: 0.3)))
            }
        }
    }
}
