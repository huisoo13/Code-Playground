//
//  ContentView.swift
//  swiftui-spotlight-onboarding
//
//  Created by Huisoo on 11/5/26.
//

import SwiftUI

let description: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry"

struct ContentView: View {
    @State private var showHighlightView: Bool = false
    @State private var group: [Int: Highlight] = [:]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    TextField("Search", text: .constant(""))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .glassEffect(.regular.interactive(), in: .capsule)
                        .highlight(
                            order: 1,
                            title: "Search Anything",
                            description: description,
                            maskShape: .capsule,
                            inset: 10,
                            group: $group
                        )

                    
                    Button("Show View") {
                        showHighlightView.toggle()
                    }
                }
                .padding(15)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                    }
                    .highlight(
                        order: 0,
                        title: "Stay in loop",
                        description: description,
                        maskShape: .circle,
                        inset: 30,
                        group: $group
                    )
                }
                
                ToolbarSpacer(.flexible, placement: .bottomBar)
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .highlight(
                        order: 2,
                        title: "Add new item",
                        description: description,
                        maskShape: .circle,
                        inset: 30,
                        group: $group
                    )
                }
            }
        }
        .highlightOverlay(isPresented: $showHighlightView, group: $group)
    }
}

#Preview {
    ContentView()
}
