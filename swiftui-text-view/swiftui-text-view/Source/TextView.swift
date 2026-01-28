//
//  TextView.swift
//  swiftui-text-view
//
//  Created by Huisoo on 1/28/26.
//

import SwiftUI

struct TextView: View {
    /// Defines the height behavior policy for the TextView
    ///
    /// This policy controls how the text view handles its vertical size.
    /// You can choose between a flexible height that grows with content
    /// or a fixed height that remains constant.
    enum Option {
        case flexible(_ lineLimit: Int? = nil)
        case fixed(_ height: CGFloat)
    }
    
    /// PreferenceKey for calculating minHeight
    private struct MinimumHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    @State private var minHeight: CGFloat = 0

    @Binding private var text: String
    
    private let placeholder: String
    private let option: Option
    
    private let lineLimit: Int?
    private let height: CGFloat?

    /// Creates a new instance of TextView.
    ///
    /// Use this initializer to create a text view with a specific height behavior.
    /// If you choose the `.flexible` option without a limit, the view will expand indefinitely.
    init(_ placeholder: String, text: Binding<String>, option: Option = .flexible()) {
        self.placeholder = placeholder
        self._text = text
        self.option = option
        
        switch option {
        case .flexible(let lineLimit):
            self.lineLimit = lineLimit
            self.height = nil
        case .fixed(let height):
            self.lineLimit = nil
            self.height = height
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            // For calculating minHeight
            Text(" ")
                .hidden()
                .background {
                    GeometryReader { proxy in
                        Color.clear.preference(
                            key: MinimumHeightKey.self,
                            value: proxy.size.height
                        )
                    }
                }
                .onPreferenceChange(MinimumHeightKey.self) { height in
                    self.minHeight = height
                }
            
            // Using calculate the actual contentHeight
            Text(text)
                .lineLimit(lineLimit)
                .frame(height: height)
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .hidden()
                .fixedSize(horizontal: false, vertical: true)
                .layoutPriority(1)
                .allowsHitTesting(false)
            
            // Actually displayed
            TextField(placeholder, text: $text, axis: .vertical)
                .textFieldStyle(.plain)
        }
    }
}
