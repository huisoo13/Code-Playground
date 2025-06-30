//
//  ContentView.swift
//  swiftui-custom-popup
//
//  Created by Huisoo on 6/30/25.
//

import SwiftUI

enum FullScreenContext: String, Identifiable {
    var id: String { self.rawValue }
    
    case fullScreenContext
}

struct ContentView: View {
    
    @State private var fullScreenContext: FullScreenContext?
    
    var body: some View {
        NavigationStack {
            Button(action: {
                fullScreenContext = .fullScreenContext
            }, label: {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
            })
        }
        .padding()
        .fullScreenContext(item: $fullScreenContext) { fullScreenContext in
            view(fullScreenContext)
        }
    }
    
    @ViewBuilder
    func view(_ fullScreenContext: FullScreenContext) -> some View {
        switch fullScreenContext {
        case .fullScreenContext:
            PopupView(item: $fullScreenContext)
        }
    }
}

#Preview {
    ContentView()
}
