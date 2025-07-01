//
//  ContentView.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/25/25.
//

import SwiftUI

struct ContentView: View {

    @Environment(Coordinator.self) var coordinator

    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
            
            HStack {
                Button {
                    coordinator.push(.one)
                } label: {
                    Text("Push")
                    .frame(width: 64, height: 64)
                    .background()
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                }
                
                Button {
                    coordinator.present(.sheet)
                } label: {
                    Text("Sheet")
                    .frame(width: 64, height: 64)
                    .background()
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                }
                
                Button {
                    coordinator.present(.fullScreenCover)
                } label: {
                    Text("Cover")
                        .frame(width: 64, height: 64)
                        .background()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }

                Button {
                    coordinator.present(.overCurrentContext)
                } label: {
                    Text("Context")
                        .frame(width: 64, height: 64)
                        .background()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationStyle("TITLE",
                         rightToolBarItems: [
                            .custom(
                                imageName: "circle",
                                action: {
                                    coordinator.push(.one)
                                }
                            )
                         ]
        )
    }
}

#Preview {
    ContentView()
        .environment(Coordinator())
}
