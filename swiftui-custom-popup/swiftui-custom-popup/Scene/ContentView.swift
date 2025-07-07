//
//  ContentView.swift
//  swiftui-custom-popup
//
//  Created by Huisoo on 6/30/25.
//

import SwiftUI

enum OverScreenContext: String, Identifiable {
    var id: String { self.rawValue }
    
    case overScreenContext
}

struct ContentView: View {
    
    @State private var overScreenContext: OverScreenContext?
    
    var body: some View {
        NavigationStack {
            Button(action: {
                overScreenContext = .overScreenContext
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
        .overScreenContext(item: $overScreenContext) { overScreenContext in
            view(overScreenContext)
        }
    }
    
    @ViewBuilder
    func view(_ overScreenContext: OverScreenContext) -> some View {
        switch overScreenContext {
        case .overScreenContext:
            PopupView(item: $overScreenContext)
        }
    }
}

#Preview {
    ContentView()
}
