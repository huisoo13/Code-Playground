//
//  ContentView.swift
//  swiftui-chat-view
//
//  Created by Huisoo on 9/17/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ChatView()
                .navigationTitle("Chat App")
                .toolbarTitleDisplayMode(.inlineLarge)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Options", systemImage: "ellipsis") {
                            
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
