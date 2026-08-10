//
//  ContentView.swift
//  swiftui-stacked-toast
//
//  Created by Huisoo on 8/10/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var glassTintOpacity: CGFloat = 0.5
    @State private var containerToasts: [Toast] = []
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab("1", systemImage: "xmark") {
                    List {
                        Section("Glass tint opacity") {
                            Slider(value: $glassTintOpacity)
                        }
                        
                        Section("Action ") {
                            Button("Add Toast", action: addToast)
                        }
                    }
                    .navigationTitle("Toast")
                }
                
                Tab("2", systemImage: "xmark") {
                    Color.blue
                }
            }
            .overlay(alignment: .bottom) {
                StackedToast(glassTintOpacity: glassTintOpacity, toasts: $containerToasts)
                    .safeAreaPadding(.bottom, 16)
            }

        }
    }
    
    func addToast() {
        let toast = Toast(symbol: "xmark", title: "Toast", description: "aaaaaaa", tintColor: .red, autoDismissInterval: 2)
        
        containerToasts.append(toast)
    }
}

#Preview {
    ContentView()
}
